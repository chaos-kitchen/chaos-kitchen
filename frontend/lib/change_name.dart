import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePlayerNameScreen extends StatefulWidget {
  final String roomId;

  const ChangePlayerNameScreen({super.key, required this.roomId});

  @override
  State<ChangePlayerNameScreen> createState() => _ChangePlayerNameScreenState();
}

class _ChangePlayerNameScreenState extends State<ChangePlayerNameScreen> {
  bool isLoading = true;
  TextEditingController codeController = TextEditingController();

  Future<void> onChangeName(BuildContext context) async {
    final playerName = codeController.text.trim();
    if (playerName.isEmpty) {
      showErrorSnackbar(context, 'Player name cannot be empty');
      return;
    }

    setState(() {
      isLoading = true;
    });
    await setPlayerNameInPrefs(playerName);
    if (!mounted) return;

    if (!context.mounted) return;
    final router = GoRouter.of(context);

    if (widget.roomId.isNotEmpty) {
      router.replace('/room/${widget.roomId}');
    } else {
      router.go('/');
    }
  }

  void loadInitialName() async {
    final currentName = await getPlayerNameFromPrefs();
    if (!mounted) return;
    codeController.text = currentName;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadInitialName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter your name')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: codeController,
                readOnly: isLoading,
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
