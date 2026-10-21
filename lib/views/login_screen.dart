import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  // Bộ điều khiển để lấy dữ liệu văn bản từ các ô nhập (TextField)
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage; // Biến chứa thông báo lỗi (có thể null)

  void _handleLogin(){
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Kiểm tra bỏ trống
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Vui lòng nhập đầy đủ username và password';
      });
      return;
    }

    // 2. So sánh tài khoản cố định
    if (username == 'admin' && password == '123456'){
      // Đúng tài khoản -> Chuyển sang HomeScreen và đóng LoginScreen (pushReplacement)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Sai username hoặc password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF00796B),
                child: Text('B', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              const Text('Thư viện sách', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Đăng nhập để tiếp tục', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Tên đăng nhập', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _handleLogin,
                  child: const Text('Đăng nhập', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Tài khoản mẫu: admin / 123456', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}