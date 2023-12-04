import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moonbase_explore/bloc/explore_bloc.dart';
//
// void main() {
//   // runApp(TempoExplore());
// }

class TempoExplore extends StatelessWidget {
  final Widget child;
  final Function(String)? onGuidedPreview;
  final Function(String) onQuizPressed;

  const TempoExplore({
    super.key,
    required this.child,
    required this.onGuidedPreview,
    required this.onQuizPressed,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ExploreBloc>().onGuidePreview = onGuidedPreview;
    context.read<ExploreBloc>().onQuizPressed = onQuizPressed;
    return Directionality(textDirection: TextDirection.ltr, child: child);
  }
}
