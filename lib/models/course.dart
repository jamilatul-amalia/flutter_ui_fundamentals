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
    // Mengambil nilai sks atau credits
    final rawCredits = json['sks'] ?? json['credits'];
    int parsedCredits = 0;

    if (rawCredits is int) {
      parsedCredits = rawCredits;
    } else if (rawCredits is String) {
      // Mengambil angka dari teks "3 SKS" -> 3
      parsedCredits = int.tryParse(rawCredits.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    }

    return Course(
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: parsedCredits,
      status: json['status'] as String? ?? 'Wajib',
      desc: json['desc'] as String? ?? '',
    );
  }
}