import 'package:auto_size_text/auto_size_text.dart';
import 'package:PTHPalathingal/rewardStatus/Hundered_Club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:PTHPalathingal/rewardStatus/reward_poster.dart';
import 'package:PTHPalathingal/widgets/animated_container.dart';
import 'package:PTHPalathingal/widgets/people_list.dart';

import '../Utils/colors.dart';
import '../controller/TopReportController.dart';
import '../main.dart';
import '../rewardStatus/ThreeHundred_Club.dart';
import '../rewardStatus/Twohundred_Club.dart';
import '../widgets/PorgressIndicator.dart';

class TopReport extends StatefulWidget {
  final Function(int)? onTabChange;
  TopReport({required this.onTabChange});

  @override
  State<TopReport> createState() => _TopClubsState();
}

class _TopClubsState extends State<TopReport>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  final controller = Get.put(TopreportController());

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(117),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 53,
                  height: 53,
                  margin: const EdgeInsets.all(8),
                  // decoration: ShapeDecoration(
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     side:
                  //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
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
                  child: Text
                  (
                    'Top Report',
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
                  //     side:
                  //     const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  // Selected tab text color
                  //isScrollable: true, // Enables horizontal scrolling
                  unselectedLabelColor: Colors.transparent,
                  // Unselected tab text color
                  controller: _tabController,
                  labelPadding: EdgeInsets.only(right: 12),

                  // Tab indicator size
                  indicatorWeight: 0,
                  indicator: GradientTabIndicator(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor2, AppColors.primaryColor],
                    ),

                    thickness: 2.2,
                    radius: 90.0, // Adjust as needed
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Contributors",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Area",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),

                    Tab(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: AutoSizeText(
                          "Division/Ward",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // Must set a color for ShaderMask to work
                          ),
                          maxLines: 1,
                          minFontSize: 6,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                   
                 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    controller.fullConstituency();
    controller.fullPanchayt();
    controller.fullorganisation();
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
      body: Obx(
        () => TabBarView(
          controller: _tabController,
          children: [
            ////////////first tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading4.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.contributorsList.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.contributorsList.length,
                          itemBuilder: (context, index) {
                            return PeopleListItem(
                              index: index,
                              name: controller.contributorsList[index].name,
                              quantityKg: controller.contributorsList[index].packet,
                            );
                          },
                        );
                      },
                    ),
            ),

            ////////////second tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading1.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.assemblylist.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.assemblylist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {

                                print('========');
                                

String value=controller.assemblylist[index].packet;
                                int? packet = int.tryParse(value);

                                print('========$packet');
                                
                                if (packet == null) return; // Handle invalid numbers safely
                                StatefulWidget? page =
                          
                                (packet >= 100 && packet < 200) ? PosterShareWidget(name: controller.assemblylist[index].name, imagePath: 'assets/pth-reward-club/100.jpeg',) :
                                (packet >= 200 && packet < 300) ? PosterShareWidget(
                                  name: controller.assemblylist[index].name,
                                   imagePath: 'assets/pth-reward-club/200.jpeg',
                                   nameColor: Colors.black,
                                   ) :

                                (packet >= 300 && packet < 400) ? PosterShareWidget(
                                  name: controller.assemblylist[index].name,
                                   imagePath: 'assets/pth-reward-club/300.jpeg',
                                   nameColor: Colors.white,
                                   ) :


                                 (packet >= 400) ? PosterShareWidget(
                                  name: controller.assemblylist[index].name,
                                   imagePath: 'assets/pth-reward-club/400.jpeg',
                                   nameColor: Colors.white,
                                   ) :
                                  

                            
                                null;
                                
                                if (page != null) {
                                  Get.to(page);
                                }
                              },
                              child: PeopleListItem(
                                index: index,
                                name: controller.assemblylist[index].name,
                                quantityKg: controller.assemblylist[index].packet,
                               
                              ),
                            );

                         
                          },
                        );
                      },
                    ),
            ),
            ////////////third tab>>>>>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: controller.isLoading2.value
                  ? Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        child: ProgressINdigator(),
                      ),
                    )
                  : controller.panchayatlist.isEmpty
                  ? const Center(child: Text('No entries to show'))
                  : GetBuilder(
                      builder: (TopreportController controller) {
                        return ListView.builder(
                          itemCount: controller.panchayatlist.length,
                          itemBuilder: (context, index) {
                            return PeopleListItem(
                              index: index,
                              name: controller.panchayatlist[index].name,
                              quantityKg: controller.panchayatlist[index].packet,
                            );
                          
                          
                          },
                        );
                      },
                    ),
            ),
          
         
          ],
        ),
      ),
    );
  }
}

class GradientTabIndicator extends Decoration {
  final Gradient gradient;
  final double thickness;
  final double radius;

  GradientTabIndicator({
    required this.gradient,
    this.thickness = 2.0,
    this.radius = 0.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientPainter(gradient, thickness, radius);
  }
}

class _GradientPainter extends BoxPainter {
  final Gradient gradient;
  final double thickness;
  final double radius;

  _GradientPainter(this.gradient, this.thickness, this.radius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect indicatorRect = Rect.fromLTWH(
      offset.dx,
      configuration.size!.height - thickness,
      configuration.size!.width,
      thickness,
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(indicatorRect)
      ..style = PaintingStyle.fill;

    final RRect roundedRect = RRect.fromRectAndRadius(
      indicatorRect,
      Radius.circular(radius),
    );
    canvas.drawRRect(roundedRect, paint);
  }
}
