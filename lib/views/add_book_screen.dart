import 'package:flutter/material.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedCategory = 'Văn học';
  String _selectedStatus = 'Chưa đọc';
  double _rating = 3.0;

  final List<String> _categories = ['Văn học', 'Khoa học', 'Công nghệ', 'Kỹ năng sống', 'Khác'];

  void _saveBook() {
    if (_titleController.text.trim().isEmpty || _authorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập Tên sách và Tác giả!')),
      );
      return;
    }

    final newBook = Book(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      category: _selectedCategory,
      status: _selectedStatus,
      rating: _rating,
      note: _noteController.text.trim(),
    );

    Navigator.pop(context, newBook);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sách', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00796B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Tên sách *')),
            const SizedBox(height: 12),
            TextField(controller: _authorController, decoration: const InputDecoration(labelText: 'Tác giả *')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Thể loại'),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 12),
            const Text('Tình trạng đọc:'),
            Row(
              children: ['Chưa đọc', 'Đang đọc', 'Đã đọc'].map((status) {
                return Row(
                  children: [
                    Radio<String>(
                      value: status,
                      groupValue: _selectedStatus,
                      onChanged: (val) => setState(() => _selectedStatus = val!),
                    ),
                    Text(status, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text('Đánh giá: ${_rating.toInt()} / 5 sao'),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 5,
              label: '${_rating.toInt()} sao',
              onChanged: (val) => setState(() => _rating = val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Ghi chú', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  foregroundColor: Colors.white,
                ),
                onPressed: _saveBook,
                child: const Text('Lưu sách'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}