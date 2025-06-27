import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_userapp/screens/splash.dart';
import 'package:new_userapp/values/values.dart';
import 'bloc/user/user_bloc.dart';
import 'fetchData/fetch_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColour,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: appBarColour,
            foregroundColor: Colors.white,
            elevation: 4, // Optional: control shadow
          ),
          cardTheme: CardTheme(
            color: tileColour,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


