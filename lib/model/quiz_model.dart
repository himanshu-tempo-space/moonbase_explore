import 'dart:convert';

enum QuizStatus {
  notStarted,
  inProgress,
  finished,
}

class QuizModel {
  String quizId;
  String quizTitle;
  String groupName;
  String courseName;
  int unitNumber;
  QuizStatus status;
  List<QuestionModel> questions;

  QuizModel(
      {required this.quizId,
      required this.quizTitle,
      required this.groupName,
      required this.courseName,
      required this.questions,
      required this.unitNumber,
      this.status = QuizStatus.notStarted});

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'],
      quizTitle: map['quizTitle'],
      groupName: map['groupName'],
      courseName: map['courseName'],
      unitNumber: map['unitNumber'] ?? 1,
      status: map['status'] != null
          ? QuizStatus.values.byName(map['status'])
          : QuizStatus.notStarted,
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'groupName': groupName,
      'unitNumber': unitNumber,
      'courseName': courseName,
      'status': status.name,
      'questions': questions.map((e) => e.toMap()).toList(),
    };
  }

  factory QuizModel.fromJson(String jsonString) {
    return QuizModel.fromMap(jsonDecode(jsonString));
  }
}

class QuestionModel {
  String questionText;
  String prompt;
  List<ChoiceModel> choices;
  int correctChoiceIndex;
  int userSelectedChoiceIndex;

  QuestionModel({
    required this.questionText,
    required this.choices,
    required this.correctChoiceIndex,
    this.prompt = "Select the appropriate answer",
    this.userSelectedChoiceIndex = -1,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionText: map['questionText'],
      prompt: map['prompt'],
      correctChoiceIndex: map['correctChoiceIndex'],
      userSelectedChoiceIndex: map['userSelectedChoiceIndex'] ?? -1,
      choices: [
        if (map['option1'] != null) ChoiceModel(choiceText: map["option1"]),
        if (map['option2'] != null) ChoiceModel(choiceText: map["option2"]),
        if (map['option3'] != null) ChoiceModel(choiceText: map["option3"]),
        if (map['option4'] != null) ChoiceModel(choiceText: map["option4"]),
      ],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'prompt': prompt,
      'correctChoiceIndex': correctChoiceIndex,
      'userSelectedChoiceIndex': userSelectedChoiceIndex,
      'option1': choices.isNotEmpty ? choices[0].choiceText : null,
      'option2': choices.length > 1 ? choices[1].choiceText : null,
      'option3': choices.length > 2 ? choices[2].choiceText : null,
      'option4': choices.length > 3 ? choices[3].choiceText : null,
    };
  }
}

class ChoiceModel {
  String choiceText;

  ChoiceModel({required this.choiceText});
}
