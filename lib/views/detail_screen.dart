import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/ticket.dart';
import '../db/ticket_db.dart';
import '../main.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  final Ticket? ticket;
  const DetailScreen({super.key, required this.movie, this.ticket});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? selectedShowTime;
  String selectedSeat = "A1";

  @override
  void initState() {
    super.initState();
    // Nếu có ticket, đặt suất chiếu và ghế mặc định từ ticket
    if (widget.ticket != null) {
      selectedShowTime = widget.ticket!.showTime;
      selectedSeat = widget.ticket!.seat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

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
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
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
              children: movie.showTimes.map((time) {
                final isSelected = time == selectedShowTime;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedShowTime = time;
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Giá vé
            Text(
              "💰 Giá vé: ${movie.price.toStringAsFixed(0)} VND",
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 12),

            // Chọn ghế
            const Text(
              "Chọn ghế:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            DropdownButton<String>(
              value: selectedSeat,
              items: ["A1", "A2", "B1", "B2"]
                  .map(
                    (seat) => DropdownMenuItem(value: seat, child: Text(seat)),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedSeat = val;
                  });
                }
              },
              isExpanded: true,
            ),
            const SizedBox(height: 12),

            // Mô tả
            const Text(
              "Mô tả:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              movie.description.isNotEmpty
                  ? movie.description
                  : "Không có mô tả.",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Nút hành động
            Builder(
              builder: (BuildContext navigatorContext) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (selectedShowTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Vui lòng chọn suất chiếu!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final newTicket = Ticket(
                          movie: movie,
                          showTime: selectedShowTime!,
                          seat: selectedSeat,
                          price: movie.price,
                          status: TicketStatus.reserved,
                        );

                        try {
                          if (widget.ticket != null) {
                            await TicketDatabase.instance.deleteTicket(
                              widget.ticket!,
                            ); // Sử dụng instance
                          }
                          await TicketDatabase.instance.insertTicket(
                            newTicket,
                          ); // Sử dụng instance

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                widget.ticket == null
                                    ? "Đặt vé thành công!"
                                    : "Đổi suất chiếu thành công!",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pop(navigatorContext);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Lỗi: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.local_activity),
                      label: Text(
                        widget.ticket == null ? "Đặt vé" : "Đổi suất chiếu",
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        final mainScreenState = context
                            .findAncestorStateOfType<MainScreenState>();
                        if (mainScreenState != null) {
                          mainScreenState.setState(() {
                            mainScreenState.currentIndex = 0;
                          });
                        }
                        Navigator.popUntil(
                          navigatorContext,
                          (route) => route.isFirst,
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Quay lại Home"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
