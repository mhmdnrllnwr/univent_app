import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EventTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const EventTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

class EventDateField extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function(BuildContext) selectDate;

  const EventDateField({
    Key? key,
    required this.controller,
    required this.selectDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Select event date",
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => selectDate(context),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class EventDropdownField extends StatelessWidget {
  final String? selectedCategory;
  final void Function(String?) onChanged;

  const EventDropdownField({
    Key? key,
    required this.selectedCategory,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButtonFormField<String>(
          value: selectedCategory,
          items: ["Workshop", "Conference", "Webinar", "Meetup"]
              .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Select a category",
          ),
          validator: (value) =>
              value == null ? 'Please select a category' : null,
        ),
      ],
    );
  }
}

class EventImagePicker extends StatelessWidget {
  final XFile? selectedImage;
  final Future<void> Function() pickImage;

  const EventImagePicker({
    Key? key,
    required this.selectedImage,
    required this.pickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Event Poster",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Center(
          child: selectedImage == null
              ? const Text("No image selected")
              : Image.file(File(selectedImage!.path)),
        ),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            onPressed: pickImage,
            child: const Text("Select Image"),
          ),
        ),
      ],
    );
  }
}
