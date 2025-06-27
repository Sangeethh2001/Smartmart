import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserTile({Key? key, required this.user, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
          backgroundColor: Colors.grey[300],
        ),
        title: Text(user.firstName),
        subtitle: Text('User ID: ${user.id}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap
      ),
    );
  }
}