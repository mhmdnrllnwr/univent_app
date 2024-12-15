import 'package:flutter/material.dart';

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
                const Text(
                  "Event Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    hintText: "Enter event name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _eventDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select event date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _eventLocationController,
                  decoration: const InputDecoration(
                    hintText: "Enter event location",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: ["Workshop", "Conference", "Webinar", "Meetup"]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select a category",
                  ),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
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

                // Conditional TextField based on event format
                if (formatView == EventFormat.physical) ...[
                  const Text(
                    "Venue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _eventLocationController,
                    decoration: const InputDecoration(
                      hintText: "Enter event venue",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event venue';
                      }
                      return null;
                    },
                  ),
                ] else if (formatView == EventFormat.online) ...[
                  const Text(
                    "Event Link",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _eventLocationController,
                    decoration: const InputDecoration(
                      hintText: "Enter event link",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event link';
                      }
                      return null;
                    },
                  ),
                ],
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
