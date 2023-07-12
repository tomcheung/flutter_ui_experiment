import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String task;
  final bool isCompleted;

  const TodoItem({super.key, required this.task, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(value: isCompleted, onChanged: (selected) {}),
          const SizedBox(width: 8),
          Expanded(child: Text(task, softWrap: true,)),
        ],
      ),
    );
  }
}

class CircularGradientButton extends StatelessWidget {
  static const double size = 48;
  final Widget? child;
  final VoidCallback? onPressed;

  const CircularGradientButton(
      {super.key, this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: size, minHeight: size),
      elevation: 12,
      hoverElevation: 12,
      focusElevation: 8,
      shape: const CircleBorder(),
      fillColor: Colors.blue,
      onPressed: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF589FE0),
                Color(0xFF5882DD),
                Color(0xFF5471DF),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
