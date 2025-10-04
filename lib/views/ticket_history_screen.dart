import 'package:flutter/material.dart';
import '../models/ticket.dart';
import 'detail_screen.dart';

class TicketHistoryScreen extends StatelessWidget {
  const TicketHistoryScreen({super.key});

  String getStatusText(TicketStatus status) {
    switch (status) {
      case TicketStatus.reserved:
        return "⏳ Đang giữ chỗ";
      case TicketStatus.paid:
        return "💳 Đã thanh toán";
      case TicketStatus.watched:
        return "✅ Đã xem";
    }
  }

  Color getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.reserved:
        return Colors.orange;
      case TicketStatus.paid:
        return Colors.blue;
      case TicketStatus.watched:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch sử vé"), centerTitle: true),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScreen(movie: ticket.movie, ticket: ticket),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  ticket.movie.posterUrl,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(ticket.movie.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Suất: ${ticket.showTime} | Ghế: ${ticket.seat}"),
                  Text("Giá: ${ticket.price.toStringAsFixed(0)} VND"),
                ],
              ),
              trailing: Chip(
                label: Text(getStatusText(ticket.status)),
                backgroundColor: getStatusColor(ticket.status).withOpacity(0.2),
                labelStyle: TextStyle(
                  color: getStatusColor(ticket.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
