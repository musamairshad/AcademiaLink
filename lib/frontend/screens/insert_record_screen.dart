import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:academialink/frontend/screens/view_record_screen.dart';

class InsertRecordScreen extends StatefulWidget {
  const InsertRecordScreen({super.key});

  @override
  State<InsertRecordScreen> createState() => _InsertRecordScreenState();
}

class _InsertRecordScreenState extends State<InsertRecordScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  var success = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
  }

  Future<void> insertRecord() async {
    if (_nameController.text != "" ||
        _emailController.text != "" ||
        _departmentController.text != "") {
      try {
        String uri = "http://10.0.2.2/student_api/insert_record.php";

        var response = await http.post(
          Uri.parse(uri),
          body: {
            "name": _nameController.text,
            "email": _emailController.text,
            "department": _departmentController.text,
          },
        );

        var resData = jsonDecode(response.body);

        if (resData["success"] == "true") {
          print("Record Inserted.");
          success = true;
          _nameController.text = "";
          _emailController.text = "";
          _departmentController.text = "";
        } else {
          print("Some issue.");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill all fields!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: Text("Enter Student's Name"),
              ),
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: Text("Enter Student's Email"),
              ),
              controller: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: Text("Enter Student's Department"),
              ),
              controller: _departmentController,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () {
                insertRecord();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Record Inserted!"),
                    duration: Duration(
                      seconds: 3,
                    ),
                  ),
                );
              },
              label: const Text("INSERT"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ViewRecordScreen(),
                  ),
                );
              },
              child: const Text("View Records"),
            ),
          ],
        ),
      ),
    );
  }
}
