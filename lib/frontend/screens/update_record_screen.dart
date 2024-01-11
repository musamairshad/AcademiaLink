import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateRecordScreen extends StatefulWidget {
  const UpdateRecordScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.department});

  final String name;
  final String email;
  final String department;

  @override
  State<UpdateRecordScreen> createState() => _UpdateRecordScreenState();
}

class _UpdateRecordScreenState extends State<UpdateRecordScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();

  Future<void> updateRecord() async {
    String uri = "http://10.0.2.2/student_api/update_record.php";
    try {
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
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Updated."),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print("Failed to update a record!");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _departmentController.text = widget.department;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Record Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                updateRecord();
                Navigator.of(context).pop();
              },
              label: const Text("UPDATE"),
            ),
          ],
        ),
      ),
    );
  }
}
