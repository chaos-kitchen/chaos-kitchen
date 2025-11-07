import 'package:flutter/widgets.dart';

class UIButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const UIButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: const Color(0xffffd77a),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: child,
      ),
    );
  }
}
