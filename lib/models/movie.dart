class Movie {
  final String title;
  final String posterUrl;
  final List<String> showTimes;
  final String genre;
  final String duration;
  final double price;
  final String description;

  Movie({
    required this.title,
    required this.posterUrl,
    required this.showTimes,
    required this.genre,
    required this.duration,
    required this.price,
    required this.description,
  });
}

final List<Movie> movies = [
  Movie(
    title: "Avengers: Endgame",
    posterUrl: "assets/images/avengers.jpg",
    showTimes: ["10:00", "13:30", "17:00", "20:00"],
    genre: "Hành động, Khoa học viễn tưởng",
    duration: "3h 2m",
    price: 100000,
    description:
        "Trận chiến cuối cùng của các Avengers chống lại Thanos để cứu vũ trụ.",
  ),
  Movie(
    title: "Spider-Man: No Way Home",
    posterUrl: "assets/images/spiderman.jpg",
    showTimes: ["09:00", "12:00", "15:30", "19:00"],
    genre: "Hành động, Phiêu lưu",
    duration: "2h 28m",
    price: 90000,
    description: "Peter Parker đối mặt với thách thức khi đa vũ trụ bị mở ra.",
  ),
  Movie(
    title: "The Batman",
    posterUrl: "assets/images/batman.jpg",
    showTimes: ["11:00", "14:00", "18:00", "21:00"],
    genre: "Hành động, Tội phạm",
    duration: "2h 56m",
    price: 95000,
    description:
        "Bruce Wayne trong những ngày đầu trở thành Batman, đối đầu với Riddler.",
  ),
];
