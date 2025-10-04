import 'movie.dart';

enum TicketStatus { reserved, paid, watched }

class Ticket {
  final Movie movie;
  final String showTime;
  final String seat;
  final double price;
  TicketStatus status;

  Ticket({
    required this.movie,
    required this.showTime,
    required this.seat,
    required this.price,
    this.status = TicketStatus.reserved,
  });
}

// Giả lập dữ liệu vé
final List<Ticket> tickets = [
  Ticket(
    movie: movies[0],
    showTime: "17:00",
    seat: "A5",
    price: 100000,
    status: TicketStatus.reserved,
  ),
  Ticket(
    movie: movies[1],
    showTime: "19:00",
    seat: "B7",
    price: 90000,
    status: TicketStatus.paid,
  ),
  Ticket(
    movie: movies[2],
    showTime: "21:00",
    seat: "C3",
    price: 95000,
    status: TicketStatus.watched,
  ),
];
