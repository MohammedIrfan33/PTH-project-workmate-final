import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:PTHPalathingal/controller/TopClubcontroller.dart';

import '../controller/TopSponsorController.dart';
import '../main.dart';
import '../widgets/PorgressIndicator.dart';

class Topsponsors extends StatefulWidget {
  @override
  State<Topsponsors> createState() => _TopsponsorsState();
}

class _TopsponsorsState extends State<Topsponsors> with RouteAware {
  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
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
                // decoration: ShapeDecoration(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //     borderRadius: BorderRadius.circular(18),
                //   ),
                // ),
                // child: IconButton(
                //   padding: const EdgeInsets.all(8),
                //   constraints: const BoxConstraints(),
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: SvgPicture.asset(
                //     'assets/backarrow_s.svg',
                //     width: 22,
                //     height: 22,
                //     semanticsLabel: 'Example SVG',
                //   ),
                // ),
              ),
              const Center(
                child: Text(
                  'Top Sponsors',
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
                // decoration: ShapeDecoration(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                //     borderRadius: BorderRadius.circular(18),
                //   ),
                // ),
                // child: IconButton(
                //   padding: const EdgeInsets.all(8),
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: SvgPicture.asset(
                //     'assets/home.svg',
                //     width: 18,
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

  final controller = Get.put(Topsponsorcontroller());

  @override
  void didPopNext() {
    controller.fulllist();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(width: 40, height: 40, child: ProgressINdigator()),
          );
        } else if (controller.challengeSponsorlist.isEmpty) {
          return const Center(child: Text('No entries to show'));
        } else {

      

    
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder(
              builder: (Topsponsorcontroller controller) {
                return ListView.builder(
                  itemCount: controller.challengeSponsorlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Stack(
                        children: [
                         

                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                // Curve top-left corner
                                bottomRight: Radius.circular(
                                  30,
                                ), // Curve bottom-right corner
                              ),
                              child: Image.asset(
                                "assets/pth-reward-club/sponsers.jpeg",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                           Positioned(
                            left: 30,
                            top: 25,
                            
                            bottom: 0,
                            child: Container(
                              child: CircleAvatar(
                                radius: 60, // Adjust as per your template
                                backgroundImage:
                                    controller
                                            .challengeSponsorlist[index]
                                            .image ==
                                        ""
                                    ? AssetImage("assets/images/person1.jpg")
                                    : NetworkImage(
                                             controller
                                            .challengeSponsorlist[index]
                                            .image,
                                      ),
                              ),
                            ),
                          ),

                          Positioned(
                            right: 50,
                            bottom: 75,
                            child: Container(
                              width: 150,

                            

                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  controller.challengeSponsorlist[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(4, 52, 106, 1),
                                  ),
                                  maxLines: 1,
                                  minFontSize: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 100,
                            bottom: 55,
                            child: Container(
                              width: 100,
                              height: 20,

                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  controller.challengeSponsorlist[index].ward,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                     color: Color.fromRGBO(4, 52, 106, 1),
                                    
                                    
                                  ),
                                  maxLines: 1,
                                  minFontSize: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 110,
                            bottom: 0,
                            child: Container(
                              width: 90,
                              height: 60,

                              child: Center(
                                child: AutoSizeText(
                                    '₹ '+controller.challengeSponsorlist[index].payable
                                      .replaceAll(".00", ""),
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  minFontSize: 6,
                                  maxFontSize: 40,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 24,
                            bottom: 0,
                            child: Container(
                              width: 90,
                              height: 60,

                              child: Center(
                                child: AutoSizeText(
                                    '${controller.challengeSponsorlist[index].count}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(4, 52, 106, 1),
                                  ),
                                  maxLines: 1,
                                  minFontSize: 6,
                                  maxFontSize: 40,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
