import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sách', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00796B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.book.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${widget.book.author} • ${widget.book.category}', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Chip(label: Text(widget.book.status)),
                    const Divider(),
                    Text('Đánh giá: ${widget.book.rating.toInt()} / 5 sao'),
                    Slider(
                      value: widget.book.rating,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: '${widget.book.rating.toInt()} sao',
                      onChanged: (value) {
                        setState(() {
                          widget.book.rating = value;
                        });

                        widget.onUpdate();
                      },
                    ),
                    Text('Ghi chú: ${widget.book.note}'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (widget.book.status == 'Chưa đọc') ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      widget.book.status = 'Đang đọc';
                    });
                    widget.onUpdate();
                  },
                  child: const Text('Đánh dấu đang đọc'),
                ),
              ),
              const SizedBox(height: 12),
            ] else if (widget.book.status != 'Đã đọc') ...[
              SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), foregroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    widget.book.status = 'Đã đọc';
                  });
                  widget.onUpdate();
                },
                child: const Text('Đánh dấu đã đọc'),
              ),
            ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Quay lại'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: () {
                  widget.onDelete();
                  Navigator.pop(context);
                },
                child: const Text('Xóa sách'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}