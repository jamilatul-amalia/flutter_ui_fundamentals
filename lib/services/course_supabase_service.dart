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
  Future<Course> createCourse(Course course) async {
    final Map<String, dynamic> payload = {
      'code': course.code.toUpperCase(),
      'title': course.title,
      'credits': course.credits,
      'status': course.status.toLowerCase(),
    };

    final row = await supabase
        .from('courses')
        .insert(payload)
        .select()
        .single();

    return Course.fromJson(row);
  }

  @override
  Future<Course> updateCourse(String id, Course course) async {
    final Map<String, dynamic> payload = {
      'code': course.code.toUpperCase(),
      'title': course.title,
      'credits': course.credits,
      'status': course.status.toLowerCase(),
    };

    final row = await supabase
        .from('courses')
        .update(payload)
        .eq('id', id)
        .select()
        .single();

    return Course.fromJson(row);
  }

  @override
  Future<void> deleteCourse(String id) async {
    await supabase.from('courses').delete().eq('id', id);
  }
}