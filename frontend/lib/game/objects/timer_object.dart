import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';

String formatDuration(Duration duration) {
  if (duration.isNegative) {
    return '00:00';
  }
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

class TimerObject extends RectangleComponent {
  final DateTime gameEndTime;

  TimerObject({required this.gameEndTime});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // anchor = Anchor.center;
    size = Vector2(60, 30);
    paintLayers = [
      Paint()
        ..color = const Color(0xff63625c)
        ..style = PaintingStyle.fill,
      Paint()
        ..color = const Color(0xff000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    ];
    decorator = Rotate3DDecorator(center: center, angleX: 0.8, perspective: 0);

    final initialDifference = gameEndTime.difference(DateTime.now());

    var textComponent = TextComponent(
      text: formatDuration(initialDifference),
      textRenderer: TextPaint(
        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
      ),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(textComponent);

    if (!initialDifference.isNegative) {
      final timer = TimerComponent(
        period: 1,
        repeat: true,
        tickCount: initialDifference.inSeconds,
        onTick: () {
          final remaining = gameEndTime.difference(DateTime.now());
          textComponent.text = formatDuration(remaining);
        },
      );
      add(timer);
    }
  }
}
