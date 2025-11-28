import 'package:flutter/widgets.dart';

class UIButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final bool disabled;

  const UIButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = const Color(0xffffd77a),
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: child,
        ),
      ),
    );
  }
}
