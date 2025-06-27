import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_userapp/bloc/user/user_bloc.dart';
import 'package:new_userapp/screens/profile_screen.dart';
import 'package:new_userapp/screens/view_screen.dart';
import 'package:new_userapp/values/values.dart';
import 'package:new_userapp/widgets/searchBar.dart';
import '../bloc/user/user_event.dart';
import '../bloc/user/user_state.dart';
import '../model/user_model.dart';
import '../widgets/custom_tilecard.dart';
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  List<User> usersList = [],firstList = [];
  int stopScroll = 0,pageNo = 1;
  late UserBloc userBloc;

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if(stopScroll == 0){
          pageNo += 1;
          userBloc.add(LoadUsers(pageNo));
          print("hi");
          stopScroll = 1;
        }
      }
    });
  }

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(LoadUsers(pageNo));// Calls Bloc to fetch data from Api
    _setupScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColour,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('SMARTMART',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 5,),
            Text('Users', style: TextStyle(fontSize: 17, color: Colors.white70,),),
          ],
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const ProfilePage();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/mohanlal.jpeg'), // or NetworkImage
                  ),
                  SizedBox(height: 4),
                  Text('Profile', style: TextStyle(fontSize: 12, color: Colors.white70,),),
                ],
              ),
            ),
          ),
        ],
        toolbarHeight: appBarHeight(screenHeight,0.2),
      ),
      body: BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
            if(state is UserError){
              return Center(child: Text('Error: ${state.message}'));
            }else if(state is SearchLoaded){
              usersList = state.users ?? [];
            }else if(state is UserLoaded) {
              stopScroll = 0;
              firstList = state.users ?? [];
              usersList.addAll(firstList);
            }
            return RefreshIndicator(
              onRefresh: () async{
                pageNo = 1;
                usersList.clear();
                userBloc.add(LoadUsers(1));
                await Future.delayed(const Duration(milliseconds: 300));
              },
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      const SizedBox(height: 20,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemCount: usersList.length + 1,
                        itemBuilder: (context, index) {
                          if(index == usersList.length) {
                            return firstList.isNotEmpty ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            ) : const SizedBox.shrink();
                          }else{
                            User user = usersList[index];
                            return UserTile(
                              user: user,
                              onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return FullScreenUserViewer(userData: user,);
                              }));
                            },);
                          }
                        },
                      ),
                      const SizedBox(height: 300,)
                    ],
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child:SearchBar(
                        onSearch: (search){
                         if(search.isNotEmpty){
                            userBloc.add(SearchUsers(search));
                          }
                         },
                        onClose: (show){
                        if(!show && usersList.length <= 6){
                          usersList.clear();
                          pageNo = 1;
                          userBloc.add(LoadUsers(1));
                       }
                    },
                  )
                 )
                ],
              ),
            );
        },
      ),
    );
  }
}
