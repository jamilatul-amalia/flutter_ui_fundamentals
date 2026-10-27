// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');

    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Course> createCourse(Course course) => throw UnimplementedError();

  @override
  Future<Course> updateCourse(String id, Course course) => throw UnimplementedError();

  @override
  Future<void> deleteCourse(String id) => throw UnimplementedError();
}