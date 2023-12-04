
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:moonbase_explore/app_constants/size_constants.dart';
import 'package:moonbase_explore/model/video_model.dart';
import 'package:moonbase_explore/screen/create_guide/units/unit_or_video_view_box.dart';
import '../../../bloc/explore_bloc.dart';
import '../../../utils/tempo_dotted_box_widget.dart';

class UnitsVideoGridView extends StatefulWidget {
  final int index;

  const UnitsVideoGridView(this.index, {super.key});

  @override
  State<UnitsVideoGridView> createState() => _UnitsVideoGridViewState();
}

class _UnitsVideoGridViewState extends State<UnitsVideoGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(builder: (context, state) {
      List<Video>? videos = [];
      try {
        videos = state.units?[widget.index - 1].videos;
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      return ReorderableGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
          footer: [
           videos!.length>4?const SizedBox():TempoDottedBoxWidget(
              key: const ValueKey('add_video'),
              onPressed: () {
                context.read<ExploreBloc>().navigateToVideoBuilderScreen(
                    context: context, unitIndex: widget.index, videosData: null, videoNumber: videos?.length ?? 1);
              },
              child: Container(
                alignment: Alignment.center,
                child: const Text('Add video'),
              ),
            )
          ],
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (int i, int j) {
            context.read<ExploreBloc>().onReorderVideoForAUnit(i, j,unitIndex: widget.index);
          },
          children: videos
              .asMap()
              .entries
              .map(
                (mapEntry) => UnitOrVideoViewBox.videoViewContainer(
                  onTap: () {
                    context.read<ExploreBloc>().navigateToVideoBuilderScreen(
                        context: context,
                        unitIndex: widget.index,
                        videosData: mapEntry.value,
                        videoNumber: mapEntry.key + 1);
                  },
                  onDelete: () {
                    setState(() {
                      context.read<ExploreBloc>().removeVideoAtIndex(unitIndex: widget.index, mapEntry.key, context);
                    });
                  },
                  video: mapEntry.value,
                  key: ValueKey(mapEntry.key+1),
                ),
              )
              .toList());
    });
  }
}
