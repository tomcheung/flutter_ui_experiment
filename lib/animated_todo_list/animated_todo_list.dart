import 'dart:math';

import 'package:flutter/material.dart';

import 'task_list.dart';

class AnimatedTodoList extends StatelessWidget {
  const AnimatedTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      child: const HomeTodoList(),
    );
  }
}

class TodoList {
  final String name;
  final Color color;

  TodoList({required this.name, required this.color});
}

class HomeTodoList extends StatefulWidget {
  const HomeTodoList({super.key});

  @override
  State<HomeTodoList> createState() => _HomeTodoListState();
}

class _HomeTodoListState extends State<HomeTodoList> {
  final todoList = [
    TodoList(name: 'Personal', color: Colors.blueAccent),
    TodoList(name: 'Work', color: const Color(0xFFEF9359)),
  ];

  late ScrollController _scrollController;
  late ValueNotifier<Color> _backgroundColor;

  @override
  void initState() {
    _scrollController = ScrollController();
    _backgroundColor = ValueNotifier(todoList.first.color);
    _scrollController.addListener(() {
      final double progress = _scrollController.offset /
          _scrollController.position.viewportDimension;
      final color = Color.lerp(todoList[max(0, progress.floor())].color,
          todoList[min(todoList.length, progress.ceil())].color, progress % 1);
      if (color != null) {
        _backgroundColor.value = color;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundColor,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop(),),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('TODO'),
          backgroundColor: _backgroundColor.value,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Container(color: _backgroundColor.value, child: child),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: HomeHeader(),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: LayoutBuilder(builder: (context, constraint) {
                return ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 32),
                  children: todoList
                      .map(
                        (todoList) => SizedBox(
                      width: constraint.maxWidth - 32,
                      height: constraint.maxHeight,
                      child: TaskListCard(name: todoList.name),
                    ),
                  )
                      .toList(growable: false),
                );
              }),
            ),
          ),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

class TaskListCard extends StatelessWidget {
  final String name;

  const TaskListCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(color: Colors.black, fontSize: 28, height: 2);

    const subheadingStyle = TextStyle(
        color: Colors.black54, fontWeight: FontWeight.w400, height: 1.5);

    return InkWell(
      onTap: () {
        final customRoute = PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) =>
                TaskList(name: name),
            transitionsBuilder:
                (transitionContext, animation, secondAnimation, child) {
              final transitionRenderObject =
                  transitionContext.findRenderObject();
              final renderObject = context.findRenderObject();

              if (renderObject != null &&
                  renderObject is RenderBox &&
                  transitionRenderObject is RenderBox) {
                final finalSize = transitionRenderObject.size;
                final pos = renderObject.localToGlobal(Offset.zero);
                final size = renderObject.size;

                final curveTween = CurveTween(curve: Curves.ease);

                final offsetTween = Tween<Offset>(begin: pos, end: Offset.zero)
                    .chain(curveTween);
                final sizeTween =
                    Tween<Size>(begin: size, end: finalSize).chain(curveTween);
                final opacity =
                    Tween<double>(begin: 0, end: 1).chain(curveTween);

                final offsetAnim = animation.drive(offsetTween);
                final sizeAnim = animation.drive(sizeTween);
                final opacityAnim = animation.drive(opacity);

                return AnimatedBuilder(
                  animation: offsetAnim,
                  builder: (context, _) => Opacity(
                    opacity: opacityAnim.value,
                    child: Stack(
                      children: [
                        Positioned(
                          left: offsetAnim.value.dx,
                          top: offsetAnim.value.dy,
                          width: sizeAnim.value.width,
                          height: sizeAnim.value.height,
                          child: child,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return child;
              }
            });

        Navigator.push(context, customRoute);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text('9 Tasks', style: subheadingStyle),
              Text(name, style: headerStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w300,
        height: 2);

    const subheadingStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, height: 1.5);
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello, Jane.', style: headerStyle),
        Text('Looks like feel good.', style: subheadingStyle),
        Text('You have 3 task to do today', style: subheadingStyle),
      ],
    );
  }
}
