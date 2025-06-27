import 'package:flutter/material.dart';
import 'package:new_userapp/authservice/auth_service.dart';

import '../login/login_page.dart';
import '../values/values.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  AuthService authService = AuthService();
  bool isExpanded = false,showPwd = true;
  TextEditingController passwordController = TextEditingController();

  void getUserNamePwd() async {
    userName = await authService.loadUsernamePassword(1);
    passwordController.text = await authService.loadUsernamePassword(2);
    setState(() {
    });
  }

  @override
  void initState() {
    getUserNamePwd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColour,
      appBar: AppBar(title: const Text('Profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        toolbarHeight: appBarHeight(screenHeight,0.1),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - appBarHeight(screenHeight,0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/mohanlal.jpeg'), // or use NetworkImage
              ),
              const SizedBox(height: 12),
              Text(
                userName,
                style: const TextStyle(fontSize: 20, color: Colors.black54,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ExpansionTile(
                title: const Text('Change Password'),
                leading: const Icon(Icons.lock_outline),
                trailing: Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isExpanded = expanded;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: passwordController,
                          obscureText: showPwd,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPwd ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPwd = !showPwd;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (passwordController.text.isNotEmpty) {
                              authService.changePassword(passwordController.text); // Call your method
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password updated')),
                              );
                              setState(() {
                                passwordController.clear();
                              });
                            }
                          },
                          child: const Text('Update Password'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ElevatedButton.icon(
                  onPressed: () async{
                    await authService.logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout Successfully')),
                    );
                    Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => const LoginPage(isLogin: false,)),
                          (Route<dynamic> route) => false,
                    );

                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}