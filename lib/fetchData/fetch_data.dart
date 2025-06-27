import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserRepository {
  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$page'),
      headers: {
        'x-api-key': 'reqres-free-v1',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> searchAllUsers(String query) async {
    List<User> matched = [];
    int page = 1;
    bool hasMore = true;

    while (hasMore) {
      final response = await fetchUsers(page);
      final users = response;
      hasMore = users.isNotEmpty ? true : false;
      if(hasMore) {
        final filtered = users.where((user) =>
                user.firstName.toLowerCase().contains(query.toLowerCase()) ||
                user.lastName.toLowerCase().contains(query.toLowerCase()) ||
                user.id.toString().toLowerCase().contains(query.toLowerCase())).toList();

        matched.addAll(filtered);
        page++;
      }
    }

    return matched;
  }
}