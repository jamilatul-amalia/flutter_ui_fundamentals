// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_state.dart';
import 'course_detail_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mata Kuliah'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CourseState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.courses.isEmpty) {
            return const Center(child: Text('Tidak ada mata kuliah.'));
          }

          return ListView.builder(
            itemCount: state.courses.length,
            itemBuilder: (context, index) {
              final course = state.courses[index];
              final isFav = state.isFavorite(course.code);

              return ListTile(
                title: Text(course.title),
                subtitle: Text('${course.code} • ${course.credits} SKS'),
                trailing: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                  onPressed: () => state.toggleFavorite(course.code),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailPage(
                        course: course,
                        isFavorite: isFav,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}