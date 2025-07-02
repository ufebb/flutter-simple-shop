# 🛍️ Flutter Simple E-commerce App

Aplikasi e-commerce sederhana ini dibuat menggunakan Flutter. Cocok untuk pemula yang ingin mempelajari alur aplikasi e-commerce dari sisi **UI/UX** hingga **integrasi API**. Aplikasi ini memiliki fitur halaman login, daftar produk, dan detail produk.

---

## 🚀 Fitur Utama

- **Halaman Login Interaktif**: Desain modern dengan background gradien dan field stylish.
- **Daftar Produk Dinamis**: Menampilkan produk dengan harga dan tombol tambah ke keranjang.
- **Halaman Detail Produk**: Menampilkan gambar, deskripsi, dan tombol keranjang.
- **Integrasi API**: Mengambil data produk dari sumber API eksternal (DummyJSON).

---

## 🧰 Prasyarat

Pastikan sudah menginstal:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/downloads)
- [Visual Studio Code](https://code.visualstudio.com/)
- Ekstensi Flutter dan Dart

---

## ⚙️ Cara Menjalankan Proyek

### 1. Kloning Proyek

```bash
git clone https://github.com/ufebb/flutter-simple-shop.git
cd flutter-simple-shop
```

### 2. Tambahkan Dependency

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

## 📄 Kode Sumber Penting

### `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_simple_shop/page/login_page.dart';
import 'package:flutter_simple_shop/page/produk_list_page.dart';
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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/products': (context) => ProductListPage(),
        '/productDetail': (context) => ProductDetailPage(),
      },
    );
  }
}
```

---

### `lib/page/login_page.dart`

```dart
import 'package:flutter/material.dart';
import 'produk_list_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == 'user' && _passwordController.text == 'password') {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
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
          gradient: LinearGradient(
            colors: [Color(0xFFCC3366), Color(0xFF990033)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Icon(Icons.lock, size: 80, color: Colors.white),
                SizedBox(height: 30),
                Text('Access Your Shopping Account',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                _buildTextField(_usernameController, 'Username', Icons.person),
                SizedBox(height: 20),
                _buildTextField(_passwordController, 'Password', Icons.lock, obscure: true),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                  child: Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
```

---

### `lib/page/produk_list_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../network/api.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = Api.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('Tidak ada produk'));

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('Rp ${product.price}'),
                leading: Image.network(product.thumbnail),
                onTap: () => Navigator.pushNamed(context, '/productDetail', arguments: product),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartProvider.addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.title} ditambahkan ke keranjang')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

---

### `lib/page/product_detail_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Detail Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.image, height: 250),
            SizedBox(height: 16),
            Text(product.title, style: TextStyle(fontSize: 24)),
            Text('Rp ${product.price.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text(product.description),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                cartProvider.addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.title} ditambahkan ke keranjang')),
                );
              },
              child: Text('Tambahkan ke Keranjang'),
            )
          ],
        ),
      ),
    );
  }
}
```

---

### `lib/models/product.dart`

```dart
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: (json['images'] as List?)?.first ?? 'https://via.placeholder.com/250',
      thumbnail: json['thumbnail'] ?? 'https://via.placeholder.com/50',
    );
  }
}
```

---

### `lib/models/cart_item.dart`

```dart
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  void incrementQuantity() => quantity++;
  void decrementQuantity() {
    if (quantity > 1) quantity--;
  }
}
```

---

### `lib/network/api.dart`

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class Api {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productList = json.decode(response.body)['products'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }
}
```

---

### `lib/providers/auth_provider.dart`

```dart
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void login(String username, String password) {
    _isAuthenticated = username.isNotEmpty && password.isNotEmpty;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
```

---

### `lib/providers/cart_provider.dart`

```dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (t, item) => t + item.quantity);
  double get totalAmount => _items.fold(0.0, (t, item) => t + item.product.price * item.quantity);

  void addItem(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].incrementQuantity();
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
```

---

## ✅ Selesai!