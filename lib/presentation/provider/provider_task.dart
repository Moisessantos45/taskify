import 'package:flutter/material.dart';
import 'package:taskify/domains/entity_task.dart';

class ProviderTask with ChangeNotifier {
  final List<EntityTask> _tasks = [];

  List<EntityTask> get tasks => _tasks;

  void addTaskList(List<EntityTask> tasks) {
    _tasks.addAll(tasks);
    notifyListeners();
  }

  void addTask(EntityTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(EntityTask task) {
    final index = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[index] = task;
    notifyListeners();
  }

  void removeTask(EntityTask task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
