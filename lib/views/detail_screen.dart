import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  movie.posterUrl,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tên phim
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Thể loại + thời lượng
            Row(
              children: [
                Text("🎬 ${movie.genre}"),
                const SizedBox(width: 16),
                Text("⏱ ${movie.duration}"),
              ],
            ),
            const SizedBox(height: 12),

            // Suất chiếu
            const Text(
              "Suất chiếu:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Wrap(
              spacing: 8,
              children: movie.showTimes
                  .map(
                    (time) => Chip(
                      label: Text(time),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),

            // Giá vé
            Text(
              "💰 Giá vé: ${movie.price.toStringAsFixed(0)} VND",
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 12),

            // Mô tả
            const Text(
              "Mô tả:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(movie.description),
            const SizedBox(height: 24),

            // Nút hành động
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Xử lý đặt vé
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Đặt vé thành công (demo)!"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.local_activity),
                  label: const Text("Đặt vé"),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Quay lại"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
