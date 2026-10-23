// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_state.dart';
import '../widgets/error_view.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    // 1. Loading State
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. Error State
    if (state.error != null) {
      return ErrorView(
        message: state.error!,
        onRetry: state.loadCourses,
      );
    }

    // 3. Empty State
    if (state.courses.isEmpty) {
      return const Center(child: Text('Data course belum tersedia'));
    }

    // 4. Success State
    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.title),
          subtitle: Text('${course.code} • ${course.credits} SKS'),
          trailing: Icon(
            state.isFavorite(course.code)
                ? Icons.favorite
                : Icons.favorite_border,
            color: state.isFavorite(course.code) ? Colors.red : null,
          ),
          onTap: () => state.toggleFavorite(course.code),
        );
      },
    );
  }
}