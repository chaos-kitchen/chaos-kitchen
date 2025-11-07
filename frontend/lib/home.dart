import 'package:chaos_kitchen/components/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const Text(
              'Chaos Kitchen',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
            ),
            UIButton(
              onPressed: () {
                final newRoomId = const Uuid().v4();
                context.push("/room/$newRoomId");
              },
              child: const Text('Create game'),
            ),
            UIButton(
              onPressed: () {
                context.push("/join-room");
              },
              child: const Text('Join game'),
            ),
            UIButton(
              onPressed: () {
                context.push("/options");
              },
              child: const Text('Options'),
            ),
          ],
        ),
      ),
    );
  }
}
