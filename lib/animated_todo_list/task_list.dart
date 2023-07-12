import 'package:flutter/material.dart';

import 'components.dart';
import 'new_task.dart';

class TaskList extends StatelessWidget {
  final String name;
  const TaskList({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      floatingActionButton: Hero(
        tag: 'CreateTask',
        child: SizedBox(
          width: 48,
          height: 48,
          child: GradientButton(
            cornerRadius: 24,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return const NewTask();
                  },
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            TodoListHeader(
              name: name,
              completedTaskCount: 1,
              totalTaskCount: 3,
            ),
            const Text('Today'),
            const TodoItem(task: 'Design Sprint', isCompleted: true),
            const TodoItem(task: 'Icon Set Design for Mobile App'),
            const TodoItem(task: 'HTML/CSS Study')
          ],
        ),
      ),
    );
  }
}

class TodoListHeader extends StatelessWidget {
  final String name;
  final int totalTaskCount;
  final int completedTaskCount;

  const TodoListHeader({
    super.key,
    required this.name,
    required this.totalTaskCount,
    required this.completedTaskCount,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    final double progress =
        (totalTaskCount > 0) ? completedTaskCount / totalTaskCount : 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.work,
              color: Colors.blueAccent,
            ),
          ),
        ),
        Text('$totalTaskCount Tasks'),
        Text(
          name,
          style: style.textTheme.displayMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(child: LinearProgressIndicator(value: progress)),
              const SizedBox(width: 16),
              Text('${(progress * 100).toInt()}%'),
            ],
          ),
        ),
      ],
    );
  }
}
