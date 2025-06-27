import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../authservice/auth_service.dart';
import '../screens/users_screen.dart';
import '../values/values.dart';
import '../widgets/logo_smartmart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,required this.isLogin});

  final bool isLogin;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final AuthService _auth = AuthService();

  void handleAuth() async {
    final name = _username.text;
    final pass = _password.text;

    bool success = isLogin
        ? await _auth.login(name, pass)
        : await _auth.register(name, pass).then((_) => true);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isLogin ? 'Welcome back!' : 'Registration successful!'))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return UserList();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials'))
      );
    }
  }

  @override
  void initState() {
    isLogin = widget.isLogin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColour,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isLogin ? 'Login' : 'Sign Up', style:GoogleFonts.poppins(
                    fontSize: 32,
                    color: headingColour,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 20),
                  TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
                  TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleAuth,
                    child: Text(isLogin ? 'Login' : 'Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                        _username.clear();
                        _password.clear();
                      });
                    },
                    child: Text(isLogin ? 'No account? Sign up' : 'Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
           const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: SmartMartLogo(size: 70)
            ),
          ),
        ],
      ),
    );
  }
}