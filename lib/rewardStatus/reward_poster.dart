import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:PTHPalathingal/Utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PosterShareWidget extends StatefulWidget {
  final String name;
  final String imagePath;
  final Color nameColor;

  /// 🔹 Position config (0.0 - 1.0)
  final double nameTopFactor;
  final double nameLeftFactor;
  final double nameWidthFactor;

  const PosterShareWidget({
    super.key,
    required this.name,
    required this.imagePath,
    this.nameTopFactor = 0.08,
    this.nameLeftFactor = 0.11,
    this.nameWidthFactor = 0.55,
    this.nameColor = Colors.white,
  });

  @override
  State<PosterShareWidget> createState() => _PosterShareWidgetState();
}

class _PosterShareWidgetState extends State<PosterShareWidget> {
  final GlobalKey _captureKey = GlobalKey();

  /// Capture & Share Poster
  Future<void> _sharePoster(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 50));

      final boundary =
          _captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData =
          await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/poster.png');

      await file.writeAsBytes(bytes);

      final box = context.findRenderObject() as RenderBox?;
      final origin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : const Rect.fromLTWH(0, 0, 1, 1);

      await Share.shareXFiles(
        [XFile(file.path)],
        sharePositionOrigin: origin,
      );
    } catch (e) {
      debugPrint('Share error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to share image')),
      );
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: Get.back,
              icon: SvgPicture.asset(
                'assets/backarrow_s.svg',
                width: 22,
                height: 22,
              ),
            ),
            const Spacer(),
            const Text(
              'Poster',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posterWidth = MediaQuery.of(context).size.width * 0.85;
    final posterHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Poster
          RepaintBoundary(
            key: _captureKey,
            child: SizedBox(
              width: posterWidth,
              height: posterHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        fit: BoxFit.cover,
                      ),

                      /// Name (relative positioning)
                      Positioned(
                        top: constraints.maxHeight *
                            widget.nameTopFactor,
                        left: constraints.maxWidth *
                            widget.nameLeftFactor,
                        child: SizedBox(
                          width: constraints.maxWidth *
                              widget.nameWidthFactor,
                          child: AutoSizeText(
                            widget.name,
                            maxLines: 1,
                            minFontSize: 10,
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.nameColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Gradient Share Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              height:
                  (MediaQuery.of(context).size.height * 0.065).clamp(
                44,
                56,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.0, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor2,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: ElevatedButton(
                  onPressed: () => _sharePoster(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
