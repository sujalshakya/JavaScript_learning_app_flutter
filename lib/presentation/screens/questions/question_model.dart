import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  late String question;

  @HiveField(1)
  late String algorithm;

  @HiveField(2)
  late String explanation;

  @HiveField(3)
  late String flowchart;

  @HiveField(4)
  late String code;

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'algorithm': algorithm,
      'explanation': explanation,
      'flowchart': flowchart,
      'code': code,
    };
  }
}

QuestionModel questionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel()
    ..question = json['question']
    ..algorithm = json['algorithm']
    ..explanation = json['explanation']
    ..flowchart = json['flowchart']
    ..code = json['code'];
}
