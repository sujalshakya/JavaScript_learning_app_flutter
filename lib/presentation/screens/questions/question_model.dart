class QuestionModel {
  late String question;
  late String algorithm;
  late String explanation;
  late String flowchart;
  late String code;
  late String id;

  QuestionModel({
    required this.question,
    required this.algorithm,
    required this.explanation,
    required this.flowchart,
    required this.code,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'algorithm': algorithm,
      'explanation': explanation,
      'flowchart': flowchart,
      'code': code,
      'id': id,
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      algorithm: json['algorithm'],
      explanation: json['explanation'],
      flowchart: json['flowchart'],
      code: json['code'],
      id: json['id'],
    );
  }
}
