// lib/models/cart_item.dart
import '../models/product.dart'; // Import model Product yang sudah ada

class CartItem {
  final Product product; // Produk yang ditambahkan ke keranjang
  int quantity;         // Jumlah produk tersebut di keranjang

  CartItem({
    required this.product,
    this.quantity = 1, // Default quantity adalah 1
  });

  // Metode untuk menambah kuantitas
  void incrementQuantity() {
    quantity++;
  }

  // Metode untuk mengurangi kuantitas
  void decrementQuantity() {
    if (quantity > 1) { // Pastikan kuantitas tidak kurang dari 1
      quantity--;
    }
  }

  // Getter untuk mendapatkan total harga item ini (harga produk * kuantitas)
  double get totalPrice => product.price * quantity;
}