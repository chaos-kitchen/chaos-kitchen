import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';

class ChoppingOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const ChoppingOverlay({super.key, required this.game});

  @override
  State<ChoppingOverlay> createState() => _ChoppingOverlayState();
}

class _DragPayload {
  final String itemId;
  final bool fromInputSlot;

  _DragPayload({required this.itemId, required this.fromInputSlot});
}

// Which base ingredient chops into which chopped form.
const Map<String, String> _chopMapping = {
  IngredientIds.garlic: IngredientIds.choppedGarlic,
  IngredientIds.mushrooms: IngredientIds.choppedMushroom,
  IngredientIds.onionWhite: IngredientIds.choppedOnions,
  IngredientIds.thyme: IngredientIds.choppedThyme,
};

class _ChoppingOverlayState extends State<ChoppingOverlay> {
  // The ingredient currently placed in the chopping slot.
  String? _inputItemId;

  // The last chopped output (for display in the output slot).
  String? _outputItemId;

  // Tap-spam state.
  int _tapCount = 0;
  static const int _tapThreshold = 12; // tweak for difficulty

  // Returns the correct cutting board sprite for the current input
  String get _boardSpritePath {
    switch (_inputItemId) {
      case IngredientIds.garlic:
        return 'cutting_board_garlic.png';
      case IngredientIds.mushrooms:
        return 'cutting_board_mushroom.png';
      case IngredientIds.onionWhite:
        return 'cutting_board_onion.png';
      case IngredientIds.thyme:
        return 'cutting_board_thyme.png';
      default:
        // empty board
        return 'cutting_board.png';
    }
  }

  /// Status text used at the top (“Chopped!”, “Tap quickly to chop!”, etc.)
  String _statusLabel() {
    final bool hasInput = _inputItemId != null;
    final bool canChopNow = hasInput && _chopMapping.containsKey(_inputItemId);
    final bool hasResult = _outputItemId != null;

    if (hasResult) {
      return 'Chopped!';
    } else if (canChopNow) {
      return 'Tap quickly to chop!';
    } else {
      return 'Place an ingredient to chop';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dim the game behind
        Positioned.fill(child: Container(color: Colors.black54)),

        // Centered chopping panel
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 600,
              height: 350,
              color: const Color(0xFFF5E4C8), // “countertop”
              child: _buildPanelContents(),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Main panel layout
  // ---------------------------------------------------------------------------
  Widget _buildPanelContents() {
    return Stack(
      children: [
        // Close button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => widget.game.closeChopping(),
            child: const Icon(Icons.close, size: 32, color: Colors.black87),
          ),
        ),

        // Title / status text near the top
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              _statusLabel(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),

        // Board / chopping area in the middle
        Align(alignment: const Alignment(0, -0.35), child: _buildBoardArea()),

        // Input slot (left), horizontally aligned with board
        Align(
          alignment: const Alignment(-0.6, -0.25),
          child: _buildInputSlot(),
        ),

        // Output display (right), horizontally aligned with board
        Align(
          alignment: const Alignment(0.6, -0.25),
          child: _buildOutputSlot(),
        ),

        // Inventory box at bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildInventoryBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryBox() {
    final player = widget.game.cookPlayer;
    final heldId = player?.heldItemId;
    final heldAsset = heldId != null ? ingredientAssetPaths[heldId] : null;

    return DragTarget<_DragPayload>(
      // Only accept drops coming back from the input slot
      onWillAccept: (payload) {
        if (payload == null) return false;
        if (!payload.fromInputSlot) return false;
        if (player == null) return false;
        // Only if inventory is empty (simple rule, like mixer):
        return !player.hasHeldItem;
      },
      onAccept: (payload) {
        final p = widget.game.cookPlayer;
        if (p == null) return;

        setState(() {
          // Put the item back into player inventory
          final success = p.tryPickItem(payload.itemId);
          if (success && _inputItemId == payload.itemId) {
            _inputItemId = null;
            _tapCount = 0;
          }
        });
      },
      builder: (context, candidate, rejected) {
        final borderColor = candidate.isNotEmpty
            ? Colors.greenAccent
            : Colors.brown[700]!;

        Widget inner;
        if (heldAsset != null) {
          // Allow dragging from inventory into input slot
          inner = Draggable<_DragPayload>(
            data: _DragPayload(itemId: heldId!, fromInputSlot: false),
            feedback: Image.asset(
              'assets/images/$heldAsset',
              width: 60,
              height: 60,
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/$heldAsset',
                width: 60,
                height: 60,
              ),
            ),
            child: Image.asset(
              'assets/images/$heldAsset',
              width: 60,
              height: 60,
            ),
          );
        } else {
          inner = const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Inventory',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFEEDFCC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 4),
              ),
              alignment: Alignment.center,
              child: inner,
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputSlot() {
    final itemId = _inputItemId;
    final assetPath = itemId != null ? ingredientAssetPaths[itemId] : null;

    return DragTarget<_DragPayload>(
      onWillAccept: (payload) {
        if (payload == null) return false;
        // Only accept when slot empty:
        if (_inputItemId != null) return false;
        // Only ingredients that we know how to chop:
        return _chopMapping.containsKey(payload.itemId);
      },
      onAccept: (payload) {
        final player = widget.game.cookPlayer;
        if (player == null) return;

        setState(() {
          if (!payload.fromInputSlot) {
            // Coming from inventory: consume held item
            if (player.heldItemId == payload.itemId) {
              player.dropHeldItem();
            }
          }

          _inputItemId = payload.itemId;
          _tapCount = 0;
          _outputItemId = null; // reset last result
        });
      },
      builder: (context, candidate, rejected) {
        final bool isHovering = candidate.isNotEmpty;
        final Color bgColor = const Color(0xFFEEDFCC);
        final Color borderColor = isHovering
            ? Colors.greenAccent
            : Colors.brown[700]!;

        Widget child;
        if (assetPath == null) {
          child = const Text(
            'Input',
            style: TextStyle(fontSize: 12, color: Colors.brown),
          );
        } else {
          // Allow dragging back to inventory
          child = Draggable<_DragPayload>(
            data: _DragPayload(itemId: itemId!, fromInputSlot: true),
            feedback: Image.asset(
              'assets/images/$assetPath',
              width: 60,
              height: 60,
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/$assetPath',
                width: 60,
                height: 60,
              ),
            ),
            child: Image.asset(
              'assets/images/$assetPath',
              width: 60,
              height: 60,
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'To Chop',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 4),
              ),
              alignment: Alignment.center,
              child: child,
            ),
          ],
        );
      },
    );
  }

  Widget _buildOutputSlot() {
    final itemId = _outputItemId;
    final assetPath = itemId != null ? ingredientAssetPaths[itemId] : null;

    final Color bgColor = const Color(0xFFEEDFCC);
    final Color borderColor = Colors.brown[700]!;

    Widget child;
    if (assetPath == null) {
      child = const Text(
        'Output',
        style: TextStyle(fontSize: 12, color: Colors.brown),
      );
    } else {
      child = Image.asset('assets/images/$assetPath', width: 60, height: 60);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Result',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 4),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ],
    );
  }

  Widget _buildBoardArea() {
    final bool hasInput = _inputItemId != null;
    final bool canChopNow = hasInput && _chopMapping.containsKey(_inputItemId);
    final bool hasResult = _outputItemId != null;

    return GestureDetector(
      onTapDown: (_) {
        if (!canChopNow) return;

        setState(() {
          _tapCount++;
          if (_tapCount >= _tapThreshold) {
            _completeChop();
          }
        });
      },
      child: SizedBox(
        width: 260, // bigger board area
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cutting board image (slightly inset so we have room for text)
            Image.asset(
              'assets/images/$_boardSpritePath',
              width: 250,
              height: 130,
              fit: BoxFit.contain,
            ),

            // Tap progress below the board, with a bit more spacing
            Positioned(
              bottom: 8,
              child: Text(
                hasResult || !canChopNow ? '' : '$_tapCount / $_tapThreshold',
                style: const TextStyle(fontSize: 14, color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _completeChop() {
    final baseId = _inputItemId;
    if (baseId == null) return;

    final choppedId = _chopMapping[baseId];
    if (choppedId == null) return;

    setState(() {
      _inputItemId = null;
      _outputItemId = choppedId;
      _tapCount = 0;
    });

    final player = widget.game.cookPlayer;
    if (player != null) {
      player.tryPickItem(choppedId);
    }
  }
}
