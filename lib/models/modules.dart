class Modules {
  final String id;
  final String annee;
  final String semestre;
  final String image;
  final String nom;

  const Modules({
    required this.id,
    required this.annee,
    required this.semestre,
    required this.image,
    required this.nom,
  });

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
      id: json['id'].toString(),
      annee: json['annee'].toString(),
      semestre: json['semester'].toString(),
      image: json['image'].toString(),
      nom: json['name'].toString(),
    );
  }
}
