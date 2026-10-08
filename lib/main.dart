// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/course_state.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState()..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Fundamentals',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfilePage(), // Sesuaikan dengan halaman utama kamu
    );
  }
}