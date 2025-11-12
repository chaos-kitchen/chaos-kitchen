import 'package:chaos_kitchen/home.dart';
import 'package:chaos_kitchen/join_room.dart';
import 'package:chaos_kitchen/options.dart';
import 'package:chaos_kitchen/room.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/room/:roomId',
        builder: (context, state) =>
            RoomScreen(initialRoomId: state.pathParameters['roomId'] ?? ''),
      ),
      GoRoute(
        path: '/join-room',
        builder: (context, state) => const JoinRoomScreen(),
      ),
      GoRoute(
        path: '/options',
        builder: (context, state) => const OptionsScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
