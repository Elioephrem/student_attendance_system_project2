import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:project2/login_screen.dart';

class AttendanceMarkingScreen extends StatefulWidget {
  final String course;

  AttendanceMarkingScreen(this.course);

  @override
  _AttendanceMarkingScreenState createState() =>
      _AttendanceMarkingScreenState();
}

class _AttendanceMarkingScreenState extends State<AttendanceMarkingScreen> {
  List<Map<String, dynamic>> students = [];
  List<bool> attendanceList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.http("elioephremralph.000webhostapp.com", 'attendance.php');
    var response = await http.post(
      url,
      body: {
        "course_id": widget.course,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        students = List<Map<String, dynamic>>.from(json.decode(response.body));
        attendanceList = List.generate(students.length, (index) => false);
      });
    }
  }

  Future<void> submitAttendance() async {

    for (int i = 0; i < students.length; i++) {
      if (attendanceList[i]) {
        await markAttendance(students[i]['student_id']);
      }
    }

    Fluttertoast.showToast(
      msg: "Attendance submitted successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // You can add any further logic or UI updates after submitting attendance
  }

  Future<void> markAttendance(String studentId) async {
    var url = Uri.http("elioephremralph.000webhostapp.com", 'present_notPresent.php');
    var response = await http.post(
      url,
      body: {
        "course_id": widget.course,
        "student_id": studentId,
        "is_present": "1", // Assuming 1 means present, modify as needed
      },
    );

    if (response.statusCode == 200) {
      print("Attendance marked successfully for student: $studentId");
    } else {
      print("Failed to mark attendance for student: $studentId");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Attendance ${widget.course}'),
      ),
      body: Center(
        child: students.isEmpty
            ? Text(
          'loading',
          style: TextStyle(fontSize: 18),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            students[index]['student_id'] ?? '',
                            textAlign: TextAlign.left,
                          ),
                          Checkbox(
                            value: attendanceList[index],
                            onChanged: (value) {
                              setState(() {
                                attendanceList[index] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    color: Colors.grey,
                    shadowColor: Colors.blue,
                  );
                },
              ),
            ),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20), // Adjust padding as needed
                elevation: 50, // Add elevation
              ),
              onPressed: () {
                submitAttendance();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen('')),
                );
              },
              child: Text('Submit Attendance'),
            ),

          ],
        ),
      ),
    );
  }
}
