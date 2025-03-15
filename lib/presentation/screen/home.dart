import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/config/show_notification.dart';
import 'package:taskify/domains/entity_task.dart';
import 'package:taskify/presentation/provider/provider_bd.dart';
import 'package:taskify/presentation/provider/provider_task.dart';
import 'package:taskify/presentation/screen/widget/taks/modal_sheet.dart';
import 'package:taskify/presentation/screen/widget/taks_item.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final uuid = Uuid();
  String id = "";

  Future<void> openDB() async {
    final providerTask = Provider.of<ProviderTask>(context, listen: false);
    final providerBd = Provider.of<ProviderBd>(context, listen: false);
    try {
      await providerBd.openDB();
      final tasks = await providerBd.getTask();

      final taskList = tasks.map((e) => EntityTask.fromMap(e)).toList();
      providerTask.addTaskList(taskList);

      showNotification("Base de datos abierta",
          "La base de datos se ha abierto correctamente");
      print(taskList);
    } catch (e) {
      showNotification("Error", e.toString(), error: true);
    }
  }

  Future<void> addTask() async {
    final providerTask = Provider.of<ProviderTask>(context, listen: false);
    final providerBd = Provider.of<ProviderBd>(context, listen: false);
    final task = EntityTask(
      id: uuid.v4(),
      name: nameController.text,
      description: descriptionController.text,
    );
    try {
      await providerBd.addTask(task);
      providerTask.addTask(task);
      clearFields();

      showNotification(
          "Tarea agregada", "La tarea se ha agregado correctamente");
    } catch (e) {
      showNotification("Error", e.toString(), error: true);
    }
  }

  void clearFields() {
    setState(() {
      nameController.clear();
      descriptionController.clear();
      id = "";
    });
  }

  @override
  void initState() {
    super.initState();
    openDB();
  }

  @override
  void dispose() {
    final providerBd = Provider.of<ProviderBd>(context, listen: false);
    providerBd.database!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<ProviderTask>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Person'),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  const Text(
                    "Agregar tarea",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  TaskModalSheet(
                      nameController: nameController,
                      descriptionController: descriptionController,
                      onPresed: () {},
                      onSubmitted: addTask,
                      onClose: clearFields,
                      icon: Icons.add),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskItemWidget(
                  task: task,
                );
              },
            )),
          ],
        ));
  }
}
