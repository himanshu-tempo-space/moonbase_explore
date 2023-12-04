import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:moonbase_explore/app_constants/size_constants.dart';
import 'package:moonbase_explore/bloc/explore_bloc.dart';
import 'package:moonbase_explore/model/collab_type.dart';
import 'package:moonbase_explore/model/unit_model.dart';
import 'package:moonbase_explore/screen/create_guide/units/unit_builder_screen.dart';
import 'package:moonbase_explore/widgets/base_tempo_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../model/video_model.dart';
import '../../../utils/common_no_data_widget.dart';
import '../../../utils/utility.dart';
import '../../../widgets/tempo_text_button.dart';
import '../../collab-publishing/collab_publish_screen.dart';
import 'all_units_view_builder.dart';

class UnitListScreen extends StatefulWidget {
  const UnitListScreen({super.key});

  @override
  State<UnitListScreen> createState() => _UnitListScreenState();
}

class _UnitListScreenState extends State<UnitListScreen> {
  Future<void> _onPressNext() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CollabPublishingScreen(
                collabType: CollabType.guide,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BgTempoScreen(
      pageTitle: 'Add Units',
      resizeToAvoidBottomInset: true,
      child: Padding(
        padding: const EdgeInsets.all(TSizeConstants.padding10),
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) => Column(
            children: [
              Expanded(
                child: state.units!.isNotEmpty
                    ? AllUnitsViewBuilder(
                        allUnits: state.units ?? [],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TempoNoDataWidget(
                            text:
                                '''Hey there! It looks like there are no units added to this guide yet. To add a unit, simply click on the "Add first unit" button and start creating your guide.''',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TempoTextButton(
                            text: 'Add first unit',
                            width: 0,
                            radius: 15,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UnitBuilderScreen(
                                        unit: Unit(id: '', unitNumber: 1, title: '', description: '', videos: []))),
                              );
                            },
                          )
                        ],
                      ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  state.units!.isNotEmpty? TempoTextButton(
                    text: 'Next',
                    onPressed: _onPressNext,
                  ):const SizedBox(),

                  const SizedBox(height: 10,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
