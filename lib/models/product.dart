// lib/models/product.dart
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final String image; // Properti untuk gambar detail (detail_image atau main_image)

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Pastikan semua properti yang diharapkan sebagai String atau double
    // memiliki fallback jika nilai dari JSON adalah null.
    // Gunakan '??' operator untuk memberikan nilai default.
    return Product(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'No Title', // Fallback string
      description: json['description'] as String? ?? 'No description available.', // Fallback string
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Fallback double
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0, // Fallback double
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // Fallback double
      stock: json['stock'] as int? ?? 0, // Fallback int
      brand: json['brand'] as String? ?? 'Unknown Brand', // Fallback string
      category: json['category'] as String? ?? 'Uncategorized', // Fallback string
      thumbnail: json['thumbnail'] as String? ?? 'https://via.placeholder.com/150', // Fallback URL gambar
      // Mengambil gambar pertama dari array 'images', jika ada.
      // Jika 'images' null atau kosong, fallback ke 'thumbnail'.
      // Jika 'thumbnail' juga null, fallback ke placeholder.
      image: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? (json['images'][0] as String? ?? 'https://via.placeholder.com/300')
          : (json['thumbnail'] as String? ?? 'https://via.placeholder.com/300'),
    );
  }
}