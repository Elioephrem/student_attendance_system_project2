import 'package:flutter/material.dart';
import 'class_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  String u;
  String semester;

  DashboardScreen(this.u, this.semester);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedValue; // Change type to String?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to the Dashboard ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://upload.wikimedia.org/wikipedia/ar/4/4b/LIU_Logo.png',
              alignment: AlignmentDirectional.topCenter,
              height: 100,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                  widget.semester = value ?? ''; // Use an empty string if null
                });
              },
              items: [null, 'Fall 2023-2024', 'Spring 2023-2024']
                  .map((String? method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method ?? 'Select Semester'), // Provide a default label for null
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassListScreen(widget.u, widget.semester),
                  ),
                );
              },
              child: Text('View Classes'),
            ),
          ],
        ),
      ),
    );
  }
}
