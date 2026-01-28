import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:msfmylthrithala/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptDownload extends StatefulWidget {
  String name;
  String Amount;
  ReceiptDownload({required this.name, required this.Amount});

  @override
  State<ReceiptDownload> createState() => _ReceiptDownloadState();
}

class _ReceiptDownloadState extends State<ReceiptDownload> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _capturePng() async {
    try {
      // Wait for the widget to be fully rendered
      await Future.delayed(const Duration(milliseconds: 200));
      
      final context = _globalKey.currentContext;
      if (context == null) {
        if (mounted) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Unable to capture receipt')),
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
      final filePath = '${tempDir.path}/Receipt_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      if (await file.exists()) {
        await Share.shareXFiles([XFile(file.path)]);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text('Failed to create receipt for sharing')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text('Error sharing receipt: ${e.toString()}')),
        );
      }
    }
  }

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
                  'Receipt',
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
                margin: const EdgeInsets.all(8),

                child: SizedBox(width: 16, height: 20),
              ),
            ],
          ),
        ),
      ),
    );
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
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/home3/receipt2.jpeg',
                      width: 340,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 52, // Adjust as per your template
                    top: 233, // Adjust as per your template
                    child: Container(
                      width: 106,
                      height: 38,
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,
                        children: [
                          AutoSizeText(
                            textAlign: TextAlign.start,
                            " ${widget.Amount.replaceAll(".00", "")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Fmedium',
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 105, // Adjust as per your template
                    top: 111, // Adjust as per your template
                    child: Container(
                      width: 220,

                      child: AutoSizeText(
                        "${widget.name}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Fmedium',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        minFontSize: 4,
                        maxFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 48, left: 24, right: 24),

              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    _capturePng();
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 60,
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
            ),
          ],
        ),
      ),
    );
  }
}
