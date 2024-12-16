import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/event_form_widgets.dart';

enum EventFormat { online, physical }

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();

  String? _selectedCategory; // Dropdown value
  bool _isOnline = false; // Checkbox for online events
  EventFormat formatView = EventFormat.physical;
  XFile? _selectedImage; // Variable to hold the selected image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventTextField(
                  label: "Event Name",
                  controller: _eventNameController,
                  hintText: "Enter event name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                EventDateField(
                  controller: _eventDateController,
                  selectDate: _selectDate,
                ),
                const SizedBox(height: 16),
                EventTextField(
                  label: "Location",
                  controller: _eventLocationController,
                  hintText: "Enter event location",
                ),
                const SizedBox(height: 16),
                EventDropdownField(
                  selectedCategory: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Choose Event Format",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SegmentedButton<EventFormat>(
                  segments: const <ButtonSegment<EventFormat>>[
                    ButtonSegment<EventFormat>(
                      value: EventFormat.physical,
                      label: Text('Physical'),
                      icon: Icon(Icons.location_on),
                    ),
                    ButtonSegment<EventFormat>(
                      value: EventFormat.online,
                      label: Text('Online'),
                      icon: Icon(Icons.wifi),
                    ),
                  ],
                  selected: <EventFormat>{formatView},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.blue
                            .shade100; // Highlight color for selected segment
                      }
                      return Colors.transparent; // Default color
                    }),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.blue, width: 1.5)),
                    foregroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return states.contains(MaterialState.selected)
                          ? Colors.blue.shade900
                          : Colors.black87;
                    }),
                  ),
                  onSelectionChanged: (Set<EventFormat> newSelection) {
                    setState(() {
                      formatView = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (formatView == EventFormat.physical)
                  EventTextField(
                    label: "Venue",
                    controller: _eventLocationController,
                    hintText: "Enter event venue",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event venue';
                      }
                      return null;
                    },
                  )
                else if (formatView == EventFormat.online)
                  EventTextField(
                    label: "Event Link",
                    controller: _eventLocationController,
                    hintText: "Enter event link",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event link';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),
                EventImagePicker(
                  selectedImage: _selectedImage,
                  pickImage: _pickImage,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: _isOnline,
                  title: const Text("This is an online event"),
                  onChanged: (bool? value) {
                    setState(() {
                      _isOnline = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle form submission
                        _submitForm();
                      }
                    },
                    child: const Text(
                      "CREATE EVENT",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      // Handle error
      print("Error picking image: $e");
    }
  }

  // Function to select a date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _eventDateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  // Submit form logic
  void _submitForm() {
    final eventDetails = {
      'name': _eventNameController.text,
      'date': _eventDateController.text,
      'location': _eventLocationController.text,
      'category': _selectedCategory,
      'isOnline': _isOnline,
    };

    print("Event Created: $eventDetails");

    // Here you can integrate with Firebase or any backend service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event Created Successfully!')),
    );
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventLocationController.dispose();
    super.dispose();
  }
}
