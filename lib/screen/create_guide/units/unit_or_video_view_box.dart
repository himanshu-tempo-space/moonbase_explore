
import 'package:flutter/material.dart';
import '../../../app_constants/app_colors.dart';
import '../../../model/unit_model.dart';
import '../../../model/video_model.dart';
import '../../../utils/tempo_display_image_from_file.dart';
import '../../../widgets/common_text.dart';

///
class UnitOrVideoViewBox extends StatelessWidget {
  const UnitOrVideoViewBox.unitViewContainer({super.key, required this.unit, this.video, required this.onTap, required this.onDelete});

  const UnitOrVideoViewBox.videoViewContainer({super.key, this.unit, required this.video, required this.onTap, required this.onDelete});

  final Unit? unit;
  final Video? video;
  final void Function() onTap;
  final void Function() onDelete;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              alignment: Alignment.center,
              color: primaryColor,
              child: unit != null && unit!.videos.isNotEmpty && unit!.videos.first.videoDetails.coverImagePath.isNotEmpty
                  ? _ViewBox(
                      title: 'Unit ${unit!.unitNumber}: ${unit!.title}',
                      localFilePath: unit!.videos.first.videoDetails.coverImagePath,
                    )
                  : video != null && video!.videoDetails.coverImagePath.isNotEmpty
                      ? _ViewBox(
                          localFilePath: video!.videoDetails.coverImagePath,
                          title: 'Video ${video!.videoNumber}: ${video!.title}',
                        )
                      : const Text('NO PHOTO'),
            ),
          ),
          Positioned(
            right: -15.0,
            top: -10.0,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewBox extends StatelessWidget {
  const _ViewBox({
    required this.localFilePath,
    required this.title,
  });

  final String localFilePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: primaryDarkColor,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: TText(
            title,
            variant: TypographyVariant.body,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(child: TempoDisplayImageFromFile(localFilePath)),
      ],
    );
  }
}
