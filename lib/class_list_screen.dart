import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'attendance_marking_screen.dart';

class ClassListScreen extends StatefulWidget {
  final String u;
  final String s;

  ClassListScreen(this.u, this.s);

  @override
  _ClassListScreenState createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> {
  List<Map<String, dynamic>> classes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var url = Uri.http("elioephremralph.000webhostapp.com", 'courses.php');
      var response = await http.post(
        url,
        body: {
          "username": widget.u,
          "semester": widget.s,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          classes = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed (show a dialog, log the error, etc.)
      // You might want to show an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class List'),
      ),
      body: Center(
        child: classes.isEmpty
            ? Text(
          'loading',
          style: TextStyle(fontSize: 18),
        )
            : ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey,

              child: ListTile(

                title: Text(classes[index]['course_id'] ?? '',textAlign: TextAlign.center,),
                // Add other class information as needed
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  AttendanceMarkingScreen('${classes[index]['course_id']}'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

