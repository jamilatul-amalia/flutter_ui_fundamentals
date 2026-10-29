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
      'status': course.status.toLowerCase(), // Normalisasi status ke huruf kecil
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
    try {
      final Map<String, dynamic> payload = {
        'code': course.code.toUpperCase(),
        'title': course.title,
        'credits': course.credits,
        'status': course.status.toLowerCase(),
      };

      // Konversi ID ke angka jika memungkinkan
      final int? parsedId = int.tryParse(id) ?? int.tryParse(course.id.toString());

      var query = supabase.from('courses').update(payload);

      // Jika ID angka valid, update berdasarkan 'id'. Jika berupa string kode, update berdasarkan 'code'
      final response = await (parsedId != null && parsedId > 0
              ? query.eq('id', parsedId)
              : query.eq('code', course.code.toUpperCase()))
          .select()
          .maybeSingle();

      if (response == null) {
        throw Exception("Data course tidak ditemukan di Supabase.");
      }

      return Course.fromJson(response);
    } catch (e) {
      print("ERROR SUPABASE UPDATE: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      final int? parsedId = int.tryParse(id);
      if (parsedId != null && parsedId > 0) {
        await supabase.from('courses').delete().eq('id', parsedId);
      } else {
        await supabase.from('courses').delete().eq('code', id.toUpperCase());
      }
    } catch (e) {
      print("ERROR SUPABASE DELETE: $e");
      rethrow;
    }
  }
}