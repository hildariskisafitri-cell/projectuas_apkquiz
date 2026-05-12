# Quiz Master - Panduan Gaya Visual

## 🎨 Identitas Visual Aplikasi

Aplikasi Quiz Master menggabungkan keanggunan klasik dengan fungsionalitas modern.

---

## 📐 Palet Warna Resmi

### Latar Belakang
```
Navy Gelap (Primary):     #0a1419 (RGB: 10, 20, 25)
Gradient Atas:            #1a2f4f (RGB: 26, 47, 79)
Gradient Bawah:           #0d1f2d (RGB: 13, 31, 45)
```

### Aksen & Dekorasi
```
Emas Redup:               #D4A574 (RGB: 212, 165, 116)
Perunggu:                 #B8860B (RGB: 184, 134, 11)
```

### Teks & Konten
```
Putih (Primary Text):     #FFFFFF
Abu-abu Terang:           Colors.grey[300] / #999999
Abu-abu Gelap:            Colors.grey[700] / #424242
```

### Brand Color (Tetap)
```
Ungu:                     #6C63FF (RGB: 108, 99, 255)
Digunakan untuk: Tombol utama, highlight, aksen interaktif
```

### Status Colors
```
Sukses:                   #4CAF50 (Hijau)
Peringatan:               #FFC107 (Kuning)
Gagal:                    #F44336 (Merah)
```

---

## 🎭 Komponen UI

### 1. Tombol (Button)
```dart
// Primary Button (Filled)
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF6C63FF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 5,
  ),
  child: Text('Tombol Utama', style: TextStyle(color: Colors.white)),
)

// Secondary Button (Outlined)
OutlinedButton(
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: Color(0xFF6C63FF), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  child: Text('Tombol Sekunder'),
)
```

### 2. Text Fields
```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Placeholder text',
    hintStyle: TextStyle(color: Colors.grey[400]),
    filled: true,
    fillColor: Colors.white.withOpacity(0.1),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Color(0xFFD4A574).withOpacity(0.3),
      ),
    ),
  ),
  style: TextStyle(color: Colors.white),
)
```

### 3. Cards & Containers
```dart
// Info Card (dengan border emas)
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xFFD4A574).withOpacity(0.15),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Color(0xFFD4A574),
      width: 2,
    ),
  ),
  child: Column(...)
)

// Category Card (Semi-transparent)
Container(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Color(0xFFD4A574).withOpacity(0.3),
      width: 2,
    ),
  ),
  child: Text('Kategori', style: TextStyle(color: Colors.white)),
)
```

### 4. Teks & Typography

#### Heading (Judul Utama)
```dart
Text(
  'Quiz Master',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFFD4A574), // Emas untuk judul besar
  ),
)
```

#### Subheading
```dart
Text(
  'Pilih Kategori',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
)
```

#### Body Text
```dart
Text(
  'Deskripsi atau konten utama',
  style: TextStyle(
    fontSize: 16,
    color: Colors.white,
    height: 1.5,
  ),
)
```

#### Secondary Text
```dart
Text(
  'Teks sekunder atau hint',
  style: TextStyle(
    fontSize: 14,
    color: Colors.grey[300],
  ),
)
```

### 5. Badge/Tag

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: Color(0xFF6C63FF),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    'Tag',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  ),
)
```

---

## 🎯 Panduan Penggunaan Warna

### ✅ Warna yang Sesuai Gunakan
- ✅ Teks putih di atas background gelap
- ✅ Emas (#D4A574) untuk judul dan ornamen
- ✅ Ungu (#6C63FF) untuk tombol dan action items
- ✅ Semi-transparent white (10%) untuk field input
- ✅ Warna status (hijau, kuning, merah) untuk feedback

### ❌ Hindari
- ❌ Teks hitam atau abu-abu gelap (tidak readible)
- ❌ Warna cerah yang saturated (berlebihan)
- ❌ Font size < 12px (terlalu kecil)
- ❌ Contrast ratio < 4.5:1 (accessibility issue)

---

## 📏 Spacing & Layout

### Padding Standard
- **Large**: 24px (section padding)
- **Medium**: 16px (container padding)
- **Small**: 12px (item spacing)
- **Minimal**: 8px (between elements)

### Border Radius
- **Large**: 16px (cards, major containers)
- **Medium**: 12px (buttons, input fields)
- **Small**: 8px (minor elements, badges)
- **Round**: 20-50px (pill-shaped buttons)

### Opacity Levels
- **High**: 0.25-0.30 (prominent elements)
- **Medium**: 0.15-0.20 (secondary content)
- **Low**: 0.08-0.12 (background patterns)
- **Minimal**: 0.05-0.08 (subtle texture)

---

## 🎬 Animasi & Interaksi

### Button Feedback
- Hover: Elevate shadow
- Pressed: Reduce opacity
- Disabled: Gray out with reduced opacity

### Loading Indicator
```dart
CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
  strokeWidth: 2,
)
```

### Transitions
- Duration standar: 300ms untuk perubahan state
- Duration panjang: 500ms untuk navigasi
- Curve: Curves.easeInOut untuk smooth animation

---

## 📱 Responsive Breakpoints

- **Mobile**: < 600px (phone)
- **Tablet**: 600px - 1200px
- **Desktop**: > 1200px

Desain ini terutama dioptimalkan untuk **Mobile First** approach.

---

## ✨ Best Practices

1. **Konsistensi Warna**: Gunakan palet yang sudah ditentukan
2. **Kontras Teks**: Selalu gunakan white atau grey[300] untuk teks
3. **Spacing**: Ikuti spacing grid (8, 12, 16, 24px)
4. **Border Radius**: Jangan mix border radius yang berbeda secara random
5. **Elevation**: Gunakan shadows untuk mendefinisikan hierarchy
6. **Dark Mode Ready**: Semua warna sudah tested di dark background
7. **Accessibility**: Pastikan contrast ratio sufficient untuk readability

---

## 🔍 Contoh Implementasi

### Kombinasi yang Baik ✅
- White text + Navy background + Gold accent
- Purple button + Dark background
- Semi-transparent white container + Navy background + Gold border

### Kombinasi yang Buruk ❌
- Dark gray text + Navy background (tidak readible)
- Light yellow button (hard to see)
- Too many colors in one screen

---

## 📝 Catatan Pengembang

- Setiap screen harus menggunakan `LuxuryBackgroundScaffold`
- Custom widgets harus mengikuti palet warna yang ditentukan
- Test readability di device dengan brightness berbeda
- Gunakan opacity tools di Figma/design tool untuk preview
- Maintain WCAG AA contrast ratio untuk accessibility

---

Last Updated: May 12, 2026
Design System Version: 1.0
