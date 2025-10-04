import 'movie.dart';

enum TicketStatus { reserved, paid, watched }

class Ticket {
  final int? id;
  final Movie movie;
  final String showTime;
  final String seat;
  final double price;
  final TicketStatus status;

  Ticket({
    this.id,
    required this.movie,
    required this.showTime,
    required this.seat,
    required this.price,
    this.status = TicketStatus.reserved,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movie_title': movie.title,
      'poster_url': movie.posterUrl,
      'show_time': showTime,
      'seat': seat,
      'price': price,
      'status': status.index,
    };
  }

  static Ticket fromMap(Map<String, dynamic> map) {
    final movie = movies.firstWhere(
      (m) => m.title == map['movie_title'] && m.posterUrl == map['poster_url'],
      orElse: () => Movie(
        title: map['movie_title'],
        posterUrl: map['poster_url'],
        showTimes: [],
        genre: '',
        duration: '',
        price: map['price'],
        description: '',
      ),
    );

    return Ticket(
      id: map['id'],
      movie: movie,
      showTime: map['show_time'],
      seat: map['seat'],
      price: map['price'],
      status: TicketStatus.values[map['status']],
    );
  }
}

List<Ticket> tickets = [];
