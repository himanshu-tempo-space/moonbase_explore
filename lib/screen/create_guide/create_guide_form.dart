// import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moonbase_explore/app_constants/custom_snackbars.dart';
import 'package:moonbase_explore/app_constants/extensions.dart';
import 'package:moonbase_explore/bloc/explore_bloc.dart';
import 'package:moonbase_explore/screen/create_guide/location_selector.dart';
import 'package:moonbase_explore/utils/utility.dart';
import 'package:moonbase_explore/widgets/VideoDialog.dart';
import '../../app_constants/app_colors.dart';
import '../../app_constants/app_text_style.dart';
import '../../app_constants/size_constants.dart';
import '../../generated/assets.dart';
import '../../hive/local_storage_manager.dart';
import '../../utils/enums.dart';
import '../../utils/focus_node_disabled.dart';
import '../../widgets/common_edit_text_field.dart';
import '../../widgets/common_text.dart';
import '../../widgets/tempo_text_button.dart';
import 'description_text_field.dart';

class CreateGuideForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? titleController,
      descriptionController,
      categoriesController;
  final File? exploreThumbnail;

  const CreateGuideForm({super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    this.categoriesController,
    required this.exploreThumbnail});

  @override
  State<CreateGuideForm> createState() => _CreateGuideFormState();
}

class _CreateGuideFormState extends State<CreateGuideForm> {
  GlobalKey<ScaffoldState> trailerVideoKey = GlobalKey();
  GlobalKey<ScaffoldState> thumbnailKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.8,
          child: ListView(
            shrinkWrap: false,
            children: [
              /*  Padding(
                padding: const EdgeInsets.only(top: TSizeConstants.padding30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: viewingCard(widget.exploreThumbnail, context),
                    ),
                  ],
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        TSizeConstants.textFieldBorderRadius),
                    border: Border.all(
                      color: primaryDarkColor,
                      width: TSizeConstants.borderOpacity,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TText(
                            'Cover Photo',
                            variant: TypographyVariant.subtitle,
                            style: TextStyle(color: primaryDarkColor),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          futureBuilderWidget(),
                        ],
                      ),
                      const SizedBox(height: 5)
                    ],
                  ),
                ),
              ),

              TTextField(
                controller: widget.titleController!,
                label: 'Title',
                choice: ChoiceEnum.text,
                hintText: 'My awesome guide to the galaxy...',
              ),
              const SizedBox(height: 20),
              DescriptionTextField(
                controller: widget.descriptionController!,
                lableText: 'Description',
                hintText: 'The beautiful galaxy...',
              ),
              const SizedBox(height: 30),
              // const LocationSelector(),
              // const SizedBox(height: 30),
              /*    Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizeConstants.textFieldBorderRadius),
                  border: Border.all(
                    color: primaryDarkColor,
                    width: TSizeConstants.borderOpacity,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TText('Thumbnail', variant: TypographyVariant.subtitle),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        futureBuilderWidget(),
                      ],
                    ),
                    const SizedBox(height: 5)
                  ],
                ),
              ),
              const SizedBox(height: 30),*/
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  return SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: TSizeConstants.collabButtonsHeight,
                    child: TempoTextButton(
                      text: 'Add units',
                      radius: 15,
                      onPressed: () async {
                        await context.read<ExploreBloc>()
                            .reloadThumbnail()
                            .then((String? value){ if
                            (widget.formKey!.currentState!.validate() &&
                            value!=null) {
                        context.read<ExploreBloc>().saveGuideDetails(context);
                        }
                        else{
                        errorTopSnackBar(context, "Please upload the cover photo");
                        }});

                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget futureBuilderWidget() {
    return InkWell(
      onTap: () async {
        await context.read<ExploreBloc>().pickThumbnail(context);
        setState(() {});
      },
      child: FutureBuilder<String?>(
        future: context.read<ExploreBloc>().reloadThumbnail(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            return
              /*  widget.exploreThumbnail == null
                ? DottedBorder(
                  color: secondaryColor,
                  strokeWidth: 1,
                  radius: const Radius.circular(15),
                  borderType: BorderType.RRect,
                  dashPattern: const [8, 4, 5],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: SvgPicture.asset(
                              Assets.imagesUploadBillboardImage)),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
                :*/
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.30,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.40,
                child: DottedBorder(
                  color: secondaryColor,
                  strokeWidth: 1,
                  radius: const Radius.circular(15),
                  borderType: BorderType.RRect,
                  dashPattern: const [8, 4, 5],
                  child: Image.file(
                    snapshot.data!.isNotEmpty
                        ? File(snapshot.data!)
                        : File(widget.exploreThumbnail!.path),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.30,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.40,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              );
          } else {
            return DottedBorder(
              color: secondaryColor,
              strokeWidth: 1,
              radius: const Radius.circular(15),
              borderType: BorderType.RRect,
              dashPattern: const [8, 4, 5],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(Assets.imagesUploadBillboardImage),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget viewingCard(File? image, BuildContext context) {
    return image != null
        ? Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(File(image.path), fit: BoxFit.cover),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: primaryColor,
                      size: 30,
                    ),
                    Text(
                      'Change',
                      style: appSubTitleTextStyle,
                    )
                  ],
                ),
              ).onUserTap(() async {
                ImagePicker picker = ImagePicker();
                final exploreBloc = context.read<ExploreBloc>();
                exploreBloc.chooseGuideVideo(picker, context);
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: primaryColor,
                      size: 30,
                    ),
                    Text(
                      'View',
                      style: appSubTitleTextStyle,
                    )
                  ],
                ),
              ).onUserTap(() =>
                  showDialog(
                      context: context,
                      builder: (context) =>
                          VideoDialog(
                              videoFile: context
                                  .read<ExploreBloc>()
                                  .coverVideoController!
                                  .file))),
            ),
          ],
        ),
      ],
    )
        : Column(
      children: [
        DottedBorder(
          color: secondaryColor,
          strokeWidth: 1,
          radius: const Radius.circular(15),
          borderType: BorderType.RRect,
          dashPattern: const [8, 4, 5],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                      Assets.imagesUploadBillboardImage)),
              const SizedBox(height: 6),
              const TText(
                'Add trailer video here',
                variant: TypographyVariant.h1,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).onUserTap(() async {
          ImagePicker picker = ImagePicker();
          final exploreBloc = context.read<ExploreBloc>();
          exploreBloc.chooseGuideVideo(picker, context);
        }),
        const SizedBox(height: 5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TText(
              'What is a trailer video?',
              variant: TypographyVariant.h4,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            SizedBox(width: 2),
            Icon(
              Icons.info_outline,
              size: 15,
              color: secondaryColor,
            ),
          ],
        ).onUserTap(
              () async {
            await showAlertDailog(context,
                'A trailer video gives viewers an idea of what to expect from your guide. It will be viewable by all users from the explore page whether the guide is paid or free.',
                successOption: 'Got it', cancelOption: '', onSuccess: () {
                  Navigator.of(context).pop();
                }, onCancel: () {});
          },
        ),
      ],
    );
  }
}
