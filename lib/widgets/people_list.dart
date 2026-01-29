import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:PTHPalathingal/Utils/colors.dart';

class PeopleListItem extends StatelessWidget {
  final int index;
  final String name;
  final String quantityKg;

  const PeopleListItem({
    Key? key,
    required this.index,
    required this.name,
    required this.quantityKg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTopThree = index < 3;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.listBagroundcolor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // LEFT SIDE: IMAGE (Top 3) OR NUMBER (Others)
            SizedBox(
              width: 55,
              child: Center(
                child: isTopThree
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/topvolunteer.svg",
                            width: 50,
                            height: 50,
                          ),
                          Positioned(
                            bottom: 22,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    : CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 12),

            // NAME
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3A3A3A),
                ),
              ),
            ),

            // QUANTITY
            Text(
              "$quantityKg kg",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3A3A3A),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
