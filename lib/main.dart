// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'models/course_state.dart';
import 'widgets/responsive_shell.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    debugPrint('Jumlah item berhasil diambil: ${data.length}');
    return data;
  }
  throw Exception('HTTP ${response.statusCode}');
}

void main() {
  // Pengujian HTTP GET pada Tahap 2
  fetchCourses();

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
      home: const ResponsiveShell(),
    );
  }
}