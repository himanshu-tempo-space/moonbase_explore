import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moonbase_explore/model/quiz_model.dart';

part 'quizzes_event.dart';

part 'quizzes_state.dart';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  QuizzesBloc() : super(const QuizzesState(quizzes: [])) {
    on<QuizzesEvent>((event, emit) {
      if (event is AddQuizEvent) {
        final newList = [...(state.quizzes ?? []), event.quiz];
        emit(state.copyWith(quizzes: newList));
      } else if (event is RemoveQuizEvent) {
        final newList = [...(state.quizzes ?? [])];

        int index =
            newList.indexWhere((element) => element.quizId == event.quizId);

        if (index > -1) {
          newList.removeAt(index);
          emit(state.copyWith(quizzes: newList));
        }
      }
    });
  }

  List<QuizModel> unitQuizzes(int unitNumber) {
    return state.quizzes?.where((e) => e.unitNumber == unitNumber).toList() ??
        <QuizModel>[];
  }

  List<QuizModel> get allQuizzes => state.quizzes ??<QuizModel>[];

}
