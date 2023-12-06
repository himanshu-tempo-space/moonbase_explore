part of 'quizzes_bloc.dart';

@immutable
abstract class QuizzesEvent {}

class AddQuizEvent extends QuizzesEvent {
  final QuizModel quiz;
  AddQuizEvent(this.quiz);
}

class RemoveQuizEvent extends QuizzesEvent {
  final String quizId;
  RemoveQuizEvent(this.quizId);

}