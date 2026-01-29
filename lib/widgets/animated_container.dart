import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msfmylthrithala/Utils/colors.dart';
import 'package:msfmylthrithala/widgets/people_list.dart';

class ClickableCardWrapper extends StatefulWidget {
  final int index;
  final String name;
  final String quantityKg;
  final VoidCallback? onTap;

  const ClickableCardWrapper({
    Key? key,
    required this.index,
    required this.name,
    required this.quantityKg,
    this.onTap,
  }) : super(key: key);

  @override
  State<ClickableCardWrapper> createState() => _ClickableCardWrapperState();
}

class _ClickableCardWrapperState extends State<ClickableCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Slight scale animation to indicate clickability
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Play animation once when widget appears
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.primaryColor.withOpacity(0.2),
          highlightColor: AppColors.primaryColor.withOpacity(0.05),
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.3), // soft outline
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2), // subtle lift
                ),
              ],
            ),
            child: PeopleListItem(
              index: widget.index,
              name: widget.name,
              quantityKg: widget.quantityKg,
            ),
          ),
        ),
      ),
    );
  }
}


// String value=controller.assemblylist[index].amount;
                                // int? amount = int.tryParse(value);
                                //
                                // if (amount == null) return; // Handle invalid numbers safely
                                //
                                // StatefulWidget? page =
                                // // (amount >= 50 && amount < 100) ? FiftyClub(name: controller.assemblylist[index].name,) :
                                // // (amount >= 100 && amount < 150) ? HundredClub(name: controller.assemblylist[index].name,) :
                                // // (amount >= 150 && amount < 200) ? OnefiftyClub(name: controller.assemblylist[index].name,) :
                                // (amount >= 100 && amount < 200) ? HunderedClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                // (amount >= 200 && amount < 300) ? TwohundredClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                //
                                // (amount >= 300) ? ThreehundredClub(name: controller.assemblylist[index].name,name_panchayath: controller.assemblylist[index].panchayat,) :
                                // null;
                                //
                                // if (page != null) {
                                //   Get.to(page);
                                // }