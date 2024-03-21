import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/utils.dart';
import '../../widgets/appBar.dart';

class TakePictures extends StatefulWidget {
  const TakePictures({super.key});

  @override
  State<TakePictures> createState() => _TakePicturesState();
}

class _TakePicturesState extends State<TakePictures> {
  File? _selectedImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: "Take Picture"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: AutoSizeText(
                  "Note: Snap and add wall picture instantly from camera.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.camera,
                      ].request();
                      if (statuses[Permission.camera]!.isGranted) {
                        _pickImageFromCamera();
                      } else {
                        await Utils.snackBar("No Permission Provided", context);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera, size: 34),
                            SizedBox(height: Get.height * 0.01),
                            const AutoSizeText(
                              "Take Picture",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.025),
            _selectedImage != null
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: Get.height * 0.55,
                        decoration: const BoxDecoration(),
                        clipBehavior: Clip.hardEdge,
                        child: FutureBuilder<Size>(
                          future: _getImageSize(_selectedImage!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AspectRatio(
                                aspectRatio: snapshot.data!.width /
                                    snapshot.data!.height,
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.contain,
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.025),
                      FilledButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          // controller.uploadReceipt(_selectedImage!, context);
                        },
                        child: const AutoSizeText(
                          "Fetch Information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : const AutoSizeText(
                    "Please Select an Image",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
          ],
        ),
      ),
    );
  }

  _pickImageFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Cropper",
              toolbarColor: Colors.green,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  Future<Size> _getImageSize(File imageFile) async {
    final image = await decodeImageFromList(await imageFile.readAsBytes());
    return Size(image.width.toDouble(), image.height.toDouble());
  }
}
