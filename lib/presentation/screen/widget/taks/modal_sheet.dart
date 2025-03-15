import 'package:flutter/material.dart';
import 'package:taskify/presentation/screen/widget/text_field.dart';

class TaskModalSheet extends StatelessWidget {
  final IconData icon;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function onPresed;
  final Function onSubmitted;
  final Function onClose;
  final bool isUpdate;
  const TaskModalSheet(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.onPresed,
      required this.onSubmitted,
      required this.onClose,
      required this.icon,
      this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPresed();
        _addTask(context);
      },
      icon: Icon(icon),
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black54,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Agregar tarea",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    TaskTextField(
                        controller: nameController,
                        icon: Icons.title,
                        label: "Nombre"),
                    const SizedBox(height: 10.0),
                    TaskTextField(
                        controller: descriptionController,
                        icon: Icons.description,
                        label: "Descripción",
                        isExpanded: true),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          onSubmitted();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(isUpdate ? "Actualizar" : "Agregar",
                            style: TextStyle(fontSize: 20.0)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      onClose();
    });
  }
}
