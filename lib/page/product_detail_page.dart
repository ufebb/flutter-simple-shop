// lib/page/product_detail_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../network/api.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Product> _product;
  final Api api = Api();
  late int _productId;
  bool _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int? receivedProductId = ModalRoute.of(context)?.settings.arguments as int?;

    if (receivedProductId != null && (!_isDataLoaded || _productId != receivedProductId)) {
      _productId = receivedProductId;
      _product = api.fetchProductById(_productId);
      _isDataLoaded = true;
    } else if (receivedProductId == null && !_isDataLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Product ID not found for detail page!'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD81B60),
              Color(0xFF880E4F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isDataLoaded
            ? FutureBuilder<Product>(
                future: _product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'Produk tidak ditemukan.',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  } else {
                    final product = snapshot.data!;
                    return Column(
                      children: [
                        // Gambar Produk (tetap di bagian atas)
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            16.0,
                            MediaQuery.of(context).padding.top + kToolbarHeight + 24.0,
                            16.0,
                            0.0,
                          ),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const Center(
                                  child: Icon(Icons.broken_image, color: Colors.grey, size: 100),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Spacer untuk mendorong konten di bawah ke posisi yang diinginkan
                        // Kita bisa menggunakan 'flex' untuk mengontrol berapa banyak ruang yang diambil Spacer.
                        // Misalnya, flex: 2 akan mengambil dua kali lebih banyak ruang daripada Spacer dengan flex: 1.
                        // Atau, jika konten detail produk Anda bisa di-scroll,
                        // kita bisa membungkus Spacer dan Card/Button dalam Expanded SingleChildScrollView.
                        const Spacer(), // <--- Tetap gunakan Spacer untuk mengisi ruang kosong

                        // Card Detail Produk dan Tombol "Tambahkan ke Keranjang"
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0), // <--- Atur padding bawah di sini
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                color: Colors.white.withOpacity(0.15),
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Rp ${product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.lightGreenAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        product.description,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16), // Jarak antara Card dan Tombol
                              ElevatedButton(
                                onPressed: () {
                                  cartProvider.addItem(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.title} ditambahkan ke keranjang!',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: const Color(0xFFE91E63).withOpacity(0.9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.all(16),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE91E63),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 8,
                                ),
                                child: const Text(
                                  'Tambahkan ke Keranjang',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(color: Colors.white70),
              ),
      ),
    );
  }
}