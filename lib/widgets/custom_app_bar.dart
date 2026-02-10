

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String title;

  final double? iconContainerSize; // 👈 optional
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;
  final String? leadingIcon;
  final String? trailingIcon;

  const CustomAppBar({
    Key? key,
    this.height,
    required this.title,
    this.iconContainerSize,
    this.onBackTap,
    this.onActionTap,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  double get _appBarHeight => height ?? 80;
  double get _iconSize => iconContainerSize ?? 55;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: _appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconContainer(
              iconPath: leadingIcon ?? 'assets/backarrow_s.svg',
              onTap: onBackTap ?? () => Get.back(),
            ),

            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF3A3A3A),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              textScaleFactor: 1.0,
            ),

            _iconContainer(
              iconPath: trailingIcon ?? 'assets/home.svg',
              onTap: onActionTap ?? () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconContainer({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Container(
      width: _iconSize,
      height: _iconSize,
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      
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
        onPressed: onTap,
        icon: SvgPicture.asset(
          iconPath,
      
        ),
      ),
    );
  }
}
