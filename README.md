Markdown

# Flutter Simple E-commerce App - Tutorial Lengkap

Aplikasi e-commerce sederhana ini dibangun menggunakan Flutter, dirancang untuk pemula yang ingin memahami alur kerja aplikasi e-commerce dari UI hingga integrasi dasar. Aplikasi ini menampilkan desain UI/UX yang bersih dan konsisten dengan tema gradien yang menarik, mencakup halaman login, daftar produk, dan detail produk.

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
2. Navigasi ke Direktori Proyek
Masuk ke direktori proyek yang baru saja Anda kloning:

Bash

cd flutter-simple-shop
3. Dapatkan Dependencies
Pastikan http dan provider sudah ditambahkan di bagian dependencies pada file pubspec.yaml Anda:

YAML

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^1.2.1 # Tambahkan atau update ini
  provider: ^6.1.2 # Tambahkan atau update ini
Setelah itu, jalankan perintah ini untuk mengunduh semua package Dart yang dibutuhkan oleh proyek:

Bash

flutter pub get
4. Jalankan Aplikasi
Setelah dependencies terunduh, Anda bisa menjalankan aplikasi di emulator, simulator, atau perangkat fisik Anda:

Bash

flutter run
Aplikasi akan diluncurkan, dimulai dari LoginPage yang telah didesain ulang.

Struktur Folder Proyek
Berikut adalah struktur folder utama proyek ini, yang membantu dalam organisasi kode dan pemisahan tanggung jawab:

.
├── .dart_tool/
├── .idea/
├── .vscode/
├── android/
├── build/
├── Hasil Screenshot/  (Folder opsional untuk menyimpan screenshot aplikasi)
├── ios/
├── lib/
│   ├── models/
│   │   ├── cart_item.dart
│   │   └── product.dart
│   ├── network/
│   │   └── api.dart
│   ├── page/
│   │   ├── cart_page.dart         (Jika ada halaman keranjang)
│   │   ├── home_page.dart         (Jika ada halaman utama lain selain daftar produk)
│   │   ├── login_page.dart
│   │   ├── product_detail_page.dart
│   │   └── produk_list_page.dart  (Nama file daftar produk Anda)
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── cart_provider.dart
│   └── main.dart
├── linux/
├── macos/
├── test/
├── web/
├── windows/
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── devtools_options.yaml
├── flutter_application_1.iml
├── pubspec.lock
├── pubspec.yaml
└── README.md
Penjelasan Struktur:

lib/: Berisi semua kode sumber Dart aplikasi Anda.

models/: Definisi model data (misalnya, Product, CartItem).

network/: Logika untuk panggilan API (misalnya, api.dart).

page/: Definisi halaman-halaman UI aplikasi (misalnya, LoginPage, ProductListPage, ProductDetailPage).

providers/: Kelas-kelas yang mengelola state aplikasi menggunakan Provider package (misalnya, AuthProvider, CartProvider).

main.dart: Titik masuk utama aplikasi.

Implementasi Kode Detail per File
Bagian ini menjelaskan secara detail implementasi setiap file penting dalam proyek, lengkap dengan code snippet untuk membantu Anda memahami dan mereplikasi. Pastikan untuk mencocokkan code snippet ini dengan kode Anda yang sebenarnya di proyek Anda.

lib/main.dart
Ini adalah titik masuk utama aplikasi Anda. Mengatur tema aplikasi secara keseluruhan, rute navigasi, dan provider global.

Dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_simple_shop/page/login_page.dart';
import 'package:flutter_simple_shop/page/produk_list_page.dart'; // Nama file daftar produk Anda
import 'package:flutter_simple_shop/page/product_detail_page.dart';
import 'package:flutter_simple_shop/providers/cart_provider.dart';
import 'package:flutter_simple_shop/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme( // Atur tema AppBar agar konsisten dengan gradien
          backgroundColor: Colors.transparent, // AppBar transparan
          elevation: 0, // Tanpa shadow
          foregroundColor: Colors.white, // Warna teks dan ikon di AppBar
        ),
      ),
      initialRoute: '/login', // Atur halaman awal ke login
      routes: {
        '/login': (context) => LoginPage(), // Rute ke halaman login
        '/products': (context) => ProductListPage(), // Rute ke daftar produk
        '/productDetail': (context) => ProductDetailPage(), // Rute ke detail produk
      },
    );
  }
}
lib/page/login_page.dart
Membangun UI untuk halaman login dengan tema gradien yang menarik dan input field yang stylish.

Dart

import 'package:flutter/material.dart';
import 'package:flutter_simple_shop/page/produk_list_page.dart'; // Import halaman daftar produk

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Logika otentikasi sederhana
    if (_usernameController.text == 'user' && _passwordController.text == 'password') {
      // Navigasi ke halaman produk setelah login berhasil
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      // Tampilkan pesan error jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Gradien latar belakang
            colors: [
              Color(0xFFCC3366), // Pink gelap
              Color(0xFF990033), // Merah maroon
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Icon Kunci
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock, // Icon kunci
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                // Judul
                Text(
                  'Access Your Shopping Account', // Teks judul
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Input Username
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // Transparan
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.person, color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                // Input Password
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // Transparan
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 40),
                // Tombol Login
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient( // Gradien tombol
                      colors: [
                        Color(0xFFCC3366),
                        Color(0xFF990033),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Transparan agar gradien terlihat
                      shadowColor: Colors.transparent, // Menghilangkan shadow default
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login', // Teks tombol
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
lib/page/produk_list_page.dart
Menampilkan daftar produk dengan UI card yang konsisten dan kemampuan navigasi ke detail produk.

Dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_simple_shop/models/product.dart';
import 'package:flutter_simple_shop/providers/cart_provider.dart';
import 'package:flutter_simple_shop/network/api.dart'; // Untuk mendapatkan data produk

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = Api.fetchProducts(); // Memuat produk dari API
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( // Gradien AppBar
              colors: [Color(0xFFCC3366), Color(0xFF990033)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Tombol Logout
            onPressed: () {
              // Logika logout, misalnya membersihkan session atau kembali ke halaman login
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white), // Icon keranjang di AppBar
            onPressed: () {
              // Navigasi ke halaman keranjang (jika ada halaman keranjang yang terpisah)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fitur Keranjang belum diimplementasikan.')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Gradien latar belakang body
            colors: [
              Color(0xFFCC3366),
              Color(0xFF990033),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (snapshot.hasError) {
              // Menampilkan error secara lebih informatif
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: ${snapshot.error.toString()}. Pastikan API berfungsi atau URL benar.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada produk ditemukan.', style: TextStyle(color: Colors.white)));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke detail produk dengan membawa objek produk
                      Navigator.pushNamed(context, '/productDetail', arguments: product);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient( // Gradien untuk setiap card produk
                          colors: [
                            Color(0xFFE65C7C), // Pink lebih terang
                            Color(0xFFC24C66), // Pink gelap
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Hero(
                            tag: product.id, // Tag unik untuk animasi Hero
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(product.thumbnail), // Gambar thumbnail produk
                              radius: 30,
                              onBackgroundImageError: (exception, stackTrace) {
                                // Fallback jika gambar thumbnail gagal dimuat
                                print('Error loading thumbnail: $exception');
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.title, // Nama produk
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Rp ${product.price.toStringAsFixed(2)}', // Harga produk
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Colors.white), // Icon tambahkan ke keranjang
                            onPressed: () {
                              cartProvider.addItem(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product.title} ditambahkan ke keranjang!')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
lib/page/product_detail_page.dart
Menampilkan informasi detail sebuah produk dan opsi untuk menambahkannya ke keranjang.

Dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_simple_shop/models/product.dart';
import 'package:flutter_simple_shop/providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pastikan arguments tidak null dan bertipe Product
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( // Gradien AppBar
              colors: [Color(0xFFCC3366), Color(0xFF990033)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Tombol kembali
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Gradien latar belakang body
            colors: [
              Color(0xFFCC3366),
              Color(0xFF990033),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Gambar Produk
              Center(
                child: Hero(
                  tag: product.id, // Tag unik untuk animasi Hero
                  child: Container(
                    width: 250, // Lebar gambar
                    height: 250, // Tinggi gambar
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect( // Memastikan gambar terpangkas sesuai borderRadius
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        product.image, // URL gambar produk utama
                        fit: BoxFit.contain, // Agar gambar tidak terpotong
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: Icon(Icons.broken_image, size: 100, color: Colors.white70)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Nama Produk & Harga & Deskripsi
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxBoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title, // Nama produk
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rp ${product.price.toStringAsFixed(2)}', // Harga produk
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      product.description, // Deskripsi produk
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Tombol Tambahkan ke Keranjang
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient( // Gradien tombol
                    colors: [
                      Color(0xFFE65C7C), // Pink lebih terang
                      Color(0xFFC24C66), // Pink gelap
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.title} ditambahkan ke keranjang!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Transparan agar gradien terlihat
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Tambahkan ke Keranjang', // Teks tombol
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
lib/models/product.dart
Definisi model data untuk objek Product.

Dart

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image; // URL gambar utama produk
  final String thumbnail; // URL gambar thumbnail produk

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.thumbnail,
  });

  // Factory constructor untuk membuat Product dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      // Asumsi 'images' adalah List, dan kita ambil yang pertama atau yang sesuai
      // Berikan fallback jika 'images' null atau kosong
      image: json['images'] != null && (json['images'] as List).isNotEmpty
          ? json['images'][0] as String
          : '[https://via.placeholder.com/250](https://via.placeholder.com/250)', // Fallback image untuk detail
      // Asumsi 'thumbnail' adalah String
      // Berikan fallback jika 'thumbnail' null
      thumbnail: json['thumbnail'] as String? ?? '[https://via.placeholder.com/50](https://via.placeholder.com/50)', // Fallback thumbnail untuk list
    );
  }
}
lib/models/cart_item.dart
Definisi model data untuk item di keranjang belanja.

Dart

import 'package:flutter_simple_shop/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
lib/network/api.dart
Kelas untuk menangani panggilan API dan mendapatkan data produk. Anda bisa mengintegrasikan dengan API dummy seperti dummyjson.com.

Dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_simple_shop/models/product.dart';

class Api {
  static const String _baseUrl = '[https://dummyjson.com](https://dummyjson.com)'; // Contoh API dummy

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Pastikan 'products' ada di response JSON
        if (data.containsKey('products') && data['products'] is List) {
          final List<dynamic> productListJson = data['products'];
          return productListJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Format respons API tidak valid: Tidak ada kunci "products" atau bukan list.');
        }
      } else {
        throw Exception('Gagal memuat produk: Status Code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Gagal terhubung ke API atau error parsing data: $e');
    }
  }

  // Anda bisa menambahkan metode lain di sini, misalnya untuk login, register, dll.
  /*
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal login: ${response.statusCode}');
    }
  }
  */
}
lib/providers/auth_provider.dart
Kelas Provider untuk mengelola status otentikasi pengguna.

Dart

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  // Metode login sederhana
  void login(String username, String password) {
    // Di sini Anda akan memanggil Api.login() atau logika otentikasi lainnya
    // Untuk contoh ini, kita asumsikan login berhasil jika username/password tidak kosong.
    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
    notifyListeners(); // Memberi tahu widget yang mendengarkan perubahan
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
lib/providers/cart_provider.dart
Kelas Provider untuk mengelola keranjang belanja.

Dart

import 'package:flutter/material.dart';
import 'package:flutter_simple_shop/models/product.dart';
import 'package:flutter_simple_shop/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount {
    return _items.fold(0, (total, current) => total + current.quantity);
  }

  double get totalAmount {
    return _items.fold(0.0, (total, current) => total + current.product.price * current.quantity);
  }

  void addItem(Product product) {
    int existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _items[existingIndex].incrementQuantity();
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
Pemecahan Masalah Umum (Aplikasi Flutter)
Error The getter 'image' isn't defined for the type 'Product'.:

Penyebab: Ini sering terjadi jika model Product Anda tidak memiliki properti image atau namanya salah.

Solusi: Pastikan di file lib/models/product.dart, Anda memiliki final String image; dan di Product.fromJson Anda mem-parsing nilai untuk image dengan benar dari JSON. Pastikan juga API yang Anda gunakan mengembalikan URL gambar di properti yang sesuai.

Error Exception: Terjadi kesalahan: type 'Null' is not a subtype of type 'String':

Penyebab: Biasanya terjadi ketika kode Anda mengharapkan String tetapi menerima null. Ini seringkali terkait dengan data yang berasal dari API (misalnya, properti gambar yang hilang atau null).

Solusi: Periksa Product.fromJson atau bagian kode yang memproses data dari API. Pastikan Anda menangani kasus null dengan memberikan nilai default (misalnya ?? 'https://via.placeholder.com/150') atau melakukan pengecekan null sebelum menggunakan nilai tersebut.

Error Could not find a generator for route RouteSettings("/productDetail"):

Penyebab: Rute /productDetail tidak terdaftar dengan benar di MaterialApp Anda, atau namanya salah ketik.

Solusi: Pastikan di lib/main.dart pada bagian routes, Anda memiliki entri yang benar seperti '/productDetail': (context) => ProductDetailPage(),.

Kontribusi
Kami sangat menyambut kontribusi Anda untuk proyek sederhana ini! Jika Anda memiliki ide untuk fitur baru, perbaikan bug, atau peningkatan UI/UX, silakan ikuti langkah-langkah berikut:

Fork repositori ini.

Buat branch fitur baru (git checkout -b feature/NamaFiturAnda).

Lakukan perubahan Anda.

Lakukan commit perubahan Anda (git commit -m 'Tambahkan: Deskripsi fitur baru').

Push ke branch Anda (git push origin feature/NamaFiturAnda).

Buka Pull Request baru.