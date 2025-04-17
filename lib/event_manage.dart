import 'package:flutter/material.dart';

void main() {
  runApp(EventManagementApp());
}

class EventManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EventListScreen(),
    );
  }
}

class Event {
  String title;
  String date;
  String time;
  String location;
  String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });
}

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [];

  void _addOrEditEvent({Event? event, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventFormScreen(event: event),
      ),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          events[index] = result;
        } else {
          events.add(result);
        }
      });
    }
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Management')),
      body: events.isEmpty
          ? Center(child: Text('No events available'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text(
                        '${event.date} at ${event.time}\n${event.location}'),
                    onTap: () => _addOrEditEvent(event: event, index: index),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteEvent(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrEditEvent(),
      ),
    );
  }
}

class EventFormScreen extends StatefulWidget {
  final Event? event;
  EventFormScreen({this.event});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event?.title ?? '');
    _dateController = TextEditingController(text: widget.event?.date ?? '');
    _timeController = TextEditingController(text: widget.event?.time ?? '');
    _locationController =
        TextEditingController(text: widget.event?.location ?? '');
    _descriptionController =
        TextEditingController(text: widget.event?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        title: _titleController.text,
        date: _dateController.text,
        time: _timeController.text,
        location: _locationController.text,
        description: _descriptionController.text,
      );
      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.event == null ? 'Add Event' : 'Edit Event')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a date' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a time' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

EventManagementApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Event Management'
│   ├── theme: Blue color scheme
│   └── home → EventListScreen

EventListScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Title: "Event Management"
    ├── body:
    │   ├── if events.isEmpty → Center → Text("No events available")
    │   └── else → ListView.builder
    │       └── Card (for each event)
    │           └── ListTile
    │               ├── title: event.title
    │               ├── subtitle: event.date + time + location
    │               ├── onTap → opens EventFormScreen for editing
    │               └── trailing: IconButton (delete)
    └── floatingActionButton → FAB with "+" icon
        └── onPressed → opens EventFormScreen for adding new event

EventFormScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Title: "Add Event" or "Edit Event"
    └── body: Padding
        └── Form (keyed by _formKey)
            └── Column
                ├── TextFormField (_titleController) → Event Title
                ├── TextFormField (_dateController) → Date
                ├── TextFormField (_timeController) → Time
                ├── TextFormField (_locationController) → Location
                ├── TextFormField (_descriptionController) → Description
                ├── SizedBox → spacing
                └── ElevatedButton (Save Event)
                    └── onPressed → validates form and pops new/edited event

🧠 FUNCTIONAL FLOW:

- _addOrEditEvent() → Opens EventFormScreen via Navigator.push and updates state
- _deleteEvent() → Removes event from the list
- _saveEvent() → Validates form, creates Event, returns it via Navigator.pop

📦 DATA MODEL:

Event {
  title: String,
  date: String,
  time: String,
  location: String,
  description: String
}

🎯 USER FLOW:

1. User taps ➕ → goes to EventFormScreen to add
2. User taps on event → edits the entry
3. User taps 🗑 → deletes the event
4. Events shown in list with date/time/location summary
*/
