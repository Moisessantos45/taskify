import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/config/show_notification.dart';
import 'package:taskify/domains/entity_task.dart';
import 'package:taskify/presentation/provider/provider_bd.dart';
import 'package:taskify/presentation/provider/provider_task.dart';
import 'package:taskify/presentation/screen/widget/taks/modal_sheet.dart';
import 'package:uuid/uuid.dart';

class TaskItemWidget extends StatefulWidget {
  final EntityTask task;
  const TaskItemWidget({super.key, required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final uuid = Uuid();
  String id = "";

  Future<void> updateTask() async {
    final providerTask = Provider.of<ProviderTask>(context, listen: false);
    final providerBd = Provider.of<ProviderBd>(context, listen: false);

    try {
      if (id.isEmpty) {
        throw Exception("No se ha seleccionado una tarea");
      }

      final task = EntityTask(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
      );

      await providerBd.updateTask(task);
      providerTask.updateTask(task);
      clearFields();

      showNotification(
          "Tarea actualizada", "La tarea se ha actualizado correctamente");
    } catch (e) {
      showNotification("Error", e.toString(), error: true);
    }
  }

  Future<void> removeTask(EntityTask task) async {
    final providerTask = Provider.of<ProviderTask>(context, listen: false);
    final providerBd = Provider.of<ProviderBd>(context, listen: false);

    try {
      await providerBd.removeTask(task);
      providerTask.removeTask(task);

      showNotification(
          "Tarea eliminada", "La tarea se ha eliminado correctamente");
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.task.name),
                const SizedBox(height: 10.0),
                Text(
                  widget.task.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          // const Spacer(),
          Expanded(
              flex: 1,
              child: TaskModalSheet(
                nameController: nameController,
                descriptionController: descriptionController,
                onSubmitted: updateTask,
                onPresed: () {
                  nameController.text = widget.task.name;
                  descriptionController.text = widget.task.description;
                  setState(() {
                    id = widget.task.id;
                  });
                },
                onClose: clearFields,
                icon: Icons.edit,
                isUpdate: true,
              )),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => removeTask(widget.task),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
