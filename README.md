# Course Data Manager - Flutter UI Fundamentals

**Nama**: Jamilatul Amalia  
**NIM**: 2415051107  
**Mata Kuliah**: Pemrograman Berbasis Mobile (Worksheet Pertemuan 07)  

## Deskripsi Aplikasi
Course Data Manager adalah aplikasi pengelolaan data mata kuliah berbasis **Flutter** yang terintegrasi secara penuh dengan database cloud **Supabase**. Aplikasi ini mendukung operasi CRUD lengkap (Create, Read, Update, Delete dengan dialog konfirmasi), penanganan loading/empty/error state, serta antarmuka responsif di berbagai perangkat.

## Arsitektur Aplikasi (Separation of Concerns)
- `models/`: Pengelolaan model data (`course.dart`).
- `services/`: Lapisan data source backend (`course_supabase_service.dart`, `course_api_service.dart`).
- `repositories/`: Lapisan abstraksi data (`course_repository.dart`).
- `providers/`: Manajemen state aplikasi (`course_provider.dart` / `course_state.dart`).
- `screens/` & `widgets/`: Komponen tampilan UI responsif dan reusabel.

## Cara Menjalankan Aplikasi
1. Clone repositori ini:
   ```bash
   git clone [https://github.com/jamilatul-amalia/flutter_ui_fundamentals.git](https://github.com/jamilatul-amalia/flutter_ui_fundamentals.git)