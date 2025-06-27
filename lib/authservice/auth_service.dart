import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') == username &&
        prefs.getString('password') == password;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String> loadUsernamePassword(int type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(type == 1 ? 'username' : 'password') ?? '';
    return username;
  }

  Future<void> changePassword(String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', newPassword);
  }
}