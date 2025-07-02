// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page/login_page.dart'; // Pastikan ini diimpor
import 'page/produk_list_page.dart'; // Pastikan ini diimpor
import 'page/product_detail_page.dart'; // Pastikan ini diimpor
import 'providers/cart_provider.dart'; // Pastikan ini diimpor
import 'page/cart_page.dart'; // Pastikan ini diimpor

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Atur halaman awal ke login
      routes: {
        '/login': (context) => const LoginPage(), // <--- PASTIKAN ADA INI
        '/products': (context) => const ProductListPage(), // Rute ke daftar produk
        '/productDetail': (context) => const ProductDetailPage(),
        '/cart': (context) => const CartPage(), // Rute ke halaman keranjang
      },
    );
  }
}