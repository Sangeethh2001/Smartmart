import 'package:flutter/material.dart';

import '../model/user_model.dart';

class FullScreenUserViewer extends StatelessWidget {
  const FullScreenUserViewer({super.key,required this.userData});

  final User userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  userData.avatar,
                  fit: BoxFit.cover,
                  color: Colors.black45,
                  colorBlendMode: BlendMode.darken,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${userData.firstName} ${userData.lastName}',
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(userData.email, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text('ID: ${userData.id}', style: const TextStyle(color: Colors.white60)),
                      ],
                    ),
                  ),
                ),
              ],
            )
    );
  }
}