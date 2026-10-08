// Nama: Jamilatul Amalia
// NIM: 2415051107

class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String desc;

  Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.desc,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: (json['sks'] ?? json['credits'] ?? 0) as int,
      status: json['status'] as String? ?? 'Wajib',
      desc: json['desc'] as String? ?? '',
    );
  }
}