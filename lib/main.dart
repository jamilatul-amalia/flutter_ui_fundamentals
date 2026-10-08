// Nama: Jamilatul Amalia
// NIM: 2415051107

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/course_state.dart';

String studentName = 'Jamilatul Amalia';
String studentId = '2415051107';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// Data Dummy Course
final List<Map<String, dynamic>> coursesData = [
  {
    'title': 'Responsive Layout',
    'code': 'MOB04',
    'status': 'Active',
    'sks': '3 SKS',
    'desc': 'Mempelajari pembuatan UI adaptif menggunakan MediaQuery, LayoutBuilder, dan Flex widgets.'
  },
  {
    'title': 'Navigation',
    'code': 'MOB05',
    'status': 'Planned',
    'sks': '2 SKS',
    'desc': 'Navigasi multi-screen, passing data, returning data, NavigationBar, dan NavigationRail.'
  },
  {
    'title': 'Interaction',
    'code': 'MOB06',
    'status': 'Planned',
    'sks': '3 SKS',
    'desc': 'Menangani input pengguna, Form validation, InkWell, SnackBar, dan Alert Dialog.'
  },
  {
    'title': 'State Management',
    'code': 'MOB07',
    'status': 'Planned',
    'sks': '3 SKS',
    'desc': 'Pengelolaan state aplikasi yang kompleks menggunakan Provider / Riverpod.'
  },
  {
    'title': 'API & Database',
    'code': 'MOB08',
    'status': 'Planned',
    'sks': '4 SKS',
    'desc': 'Integrasi REST API, pemrosesan JSON, dan penyimpanan data lokal SQLite/Hive.'
  },
];

// Shell Utama Adaptif
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages =[
    HomePage(),
    CoursesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint: Compact/Medium (< 840) vs Expanded (>= 840)
        if (constraints.maxWidth < 840) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Course Explorer'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.school), label: 'Courses'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Course Explorer (Expanded Layout)'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          );
        }
      },
    );
  }
}

// --- HOME PAGE ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Identitas
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('NIM: $studentId'),
                        Text('Mobile Programming Student'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Ukuran Layar Saat Ini: ${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)} px',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search courses...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Keahlian (Wrap Widget):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text('Flutter')),
              Chip(label: Text('Dart')),
              Chip(label: Text('Responsive UI')),
              Chip(label: Text('Git & GitHub')),
              Chip(label: Text('REST API')),
            ],
          )
        ],
      ),
    );
  }
}

// --- COURSES PAGE ---
class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final Set<String> _favoriteCodes = {};

  int _getColumns(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getColumns(constraints.maxWidth),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: coursesData.length,
          itemBuilder: (context, index) {
            final course = coursesData[index];
            final isFav = _favoriteCodes.contains(course['code']);

            return InkWell(
              onTap: () async {
                // Passing Data ke Detail Page
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(
                      course: course,
                      isFavorite: isFav,
                    ),
                  ),
                );

                // CEK MOUNTED UNTUK MENGHINDARI WARNING ASYNC GAP
                if (!mounted) return;

                if (result != null) {
                  setState(() {
                    if (result) {
                      _favoriteCodes.add(course['code']);
                    } else {
                      _favoriteCodes.remove(course['code']);
                    }
                  });

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result
                            ? '${course['title']} ditambahkan ke favorit!'
                            : '${course['title']} dihapus dari favorit!',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              course['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('${course['code']} | ${course['sks']}'),
                          ],
                        ),
                      ),
                      Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// --- DETAIL PAGE ---
class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${course['code']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Bobot: ${course['sks']}'),
            const SizedBox(height: 8),
            Text('Status: ${course['status']}'),
            const Divider(height: 32),
            Text(course['desc'], style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, !isFavorite);
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(isFavorite ? 'Hapus dari Favorit' : 'Jadikan Favorit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFavorite ? Colors.red.shade100 : Colors.blue.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PROFILE PAGE & FORM FEEDBACK ---
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin mengirimkan feedback ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                setState(() => _isLoading = true);

                // Simulasi Loading
                Future.delayed(const Duration(seconds: 2), () {
                  if (!mounted) return;
                  setState(() {
                    _isLoading = false;
                    _commentController.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback berhasil dikirim!')),
                  );
                });
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profil Mahasiswa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Nama: $studentName'),
          Text('NIM: $studentId'),
          const Divider(height: 32),
          const Text('Form Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: '$studentName ($studentId)',
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Identitas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Komentar / Masukan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'Komentar wajib diisi minimal 5 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Kirim Feedback'),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}