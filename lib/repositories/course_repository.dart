// Nama: Jamilatul Amalia
// NIM: 2415051107

import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  final CourseApiService apiService;

  CourseRepository(this.apiService);

  Future<List<Course>> getCourses() {
    return apiService.getCourses();
  }

  Future<Course> createCourse(Course course) {
    return apiService.createCourse(course);
  }

  Future<Course> updateCourse(String code, Course course) {
    return apiService.updateCourse(code, course);
  }
}