import 'package:chaos_kitchen/components/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            UIButton(
              onPressed: () {
                GoRouter.of(context).push('/change-name');
              },
              child: Text("Change name"),
            ),
          ],
        ),
      ),
    );
  }
}
