import 'dart:io';import 'package:auto_size_text/auto_size_text.dart';import 'package:flutter/material.dart';import 'package:get/get.dart';import 'package:image_picker/image_picker.dart';import 'package:permission_handler/permission_handler.dart';import '../../utils/utils.dart';import '../../widgets/appBar.dart';class TakePictures extends StatefulWidget {  const TakePictures({super.key});  @override  State<TakePictures> createState() => _TakePicturesState();}class _TakePicturesState extends State<TakePictures> {  final Rx<File?> _selectedImage = Rx<File?>(null);  final picker = ImagePicker();  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: const AppBarWidget(text: "Take Picture"),      body: SingleChildScrollView(        child: Padding(          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),          child: Column(            children: [              Row(                mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [                  Expanded(                    child: InkWell(                      onTap: () async {                        Map<Permission, PermissionStatus> statuses = await [                          Permission.camera,                        ].request();                        if (statuses[Permission.camera]!.isGranted) {                          _pickImageFromCamera();                        } else {                          await Utils.snackBar(                              "No Permission Provided", context);                        }                      },                      child: Card(                        elevation: 5,                        margin: EdgeInsets.zero,                        child: Padding(                          padding: const EdgeInsets.all(16),                          child: Column(                            mainAxisAlignment: MainAxisAlignment.center,                            children: [                              const Icon(Icons.camera, size: 34),                              SizedBox(height: Get.height * 0.01),                              const AutoSizeText(                                "Take Picture",                                style: TextStyle(                                  fontSize: 16,                                  fontWeight: FontWeight.w700,                                ),                              ),                            ],                          ),                        ),                      ),                    ),                  ),                ],              ),              SizedBox(height: Get.height * 0.025),              Obx(                () {                  return _selectedImage.value != null                      ? Column(                          children: [                            Container(                              width: double.infinity,                              height: Get.height * 0.54,                              decoration: const BoxDecoration(),                              clipBehavior: Clip.hardEdge,                              child: FutureBuilder<Size>(                                future: _getImageSize(_selectedImage.value!),                                builder: (context, snapshot) {                                  if (snapshot.hasData) {                                    return AspectRatio(                                      aspectRatio: snapshot.data!.width /                                          snapshot.data!.height,                                      child: Image.file(                                        _selectedImage.value!,                                        fit: BoxFit.contain,                                      ),                                    );                                  } else {                                    return const Center(                                      child: CircularProgressIndicator(),                                    );                                  }                                },                              ),                            ),                            SizedBox(height: Get.height * 0.025),                            FilledButton(                              style: ElevatedButton.styleFrom(                                minimumSize: const Size.fromHeight(50),                              ),                              onPressed: () {},                              child: const AutoSizeText(                                "Paint Wall",                                textAlign: TextAlign.center,                                style: TextStyle(                                  fontWeight: FontWeight.bold,                                  fontSize: 18,                                ),                              ),                            ),                          ],                        )                      : const AutoSizeText(                          "Please Select an Image",                          style: TextStyle(                            fontSize: 14,                            fontWeight: FontWeight.bold,                          ),                        );                },              )            ],          ),        ),      ),    );  }  _pickImageFromCamera() async {    await picker.pickImage(source: ImageSource.camera).then((value) {      if (value != null) {        _selectedImage.value = File(value.path);      }    });  }  Future<Size> _getImageSize(File imageFile) async {    final image = await decodeImageFromList(await imageFile.readAsBytes());    return Size(image.width.toDouble(), image.height.toDouble());  }}