import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  String u;

  LoginScreen(this.u);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> login() async {
    var url = Uri.http("elioephremralph.000webhostapp.com", 'login.php');
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = response.body;
    widget.u = user.text;

    if (data == "Success") {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(widget.u, ''),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: Image.network(
          'https://th.bing.com/th/id/OIP.yUeEz5yf7WOT74GmnJ2afAAAAA?w=204&h=199&rs=1&pid=ImgDetMain',
          fit: BoxFit.cover,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Attendance',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 70,
                width: 200,
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(hintText: 'Username'),
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 70,
                width: 200,
                child: TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  style: TextStyle(fontStyle: FontStyle.italic),
                  onChanged: (pass) {},
                ),
              ),
              SizedBox(height: 30),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
