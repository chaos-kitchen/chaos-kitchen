import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';

class MinigameBackdrop extends StatelessWidget {
  final Widget child;

  const MinigameBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dim the game behind
        Positioned.fill(child: Container(color: Colors.black54)),

        // Centered minigame panel
        Center(child: child),
      ],
    );
  }
}

class MinigameBox extends StatelessWidget {
  final List<Widget> children;

  const MinigameBox({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 400,
        height: 300,
        color: const Color(0xFFF5E4C8),
        child: Stack(children: children),
      ),
    );
  }
}

class MinigameCloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MinigameCloseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: onPressed,
        child: const Icon(Icons.close, size: 32, color: Colors.black87),
      ),
    );
  }
}

class MinigameItemDragPayload {
  final MinigameItemSlot sourceSlot;

  MinigameItemDragPayload({required this.sourceSlot});
}

class MinigameItemSlot extends StatelessWidget {
  final String? itemId;
  final void Function(String? newItemId) onItemChanged;
  final bool Function(MinigameItemDragPayload? payload)? onWillAccept;

  const MinigameItemSlot({
    super.key,
    required this.itemId,
    required this.onItemChanged,
    this.onWillAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<MinigameItemDragPayload>(
      onWillAccept:
          onWillAccept ??
          (payload) {
            // Can drop only if slot is empty
            return itemId == null;
          },
      onAccept: (payload) {
        onItemChanged(payload.sourceSlot.itemId);
        payload.sourceSlot.onItemChanged(null);
      },
      builder: (context, candidate, rejected) {
        final bool isHovering = candidate.isNotEmpty;

        final borderColor = isHovering
            ? Colors.greenAccent
            : Colors.brown[700]!;

        Image? itemImage;
        if (itemId != null) {
          final assetPath = ingredientAssetPaths[itemId]!;
          itemImage = Image.asset(
            'assets/images/$assetPath',
            width: 60,
            height: 60,
          );
        }

        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFEEDFCC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 4),
          ),
          alignment: Alignment.center,
          child: itemImage != null
              ? Draggable<MinigameItemDragPayload>(
                  data: MinigameItemDragPayload(sourceSlot: this),
                  feedback: itemImage,
                  childWhenDragging: Opacity(opacity: 0.3, child: itemImage),
                  child: itemImage,
                )
              : SizedBox.shrink(),
        );
      },
    );
  }
}
