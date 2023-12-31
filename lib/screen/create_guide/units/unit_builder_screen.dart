import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moonbase_explore/bloc/explore_bloc.dart';
import 'package:moonbase_explore/screen/create_guide/units/units_video_grid_view.dart';
import 'package:moonbase_explore/widgets/base_tempo_screen.dart';

import '../../../app_constants/size_constants.dart';
import '../../../model/unit_model.dart';
import '../../../utils/enums.dart';
import '../../../utils/utility.dart';
import '../../../widgets/common_edit_text_field.dart';
import '../../../widgets/common_text.dart';
import '../../../widgets/quiz_button.dart';
import '../../../widgets/tempo_text_button.dart';
import '../description_text_field.dart';

class UnitBuilderScreen extends StatefulWidget {
  const UnitBuilderScreen({super.key, required this.unit});

  final Unit? unit;

  @override
  State<UnitBuilderScreen> createState() => _UnitBuilderScreenState();
}

class _UnitBuilderScreenState extends State<UnitBuilderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    setInitialValues();
    super.initState();
  }

  setInitialValues() {
    if (widget.unit != null) {
      context.read<ExploreBloc>().currentUnitTitleController!.text = widget.unit!.title;
      context.read<ExploreBloc>().currentUnitDescriptionController!.text = widget.unit!.description;
    }
  }

  //==========================================================================================

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TTextField(
            controller: context.read<ExploreBloc>().currentUnitTitleController!,
            label: 'Title',
            choice: ChoiceEnum.text,
            hintText: 'Give your unit a name...',
          ),
          const SizedBox(height: 20),
          DescriptionTextField(
            controller: context.read<ExploreBloc>().currentUnitDescriptionController!,
            lableText: 'Description',
            hintText: 'The description of the unit...',
          ),
          const SizedBox(height: 20),
          QuizButton(
            onPressed: () {
              context.read<ExploreBloc>().onQuizPressed!(widget.unit?.id ?? '');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BgTempoScreen(
      pageTitle: 'Unit ${widget.unit?.unitNumber ?? 1}',
      child: Padding(
        padding: const EdgeInsets.all(TSizeConstants.padding20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildForm(),
                    heightBox20(),
                    const TText('Add your videos for the unit here', variant: TypographyVariant.bodyLarge),
                    heightBox20(),
                    UnitsVideoGridView(int.parse(widget.unit?.unitNumber.toString() ?? '1')),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: TSizeConstants.collabButtonsHeight,
              child: BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) => TempoTextButton(
                  text: 'Done',
                  radius: 15,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ExploreBloc>().saveTitleAndDescriptionUnit(
                          context.read<ExploreBloc>().currentUnitTitleController!.text,
                          context.read<ExploreBloc>().currentUnitDescriptionController!.text,
                          widget.unit?.unitNumber ?? 1);
                      context.read<ExploreBloc>().saveUnitDetails(context);
                    }
                  },
                  isButtonEnabled: state.units!.isNotEmpty,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
