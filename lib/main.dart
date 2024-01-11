import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'frontend/screens/insert_record_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcademiaLink',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                "AcademiaLink",
                style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "All in one student management solution.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: const InsertRecordScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
