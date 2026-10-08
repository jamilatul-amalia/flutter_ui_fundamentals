// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'course.dart';
import '../services/course_service.dart';

class CourseState extends ChangeNotifier {
  final CourseService _service = CourseService();
  List<Course> _courses = [];
  bool _isLoading = true;

  // Menyimpan daftar ID/kode kursus favorit
  final Set<String> favorites = {};

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;

  // Method untuk mengambil data dari Service
  Future<void> fetchCourses() async {
    _isLoading = true;
    notifyListeners();

    _courses = await _service.loadCourses();
    _isLoading = false;
    notifyListeners();
  }

  // Method untuk tambah/hapus favorit
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    notifyListeners();
  }
}