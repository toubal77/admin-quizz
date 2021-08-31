class Suggestions {
  final String id;
  final String username;
  final String email;
  final String message;

  const Suggestions({
    required this.id,
    required this.username,
    required this.email,
    required this.message,
  });

  factory Suggestions.fromJson(Map<String, dynamic> json) {
    return Suggestions(
      id: json['id'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      message: json['message'].toString(),
    );
  }
}
