import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:PTHPalathingal/ApiLists/Appdata.dart';
import 'package:PTHPalathingal/Utils/colors.dart';
import 'package:PTHPalathingal/controller/ChallengeListController.dart';
import 'package:PTHPalathingal/screens/QuickPaychallenge.dart';

import '../widgets/PorgressIndicator.dart';

class CartScreen extends StatefulWidget {
  final String Gobal_challengeid;
  final int packetCount;

  CartScreen({required this.Gobal_challengeid, this.packetCount = 0});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = Get.put(ChallengeListcontroller());

  @override
  void initState() {
    super.initState();
    controller.fullproducts(widget.packetCount);
  }

  @override
  void dispose() {
    Get.delete<ChallengeListcontroller>(); // Dispose of the controller
    super.dispose();
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
                    side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
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
                  'Cart',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 14,
                    fontFamily: 'Fontsemibold',
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
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: () {
                    goBackTwoPages();
                  },
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    width: 18,
                    height: 20,
                    semanticsLabel: 'Example SVG',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == 1);
  }

  Widget bottomBarTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD5D5D5)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total Amount',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 14,
                    fontFamily: 'Fontbold',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    textAlign: TextAlign.right,
                    "₹ ${controller.totalPrice.value}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Fontsemibold',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBarButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          if (controller.totalPrice.value > 0) {
            Get.to(
              Quickpaychallenge(
                modellist: controller.filteredProducts,
                uniqueid: AppData.uniqueid,
                backcount: 2,
                totalmaount: controller.totalPrice.toString(),
                challengid: widget.Gobal_challengeid,
                volunteer_id: AppData.volunteerId,
                showdistrictandassembly: "1",
              ),
            );
          } else {
            Get.snackbar(
              'Select', // Title of the Snackbar
              "please select any item ", // Message of the Snackbar
              snackPosition: SnackPosition.BOTTOM,
              titleText: const Text(
                'Select',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fontbold', // Set your custom font family here
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.0,
              ),
              messageText: const Text(
                'please select any item',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:
                      'Fontsemibold', // Set your custom font family here
                  fontSize: 14,
                ),
                textScaleFactor: 1.0,
              ), // Position of the Snackbar
              backgroundColor: const Color(
                0xFF78AD41,
              ), // Background color of the Snackbar
              colorText: Colors.white, // Text color of the Snackbar
              borderRadius: 10, // Border radius of the Snackbar
              margin: const EdgeInsets.all(10), // Margin around the Snackbar
              duration: const Duration(
                seconds: 3,
              ), // Duration for which the Snackbar is displayed
            );
          }
        },
        child: Container(
          height: 50,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [AppColors.primaryColor, AppColors.primaryColor2],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x21000000),
                blurRadius: 10,
                offset: Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Order Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Fontbold',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
              textScaleFactor: 1.0,
            ),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: ProgressINdigator());
        } else if (controller.filteredProducts.isEmpty) {
          return const Center(child: Text('No entries to show'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GetBuilder<ChallengeListcontroller>(
                  builder: (controller) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                controller.filteredProducts[index].img,
                                width: double.infinity,
                                fit: BoxFit
                                    .contain, // Changed from cover to fill
                              ),

                              /// PRODUCT NAME
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  controller.filteredProducts[index].name,
                                  style: const TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontSize: 18,
                                    fontFamily: 'Fontsemibold',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textScaleFactor: 1.0,
                                ),
                              ),

                              /// PRICE + QUANTITY CONTROLLER
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// PRICE
                                    Text(
                                      index == 1
                                          ? "₹${controller.filteredProducts[index].rate}"
                                          : "₹${controller.filteredProducts[index].rate}",
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20,
                                        fontFamily: 'Fontsemibold',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textScaleFactor: 1.0,
                                    ),

                                    /// QUANTITY BOX
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F2F4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /// MINUS
                                          InkWell(
                                            onTap: () => controller
                                                .decreaseItemQuantity(index),
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFD5D5D5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),

                                          /// TEXTFIELD
                                          SizedBox(
                                            width: 70,
                                            child: TextField(
                                              controller: controller
                                                  .txtcontrollers[index],
                                              onChanged: (value) {
                                                controller.quntityChangeByInput(
                                                  value: value,
                                                  index: index,
                                                );
                                              },
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                fontFamily: "Fontsemibold",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),

                                          /// PLUS
                                          InkWell(
                                            onTap: () => controller
                                                .increaseItemQuantity(index),
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),
              bottomBarTitle(),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 25),
                child: bottomBarButton(),
              ),
            ],
          );
        }
      }),
    );
  }
}

class ImageWithLoadingIndicator extends StatelessWidget {
  final String imageUrl;

  ImageWithLoadingIndicator({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imageUrl);
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;

  _CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF7DBF43)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final double startAngle =
        -90.0 * (3.1415926535897932 / 180.0); // Convert to radians
    final double sweepAngle = 2 * 3.1415926535897932 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
