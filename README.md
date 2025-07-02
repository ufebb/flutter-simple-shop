# Flutter Simple E-commerce App - Tutorial Lengkap

Aplikasi e-commerce sederhana ini dibangun menggunakan Flutter, dirancang untuk pemula yang ingin memahami alur kerja aplikasi e-commerce dari UI hingga integrasi dasar. Aplikasi ini menampilkan desain UI/UX yang bersih dan konsisten dengan tema gradien yang menarik, mencakup halaman login, daftar produk, dan detail produk.

## Daftar Isi

1.  [Fitur Utama](#fitur-utama)
2.  [Prasyarat](#prasyarat)
3.  [Memulai Proyek](#memulai-proyek)
4.  [Struktur Folder Proyek](#struktur-folder-proyek)
5.  [Implementasi Kode Detail per File](#implementasi-kode-detail-per-file)
    * [lib/main.dart](#libmaindart)
    * [lib/page/login_page.dart](#libpagelogin_pagedart)
    * [lib/page/produk_list_page.dart](#libpageproduk_list_pagedart)
    * [lib/page/product_detail_page.dart](#libpageproduct_detail_pagedart)
    * [lib/models/product.dart](#libmodelsproductdart)
    * [lib/models/cart_item.dart](#libmodelscart_itemdart)
    * [lib/network/api.dart](#libnetworkapidart)
    * [lib/providers/auth_provider.dart](#libprovidersauth_providerdart)
    * [lib/providers/cart_provider.dart](#libproviderscart_providerdart)
6.  [Integrasi Git & GitHub](#integrasi-git--github)
7.  [Pemecahan Masalah Umum (Aplikasi Flutter)](#pemecahan-masalah-umum-aplikasi-flutter)
8.  [Kontribusi](#kontribusi)

---

## Fitur Utama

* **Halaman Login Interaktif:** Desain login yang modern dengan latar belakang gradien, input field yang stylish, dan tombol login yang responsif.
* **Daftar Produk Dinamis:** Menampilkan daftar produk dengan harga dan ikon keranjang, menggunakan desain card yang konsisten dengan tema aplikasi.
* **Halaman Detail Produk:** Menampilkan informasi detail tentang produk, termasuk gambar, harga, deskripsi, dan tombol "Tambahkan ke Keranjang".
* **Tema Gradien Konsisten:** Seluruh aplikasi menggunakan tema gradien merah muda/ungu yang memberikan tampilan modern dan terpadu.
* **Integrasi API Sederhana:** Struktur untuk mengintegrasikan data produk dari API eksternal.

## Prasyarat

Sebelum menjalankan proyek ini, pastikan Anda memiliki perangkat lunak berikut terinstal di sistem Anda:

* **Flutter SDK:** Ikuti panduan instalasi resmi Flutter: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
* **Git:** Unduh dan instal dari: [https://git-scm.com/downloads](https://git-scm.com/downloads)
* **Visual Studio Code (VS Code):** Unduh dari: [https://code.visualstudio.com/](https://code.visualstudio.com/) (atau IDE pilihan Anda)
* **Ekstensi Flutter dan Dart untuk VS Code.**

## Memulai Proyek

Ikuti langkah-langkah di bawah ini untuk mengkloning dan menjalankan aplikasi ini di lingkungan pengembangan lokal Anda.

### 1. Kloning Repositori

Buka terminal atau Command Prompt Anda, navigasikan ke direktori tempat Anda ingin menyimpan proyek, lalu kloning repositori ini. Pastikan Anda mengganti `ufebb` dengan username GitHub Anda dan `flutter-simple-shop` dengan nama repositori Anda yang sebenarnya.

```bash
git clone [https://github.com/ufebb/flutter-simple-shop.git](https://github.com/ufebb/flutter-simple-shop.git)