import 'dart:convert';

import 'package:academialink/frontend/screens/update_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewRecordScreen extends StatefulWidget {
  const ViewRecordScreen({super.key});

  @override
  State<ViewRecordScreen> createState() => _ViewRecordScreenState();
}

class _ViewRecordScreenState extends State<ViewRecordScreen> {
  List studentsData = [];

  Future<void> deleteRecord(String id) async {
    String uri = "http://10.0.2.2/student_api/delete_record.php";
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          "id": id,
        },
      );
      var resData = jsonDecode(response.body);
      if (resData["success"] == "true") {
        print("Record deleted.");
        fetchRecords();
      } else {
        print("Failed to delete a record!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchRecords() async {
    String uri = "http://10.0.2.2/student_api/view_record.php";
    try {
      var response = await http.get(
        Uri.parse(uri),
      );
      setState(() {
        studentsData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Records Screen"),
      ),
      body: studentsData.isEmpty
          ? const Center(
              child: Text("No records found."),
            )
          : ListView.builder(
              itemCount: studentsData.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: Text(studentsData[index]["sname"]),
                    subtitle: Text(studentsData[index]!["semail"]),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => UpdateRecordScreen(
                                    name: studentsData[index]["sname"],
                                    email: studentsData[index]["semail"],
                                    department: studentsData[index]
                                        ["sdepartment"],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteRecord(studentsData[index]["sid"]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
