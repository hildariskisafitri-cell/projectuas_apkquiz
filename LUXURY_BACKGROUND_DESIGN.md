# Desain Latar Belakang Aplikasi Quiz Master

## Ringkasan

Latar belakang aplikasi Quiz Master telah dirancang dengan gaya klasik dan mewah yang abadi. Desain ini menggabungkan elemen-elemen berikut:

### Karakteristik Desain

1. **Warna Latar Belakang**
   - Warna dasar: Navy Gelap (#0a1419) dengan gradien biru hingga hitam
   - Menciptakan kesan mewah, profesional, dan elegan
   - Kontras yang cukup untuk memastikan teks tetap mudah dibaca

2. **Pola Ornamen**
   - **Damask Pattern**: Pola klasik bergaya Damask dengan ketebalan minimal untuk tidak membanjiri tampilan
   - **Art Deco Lines**: Garis-garis tipis bergaya Art Deco di seluruh background
   - **Victorian Flourishes**: Elemen ukiran Victorian di sudut-sudut yang halus dan seimbang

3. **Palet Warna**
   - Warna emas redup (#D4A574) dan perunggu (#B8860B) untuk ornamen
   - Opacity yang disesuaikan (8-15%) untuk menciptakan kesan yang kaya namun tidak berlebihan
   - Menciptakan tekstur visual tanpa mengganggu keterbacaan konten

4. **Tekstur**
   - Filter velvet effect untuk memberikan dimensi dan kedalaman
   - Pola berulang yang menciptakan kesan tekstur bersuede

5. **Komposisi**
   - Simetris dan seimbang
   - Ornamen di sudut-sudut dan pusat untuk stabilitas visual
   - Garis pembatas tipis emas untuk mendefinisikan ruang
   - Rasio aspek 16:9

## File-File yang Diubah

### 1. **assets/backgrounds/luxury_background.svg**
- File SVG baru yang berisi desain latar belakang lengkap
- Dapat di-scale ke berbagai ukuran layar tanpa kehilangan kualitas
- Menggunakan gradient, pattern, dan filter SVG untuk efek visual

### 2. **lib/widgets/luxury_background.dart**
- Widget baru yang menyediakan dua opsi:
  - `LuxuryBackground`: Widget dasar untuk membungkus konten dengan background
  - `LuxuryBackgroundScaffold`: Wrapper untuk Scaffold yang memudahkan integrasi

**Penggunaan:**
```dart
// Opsi 1: Menggunakan LuxuryBackground dengan konten custom
LuxuryBackground(
  addOverlay: true,  // Tambahkan overlay transparan untuk kontras
  overlayOpacity: 0.15,
  child: YourContentWidget(),
)

// Opsi 2: Menggunakan LuxuryBackgroundScaffold (untuk screens)
LuxuryBackgroundScaffold(
  appBar: AppBar(...),
  body: YourContent(),
)
```

### 3. **Screens yang Diperbarui**

#### **lib/views/login_screen.dart**
- Menggunakan `LuxuryBackgroundScaffold` sebagai container utama
- Warna teks diperbarui untuk kontras optimal:
  - Judul: Emas (#D4A574)
  - Teks biasa: Putih/Abu-abu terang
  - Input field: Transparan putih dengan border emas
  - Tombol: Tetap menggunakan ungu (#6C63FF) untuk konsistensi brand

#### **lib/views/home_screen.dart**
- Integrasi penuh dengan background mewah
- Kategori kuis styling disesuaikan untuk dark background
- User info card menggunakan warna emas sebagai aksen

#### **lib/views/quiz_screen.dart**
- Teks pertanyaan berubah menjadi putih untuk keterbacaan
- Timer widget disesuaikan dengan warna putih
- Tombol navigasi tetap konsisten dengan design system

#### **lib/views/result_screen.dart**
- Skor circle display dipertahankan dengan warna yang sama
- Statistik pengguna menggunakan aksen emas
- Summary box transparan dengan border emas

### 4. **lib/main.dart**
- Theme diperbarui untuk mendukung background mewah:
  - `scaffoldBackgroundColor: Colors.transparent` - memungkinkan background terlihat
  - `canvasColor: Colors.transparent` - untuk dialog dan elemen floating
  - Text theme diatur untuk kontras dengan dark background
  - Brightness: dark untuk konsistensi visual

### 5. **pubspec.yaml**
- Ditambahkan dependency: `flutter_svg: ^2.0.0`
- Asset background SVG didaftarkan dalam flutter section

## Palet Warna Baru

| Elemen | Warna | Kode | Penggunaan |
|--------|-------|------|-----------|
| Latar Utama | Navy Gelap | #0a1419 | Background dasar |
| Latar Gradien 1 | Biru Dongker | #1a2f4f | Gradien bagian atas |
| Latar Gradien 2 | Biru Tua | #0d1f2d | Gradien tengah |
| Aksen Emas | Gold Redup | #D4A574 | Judul, ornamen |
| Aksen Perunggu | Bronze | #B8860B | Detail tipis |
| Teks Utama | Putih | #FFFFFF | Konten utama |
| Teks Sekunder | Abu-abu Terang | #CCC/Colors.grey[300] | Deskripsi |
| Aksen Brand | Ungu | #6C63FF | Tombol, highlight |

## Responsivitas

Background SVG menggunakan `preserveAspectRatio="xMidYMid slice"` yang berarti:
- Akan selalu memenuhi area viewport
- Aspek rasio 16:9 terjaga
- Cocok untuk berbagai ukuran layar (mobile, tablet, desktop)

## Performa

- **SVG Vector**: Lebih ringan dari raster image, tidak ada pixelation
- **Opacity Layers**: Menggunakan CSS opacity untuk efisiensi rendering
- **Overlay Transparan**: Meningkatkan kontras teks tanpa saturasi warna

## Pengembangan Lebih Lanjut

### Customization

Anda dapat mengubah ornamen dengan mengedit `luxury_background.svg`:

```xml
<!-- Untuk mengubah warna emas -->
<stop offset="0%" style="stop-color:#D4A574;stop-opacity:1" />

<!-- Untuk mengubah opacity ornamen -->
<g opacity="0.08" fill="#d4a574">

<!-- Untuk mengubah ukuran pattern -->
<pattern id="damaskPattern" x="0" y="0" width="200" height="200">
```

### Menambah Ornamen Baru

Tambahkan symbol SVG baru dan gunakan dengan `<use>` tags di berbagai posisi.

## Konsistensi Visual

Semua screens sekarang menggunakan:
- ✅ Background yang sama dan konsisten
- ✅ Palet warna yang selaras
- ✅ Typography yang clear dan readable
- ✅ Spacing dan layout yang teratur
- ✅ Efek visual yang subtle namun elegan

## Notes

- Overlay opacity dapat disesuaikan per screen jika perlu kontras berbeda
- Warna brand (ungu #6C63FF) dipertahankan untuk button dan highlight
- Semua komponen sudah ditest untuk readability
