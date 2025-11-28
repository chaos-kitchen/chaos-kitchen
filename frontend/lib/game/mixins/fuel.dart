import 'dart:ui';

import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';

mixin FuelTimerMixin on Component {
  TimerComponent? _timer;

  void startFuelTimer(
    OvenPoweredMessage message,
    ValueNotifier<double> progressNotifier,
  ) {
    final totalDurationMilliseconds = message.totalDurationSeconds * 1000;
    final poweredUntil = message.poweredUntil.toDateTime();
    final now = DateTime.now().toUtc();

    if (poweredUntil.isBefore(now)) {
      // fuel already expired
      return;
    }

    if (_timer != null) remove(_timer!);

    _timer = TimerComponent(
      period: 1 / 10,
      repeat: true,
      onTick: () {
        final now = DateTime.now().toUtc();
        final remainingMilliseconds = poweredUntil
            .difference(now)
            .inMilliseconds;
        if (remainingMilliseconds <= 0) {
          progressNotifier.value = 0.0;
          remove(_timer!);
          _timer = null;
          return;
        }
        progressNotifier.value =
            remainingMilliseconds / totalDurationMilliseconds;
      },
    );

    add(_timer!);
  }

  void addFaintGlowEffect(
    OvenPoweredMessage message,
    Vector2 position,
    double radius,
  ) {
    int remainingMilliseconds = message.poweredUntil
        .toDateTime()
        .difference(DateTime.now().toUtc())
        .inMilliseconds;

    final glow = CircleComponent(
      radius: radius,
      position: position,
      anchor: Anchor.center,
      paint: Paint()
        ..color = const Color.fromARGB(220, 255, 165, 0)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      priority: 1,
      children: [
        OpacityEffect.to(
          0.6,
          InfiniteEffectController(ZigzagEffectController(period: 2)),
        ),
      ],
    );

    add(glow);
    add(
      TimerComponent(
        period: remainingMilliseconds / 1000,
        repeat: false,
        onTick: () {
          remove(glow);
        },
      ),
    );
  }
}
