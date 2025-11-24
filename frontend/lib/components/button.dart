import 'package:flutter/widgets.dart';

class UIButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  const UIButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = const Color(0xffffd77a),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: child,
      ),
    );
  }
}
