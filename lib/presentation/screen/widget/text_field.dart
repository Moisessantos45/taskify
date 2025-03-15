import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool isExpanded;

  const TaskTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.label,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isExpanded ? TextInputType.multiline : TextInputType.text,
      maxLines: isExpanded ? 3 : 1,
      minLines: isExpanded ? null : 1,
      style: const TextStyle(fontSize: 15),
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          fillColor: Colors.black,
          filled: true,
          prefixIcon: Icon(icon, size: 18),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 36, minHeight: 36),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey[400]!),
          )),
      onChanged: (value) {},
    );
  }
}
