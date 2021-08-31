class Diagnostics {
  final String id;
  final String title;
  final String description;
  final String image;

  const Diagnostics({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Diagnostics.fromJson(Map<String, dynamic> json) {
    return Diagnostics(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
    );
  }
}
