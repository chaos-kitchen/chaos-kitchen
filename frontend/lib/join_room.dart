import 'dart:convert';
import 'dart:math';

import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class RoomCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = newValue.text
        // remove non-alphanumeric characters
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        // limit to 6 characters
        .substring(0, min(6, newValue.text.length))
        .toUpperCase();
    final selection = TextSelection.collapsed(
      offset: min(6, newValue.selection.baseOffset),
    );
    return TextEditingValue(text: formatted, selection: selection);
  }
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  TextEditingController codeController = TextEditingController();

  Future<void> joinRoom(BuildContext context) async {
    final code = codeController.text.trim().replaceAll(' ', '').toUpperCase();
    final response = await http.get(
      Uri.parse('${AppConfig.apiBaseUri}/room/code/$code'),
    );
    if (!context.mounted) return;

    if (response.statusCode != 200) {
      showErrorSnackbar(
        context,
        'Failed to join room: ${response.reasonPhrase}',
      );
    }

    final roomId = jsonDecode(response.body);
    if (roomId == null) {
      showErrorSnackbar(context, 'Room not found');
      return;
    }

    context.replace("/room/${roomId as String}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join a game')),
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
                  labelText: 'Enter Room Code',
                ),
                inputFormatters: [RoomCodeInputFormatter()],
                textCapitalization: TextCapitalization.characters,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: true,
                onSubmitted: (_) => joinRoom(context),
              ),
            ),
            UIButton(
              onPressed: () => joinRoom(context),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
