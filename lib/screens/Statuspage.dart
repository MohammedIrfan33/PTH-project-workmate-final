import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:PTHPalathingal/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class StatusScreen extends StatefulWidget {
  String name;
  StatusScreen({required this.name});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final GlobalKey _globalKey = GlobalKey();

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    'assets/backarrow_s.svg',
                    width: 22,
                    height: 22,
                    semanticsLabel: 'Example SVG',
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Make my status',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
              Container(
                width: 53,
                height: 53,
                // margin: const EdgeInsets.all(8),
                // decoration: ShapeDecoration(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //     borderRadius: BorderRadius.circular(18),
                //   ),
                // ),
                // child: IconButton(
                //   padding: const EdgeInsets.all(8),
                //   onPressed: () {Get.back();},
                //   icon: SvgPicture.asset(
                //     'assets/images/bellicon.svg',
                //     width: 16,
                //     height: 20,
                //     semanticsLabel: 'Example SVG',
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? imagefile;
  void pickImage() async {
    XFile? image;
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final cropedfile = await cropImages(image);
      setState(() {
        imagefile = File(cropedfile.path);
      });
    }
  }

  Future<CroppedFile> cropImages(XFile image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image1',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,

          aspectRatioPresets: [
            CropAspectRatioPreset.square, // Square aspect ratio (1:1)
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          rectHeight: 124,
          rectWidth: 124,
          aspectRatioPresets: [CropAspectRatioPresetCustom()],
        ),
      ],
    );

    return croppedFile!;
  }

  Future<void> _shareStatus() async {
    try {
      // Wait for the widget to be fully rendered
      await Future.delayed(const Duration(milliseconds: 200));
      
      final context = _globalKey.currentContext;
      if (context == null) {
        if (mounted) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Unable to capture status')),
          );
        }
        return;
      }
      
      final RenderRepaintBoundary boundary =
          context.findRenderObject() as RenderRepaintBoundary;
      
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        if (mounted) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Failed to convert image')),
          );
        }
        return;
      }
      
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // Use temporary directory for better cross-platform sharing compatibility
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/Status_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      if (await file.exists()) {
        await Share.shareXFiles([XFile(file.path)]);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Failed to create status for sharing')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text('Error sharing status: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Center(
        child: Column(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 340,
                  height: 400,
                  color: Colors.black, // Background color for corners
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Uploaded image - adjust left/right/top/bottom to position
                      if (imagefile != null)
                        Positioned(
                          left: 140,   // Distance from left edge
                          top: 70,   // Distance from top edge
                          child: Image.file(
                            imagefile!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),

                      // Template image on top (full size)
                      Image.asset(
                        'assets/home3/status_pankali copy.png',
                        width: 340,
                        height: 400,
                        fit: BoxFit.fill,
                      ),

                      // Name text
                      Positioned(
                        right: 30,
                        top: 195,
                        child: SizedBox(
                          height: 36,
                          width: 150,
                          child: Center(
                            child: AutoSizeText(
                              widget.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                wordSpacing: -1,
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Fmedium',
                                fontWeight: FontWeight.w500,
                              ),
                              textScaleFactor: 1.0,
                              maxLines: 2,
                              minFontSize: 8,
                              maxFontSize: 18,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 48, left: 24, right: 24),

              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: Container(
                        height: 41,

                        decoration: ShapeDecoration(
                          color: AppColors.primaryColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/upload.svg',
                              width: 22,
                              height: 22,
                              semanticsLabel: 'Example SVG',
                            ),
                            Text(
                              'Upload Photo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _shareStatus();
                      },
                      child: Container(
                        height: 41,
                        decoration: ShapeDecoration(
                          color: AppColors.primaryColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/share.svg',
                              width: 22,
                              height: 22,
                              semanticsLabel: 'Example SVG',
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              textScaleFactor: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (1, 1); // Ensures a perfect square

  @override
  String get name => '1x1 (Square)';
}
