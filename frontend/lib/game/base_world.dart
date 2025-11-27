import 'dart:async';

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

abstract class BaseWorld extends World
    with HasGameReference<ChaosKitchenGame>, TapCallbacks {
  StreamSubscription<ServerToClientMessage>? _subscription;
  final Completer<void> _websocketLockCompleter = Completer<void>();

  void handleMessage(ServerToClientMessage message);

  @override
  void onMount() {
    super.onMount();

    game.websocket.lock = game.websocket.lock.then((_) {
      if (!isMounted) return null;

      _subscription = game.websocket.stream.listen(
        handleMessage,
        onError: (error) {
          if (!isMounted) return;
          print('WebSocket error: $error');
        },
      );

      return _websocketLockCompleter.future;
    });
  }

  @override
  void onRemove() {
    super.onRemove();
    _subscription?.cancel();
    _websocketLockCompleter.complete();
  }

  // TEMP: temporarily print tap positions for creating hitboxes
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final position = event.localPosition;
    print(
      'Vector2(${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}),',
    );
  }
}
