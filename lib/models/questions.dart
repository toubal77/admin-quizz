class Questions {
  final String id;
  final String annee;
  final String semestre;
  final String question;
  final String module;
  final String rep1;
  final String respo1;
  final String rep2;
  final String respo2;
  final String rep3;
  final String respo3;
  final String rep4;
  final String respo4;
  final String rep5;
  final String respo5;

  const Questions({
    required this.id,
    required this.annee,
    required this.semestre,
    required this.question,
    required this.module,
    required this.rep1,
    required this.respo1,
    required this.rep2,
    required this.respo2,
    required this.rep3,
    required this.respo3,
    required this.rep4,
    required this.respo4,
    required this.rep5,
    required this.respo5,
  });
  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['id'].toString(),
      annee: json['annee'].toString(),
      semestre: json['semester'].toString(),
      question: json['question'].toString(),
      module: json['name'].toString(),
      rep1: json['answer1'].toString(),
      respo1: json['resp1'].toString(),
      rep2: json['answer2'].toString(),
      respo2: json['resp2'].toString(),
      rep3: json['answer3'].toString(),
      respo3: json['resp3'].toString(),
      rep4: json['answer4'].toString(),
      respo4: json['resp4'].toString(),
      rep5: json['answer5'].toString(),
      respo5: json['resp5'].toString(),
    );
  }
}
