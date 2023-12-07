import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moonbase_explore/bloc/explore_bloc.dart';
//
// void main() {
//   // runApp(TempoExplore());
// }

class TempoExplore extends StatelessWidget {
  final Widget child;
  final Function(String, String)? onGuidedPreview;
  final Function(int, String) onQuizPressed;
  final StreamController<String>? quizCreationStream;

  const TempoExplore({
    super.key,
    required this.child,
    required this.onGuidedPreview,
    required this.onQuizPressed,
    this.quizCreationStream,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ExploreBloc>().onGuidePreview = onGuidedPreview;
    context.read<ExploreBloc>().onQuizPressed = onQuizPressed;
    if (quizCreationStream != null) {
      context
          .read<ExploreBloc>()
          .setQuizCreationStream(context, quizCreationStream!);
    }
    return Directionality(textDirection: TextDirection.ltr, child: child);
  }
}
