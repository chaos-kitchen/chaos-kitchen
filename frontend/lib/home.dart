import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/utils/config.dart';
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
            if (AppConfig.showDebugJoinGameButton)
              UIButton(
                onPressed: () {
                  context.push("/room/4e116b65-37e2-43a5-9f6e-98efab721514");
                },
                color: const Color(0xffff96a8),
                child: const Text('[Debug] Join game'),
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
