class User {
  final String id;
  final String nom;
  final String email;
  final String doc;

  const User({
    required this.id,
    required this.nom,
    required this.email,
    required this.doc,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_user'].toString(),
      nom: json['name'].toString(),
      email: json['email'].toString(),
      doc: json['doc'].toString(),
    );
  }
}
