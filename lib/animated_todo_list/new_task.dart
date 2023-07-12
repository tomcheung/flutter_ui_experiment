import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('New Task'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32),
                  Text('What tasks are you planning to perform?'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your task',
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: Hero(
              tag: 'CreateTask',
              child: GradientButton(
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final double cornerRadius;
  final Widget? child;
  final VoidCallback? onPressed;

  const GradientButton(
      {super.key, this.child, required this.onPressed, this.cornerRadius = 0});

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
    );
    return RawMaterialButton(
      elevation: 12,
      hoverElevation: 12,
      focusElevation: 8,
      shape: shape,
      fillColor: Colors.blue,
      onPressed: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: ShapeDecoration(
            shape: shape,
            gradient: const LinearGradient(
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
