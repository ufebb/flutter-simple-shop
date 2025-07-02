# 🛍️ Flutter Simple E-commerce App

Aplikasi e-commerce sederhana ini dibuat menggunakan Flutter. Cocok untuk pemula yang ingin mempelajari alur aplikasi e-commerce dari sisi **UI/UX** hingga **integrasi API**. Aplikasi ini memiliki tema **gradien modern** dan fitur-fitur dasar seperti halaman login, daftar produk, dan detail produk.

---

## 🚀 Fitur Utama

- **Halaman Login Interaktif**: Desain modern dengan background gradien, field input stylish, dan tombol responsif.
- **Daftar Produk Dinamis**: Menampilkan produk dalam bentuk kartu dengan harga dan ikon keranjang.
- **Halaman Detail Produk**: Menampilkan gambar, deskripsi, dan tombol untuk menambahkan produk ke keranjang.
- **Tema Gradien Konsisten**: Menggunakan kombinasi merah muda dan ungu.
- **Integrasi API**: Mengambil data produk dari sumber API eksternal (DummyJSON).

---

## 🧰 Prasyarat

Sebelum menjalankan aplikasi, pastikan Anda telah menginstal:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/downloads)
- [Visual Studio Code](https://code.visualstudio.com/) (atau IDE pilihan Anda)
- Ekstensi Flutter dan Dart untuk VS Code

---

## ⚙️ Cara Menjalankan Proyek

### 1. Kloning Repositori

```bash
git clone https://github.com/ufebb/flutter-simple-shop.git
cd flutter-simple-shop
```

### 2. Tambahkan Dependency

Edit file `pubspec.yaml` Anda:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^1.2.1
  provider: ^6.1.2
```

Lalu jalankan:

```bash
flutter pub get
```

### 3. Jalankan Aplikasi

```bash
flutter run
```

---

## 🗂️ Struktur Folder

```
lib/
├── models/
│   ├── cart_item.dart
│   └── product.dart
├── network/
│   └── api.dart
├── page/
│   ├── login_page.dart
│   ├── produk_list_page.dart
│   ├── product_detail_page.dart
├── providers/
│   ├── auth_provider.dart
│   └── cart_provider.dart
└── main.dart
```

---

## 📦 Penjelasan File Penting

### `main.dart`
Mengatur routing aplikasi dan setup global provider.

### `login_page.dart`
UI login dengan validasi sederhana dan latar gradien.

### `produk_list_page.dart`
Menampilkan daftar produk dan memungkinkan navigasi ke halaman detail.

### `product_detail_page.dart`
Tampilan informasi produk lengkap dengan tombol tambah ke keranjang.

### `product.dart`
Model data produk yang diambil dari API.

### `cart_item.dart`
Model item yang ada di keranjang belanja.

### `api.dart`
Fetch data produk dari `https://dummyjson.com/products`.

---

## 🧪 Troubleshooting

| Error | Penyebab | Solusi |
|------|----------|--------|
| `image isn't defined for Product` | Properti `image` tidak ada di model | Tambahkan properti `image` di `product.dart` |
| `type 'Null' is not a subtype of type 'String'` | API mengembalikan `null` | Gunakan fallback `??` untuk nilai default |
| `Could not find a generator for route` | Rute tidak terdaftar | Tambahkan rute di `MaterialApp` dalam `main.dart` |

---

## 🤝 Kontribusi

Kami membuka kontribusi untuk pengembangan lebih lanjut:

1. Fork repositori ini.
2. Buat branch fitur baru:  
   `git checkout -b feature/NamaFitur`
3. Lakukan perubahan & commit:  
   `git commit -m 'Tambahkan: fitur baru'`
4. Push ke GitHub dan buka Pull Request.

---

## 📸 Screenshot (Opsional)

Letakkan screenshot aplikasi Anda di folder `Hasil Screenshot/` dan tambahkan ke bagian ini menggunakan:

```markdown
![Login Page](Hasil%20Screenshot/login.png)
![Product List](Hasil%20Screenshot/products.png)
```

---

## 📄 Lisensi

Proyek ini bebas digunakan untuk belajar atau pengembangan pribadi. Mohon cantumkan kredit jika digunakan ulang dalam bentuk publik.
