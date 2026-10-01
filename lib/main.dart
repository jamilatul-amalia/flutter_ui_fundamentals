import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Identitas Mahasiswa (Sesuaikan dengan data asli kamu)
const String studentName = 'Jamilatul Amalia';
const String studentId = '2415051107';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

// Function Pembaca JSON Statik
Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString('assets/data/student_data.json');
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData(); // Inisialisasi Future di initState
  }

  // Reusable Widget untuk Kartu Statistik
  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Error State
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          }

          // 3. Success State (Render UI dari Data JSON)
          final data = snapshot.data!;
          final student = data['student'] as Map<String, dynamic>;
          final courses = data['courses'] as List<dynamic>;

          int completedCount = courses.where((c) => c['status'] == 'done').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identitas Mahasiswa Card
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                          child: Icon(Icons.person, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['name'] ?? studentName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('NIM: ${student['nim'] ?? studentId}'),
                              const Text(
                                'Mobile Programming Student',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Ringkasan Statistik
                Row(
                  children: [
                    _buildStatCard('${courses.length}', 'Topik', Icons.book),
                    _buildStatCard('$completedCount', 'Selesai', Icons.check_circle),
                    _buildStatCard('60%', 'Progress', Icons.bar_chart),
                  ],
                ),
                const SizedBox(height: 16),

                const Text(
                  'Daftar Materi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // List Materi
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index] as Map<String, dynamic>;
                      bool isDone = course['status'] == 'done';
                      bool isActive = course['status'] == 'active';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            isDone
                                ? Icons.check_circle
                                : (isActive ? Icons.play_circle_fill : Icons.schedule),
                            color: isDone
                                ? Colors.green
                                : (isActive ? Colors.orange : Colors.grey),
                          ),
                          title: Text(
                            course['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text('Kode: ${course['code']} | Credit: ${course['credits']} SKS'),
                          trailing: Text(
                            isDone ? 'Selesai' : (isActive ? 'Berjalan' : 'Rencana'),
                            style: TextStyle(
                              color: isDone
                                  ? Colors.green
                                  : (isActive ? Colors.orange : Colors.grey),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}