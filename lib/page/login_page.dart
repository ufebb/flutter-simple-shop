// lib/page/login_page.dart
import 'package:flutter/material.dart';
import '../network/api.dart';
import '../page/produk_list_page.dart'; // Perhatikan perubahan nama file jika sebelumnya produk_list_page.dart

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Api api = Api();

  bool _isLoading = false;

  Future<void> _validateLogin(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( // Menggunakan SnackBar instead of AlertDialog for empty input
        SnackBar(
          content: const Text(
            'Harap masukkan username dan password.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFD81B60), // Warna pink tema
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final users = await api.fetchUsers();
      final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProductListPage()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar( // Menggunakan SnackBar for wrong credentials
          SnackBar(
            content: const Text(
              'Username atau Password salah.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFFD81B60), // Warna pink tema
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar( // Menggunakan SnackBar for API connection error
        SnackBar(
          content: Text(
            'Terjadi kesalahan koneksi: $error',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFD81B60), // Warna pink tema
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD81B60), // Warna merah muda gelap
              Color(0xFF880E4F), // Warna ungu gelap
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Kunci
                const Icon(
                  Icons.lock,
                  size: 100, // Ukuran ikon lebih besar
                  color: Colors.white, // Warna ikon putih
                  shadows: [ // Tambahkan shadow pada ikon
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Judul Aplikasi
                const Text(
                  'Access Your Shopping Account', // Teks asli
                  style: TextStyle(
                    fontSize: 28, // Ukuran font lebih besar
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black54,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // TextField Username
                _buildTextField(
                  controller: usernameController,
                  label: 'Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                // TextField Password
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 30),

                // Tombol Login
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white) // Warna loading indicator
                    : Material( // Bungkus dengan Material untuk shadow
                        color: Colors.transparent, // Penting agar tidak menutupi gradien
                        elevation: 10.0, // Elevasi untuk shadow
                        shadowColor: Colors.black.withOpacity(0.6), // Warna shadow yang lebih gelap
                        borderRadius: BorderRadius.circular(15), // Border radius tombol
                        child: ElevatedButton(
                          onPressed: () => _validateLogin(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E63), // Warna pink tema Anda
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60, // Padding horizontal lebih besar
                              vertical: 16, // Padding vertikal lebih besar
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Border radius tombol
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20, // Ukuran font lebih besar
                              fontWeight: FontWeight.bold,
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

  // Helper method untuk membangun TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container( // Bungkus TextField dengan Container untuk shadow dan border
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15), // Latar belakang transparan untuk input field
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow untuk input field
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white), // Warna teks input
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.8)), // Warna ikon
          filled: false, // Hapus filled: true karena kita sudah pakai Container
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), // Warna label
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Warna hint
          border: InputBorder.none, // Hapus border default
          enabledBorder: OutlineInputBorder( // Border saat tidak aktif
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder( // Border saat aktif
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}