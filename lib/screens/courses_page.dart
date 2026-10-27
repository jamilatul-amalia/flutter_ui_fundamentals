// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_state.dart';
import '../widgets/error_view.dart';
import 'add_course_page.dart';
import 'edit_course_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseState>();

    Widget bodyContent;

    if (state.isLoading) {
      bodyContent = const Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      bodyContent = ErrorView(
        message: state.error!,
        onRetry: state.loadCourses,
      );
    } else if (state.courses.isEmpty) {
      bodyContent = const Center(child: Text('Data course belum tersedia'));
    } else {
      bodyContent = ListView.builder(
        itemCount: state.courses.length,
        itemBuilder: (context, index) {
          final course = state.courses[index];
          return ListTile(
            title: Text(course.title),
            subtitle: Text('${course.code} • ${course.credits} SKS'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditCoursePage(course: course),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    state.isFavorite(course.code)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: state.isFavorite(course.code) ? Colors.red : null,
                  ),
                  onPressed: () => state.toggleFavorite(course.code),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: bodyContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCoursePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}