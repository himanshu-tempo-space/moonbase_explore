// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moonbase_explore/bloc/explore_bloc.dart';
import 'package:moonbase_explore/widgets/base_tempo_screen.dart';
import '../../model/guide.dart';
import 'create_guide_form.dart';

class CreateGuideScreen extends StatefulWidget {
  final bool isEditable;

  const CreateGuideScreen({super.key, this.isEditable = false});

  @override
  State<CreateGuideScreen> createState() => _CreateGuideScreenState();
}

class _CreateGuideScreenState extends State<CreateGuideScreen> {
  final videoSelectorKey = DateTime.now().toUtc().timeZoneOffset;

  @override
  void initState() {
    if (!widget.isEditable) {
      final blocInstance = context.read<ExploreBloc>();
      blocInstance.add(ResetEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgTempoScreen(
      pageTitle: 'Guide',
      resizeToAvoidBottomInset: true,
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          final blocInstance = context.read<ExploreBloc>();

          return CreateGuideForm(
            formKey: GlobalKey(),
            titleController: blocInstance.guideTitleController,
            descriptionController: blocInstance.guideDescriptionController!,
            categoriesController: blocInstance.guideCategoryController,
            exploreThumbnail: state.exploreThumbnail,
          );
        },
      ),
    );
  }
}
