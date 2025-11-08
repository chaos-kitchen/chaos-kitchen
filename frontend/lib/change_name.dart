import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:flutter/material.dart';

class ChangePlayerNameScreen extends StatefulWidget {
  final void Function(String) onNameChanged;

  const ChangePlayerNameScreen({super.key, required this.onNameChanged});

  @override
  State<ChangePlayerNameScreen> createState() => _ChangePlayerNameScreenState();
}

class _ChangePlayerNameScreenState extends State<ChangePlayerNameScreen> {
  TextEditingController codeController = TextEditingController();

  Future<void> onChangeName(BuildContext context) async {
    final playerName = codeController.text.trim();
    if (playerName.isEmpty) {
      showErrorSnackbar(context, 'Player name cannot be empty');
      return;
    }

    widget.onNameChanged(playerName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter your name')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter player name',
                ),
                autocorrect: false,
                enableSuggestions: false,
                autofocus: true,
                onSubmitted: (_) => onChangeName(context),
              ),
            ),
            UIButton(
              onPressed: () => onChangeName(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
