import 'package:flutter/material.dart';
import 'package:quan_ly_sach_flutter_2026/models/book.dart';
import 'add_book_screen.dart';
import 'book_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Danh sách dữ liệu mẫu lưu trong bộ nhớ tạm
  final List<Book> _books = [
    Book(
      title: 'Lập trình Android cơ bản',
      author: 'Nguyễn Văn A',
      category: 'Công nghệ',
      status: 'Đang đọc',
      rating: 4.0,
      note: 'Sách dành cho người mới bắt đầu',
    ),
    Book(
      title: 'Đắc nhân tâm',
      author: 'Dale Carnegie',
      category: 'Kỹ năng sống',
      status: 'Đã đọc',
      rating: 5.0,
      note: 'Sách rất hay về giao tiếp',
    ),
    Book(
      title: 'Dế Mèn phiêu lưu ký',
      author: 'Tô Hoài',
      category: 'Văn học',
      status: 'Chưa đọc',
      rating: 0.0,
      note: 'Truyện thiếu nhi kinh điển',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Tính toán số liệu thống kê
    int total = _books.length;
    int read = _books.where((b) => b.status == 'Đã đọc').length;
    int unread = total - read;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện của tôi', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00796B),
        automaticallyImplyLeading: false, // Ẩn nút Back
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Khối thống kê
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00796B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('$total', 'Tổng số sách'),
                  _buildStatItem('$read', 'Đã đọc'),
                  _buildStatItem('$unread', 'Chưa đọc xong'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Danh sách sách', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Danh sách sách cuộn được
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tác giả: ${book.author}'),
                          Row(
                            children: [
                              Chip(label: Text(book.category), padding: EdgeInsets.zero),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(book.status),
                                backgroundColor: book.status == 'Đã đọc' ? Colors.green[100] : Colors.orange[100],
                              ),
                              const Spacer(),
                              Text('★ ${book.rating.toInt()}'),
                            ],
                          )
                        ],
                      ),
                      // Nhấn vào một cuốn sách -> Chuyển sang màn hình Chi tiết
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailScreen(
                              book: book,
                              onDelete: () {
                                setState(() {
                                  _books.removeAt(index); // Xóa khỏi danh sách
                                });
                              },
                              onUpdate: () {
                                setState(() {}); // Cập nhật lại giao diện
                              },
                            ),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),

            // Nút Thêm sách
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // Mở màn hình thêm sách và chờ nhận kết quả trả về
                  final newBook = await Navigator.push<Book>(
                    context,
                    MaterialPageRoute(builder: (context) => const AddBookScreen()),
                  );
                  if (newBook != null) {
                    setState(() {
                      _books.add(newBook); // Thêm cuốn sách mới vào danh sách
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Thêm sách'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm phụ trợ tạo các ô thống kê nhỏ
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}