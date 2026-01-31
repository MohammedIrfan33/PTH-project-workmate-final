import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/TopSponsorController.dart';
import '../main.dart';
import '../widgets/PorgressIndicator.dart';

class Topsponsors extends StatefulWidget {
  const Topsponsors({super.key});

  @override
  State<Topsponsors> createState() => _TopsponsorsState();
}

class _TopsponsorsState extends State<Topsponsors> with RouteAware {
  final Topsponsorcontroller controller = Get.put(Topsponsorcontroller());

  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 53.w, height: 53.w),
              Text(
                'Top Sponsors',
                style: TextStyle(
                  color: const Color(0xFF3A3A3A),
                  fontSize: 14.sp,
                  fontFamily: 'Fontsemibold',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 53.w, height: 53.w),
            ],
          ),
        ),
      ),
    );
  }

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
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: ProgressINdigator(),
            ),
          );
        }

        if (controller.challengeSponsorlist.isEmpty) {
          return const Center(child: Text('No entries to show'));
        }


        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GetBuilder<Topsponsorcontroller>(
            builder: (_) {
              return ListView.builder(
                itemCount: controller.challengeSponsorlist.length,
                itemBuilder: (context, index) {
                  final sponsor = controller.challengeSponsorlist[index];
                  print(sponsor.payable);

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                          child: Image.asset(
                            "assets/pth-reward-club/sponsers.jpeg",
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// Sponsor avatar
                        Positioned(
                          left: 30.w,
                          top: 50.h,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundImage: sponsor.image.isEmpty
                                ? const AssetImage(
                                    "assets/images/person1.jpg",
                                  )
                                : NetworkImage(sponsor.image) as ImageProvider,
                          ),
                        ),

                        /// Sponsor name
                        Positioned(
                          right: 50.w,
                          bottom: 72.h,
                          child: SizedBox(
                            width: 150.w,
                            child: Text(
                              sponsor.name,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color:
                                    const Color.fromRGBO(4, 52, 106, 1),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        /// Amount
                        Positioned(
                          right: 100.w,
                          bottom: 2,
                          child: SizedBox(
                            width: 95.w,
                            height: 60.h,
                            child: Center(
                              child: Text(
                                '₹${sponsor.payable}',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                             
                              ),
                            ),
                          ),
                        ),

                        /// Count
                        Positioned(
                          left: 286.w,
                         
                          top: 138,
                          child: SizedBox(
                            width: 90.w,
                            height: 60.h,
                            child: Text(
                              sponsor.count.toString()
                              ,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(
                                  4,
                                  52,
                                  106,
                                  1,
                                ),
                              ),
                              maxLines: 1,
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
      }),
    );
  }
}
