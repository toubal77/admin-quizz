class Modules {
  final String id;
  final String annee;
  final String semestre;
  final String image;
  final String nom;
  final String view;

  const Modules({
    required this.id,
    required this.annee,
    required this.semestre,
    required this.image,
    required this.nom,
    required this.view,
  });

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
      id: json['id'].toString(),
      annee: json['annee'].toString(),
      semestre: json['semester'].toString(),
      image: json['image'].toString(),
      nom: json['name'].toString(),
      view: json['view'].toString(),
    );
  }
}
