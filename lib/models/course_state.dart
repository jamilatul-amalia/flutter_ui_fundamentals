// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';

class CourseState extends ChangeNotifier {
  // Collection Set untuk menyimpan ID/kode kursus favorit
  final Set<String> favorites = {};

  // Method untuk menambah atau menghapus favorit
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    // Memberitahu widget listener bahwa state telah berubah
    notifyListeners();
  }
}