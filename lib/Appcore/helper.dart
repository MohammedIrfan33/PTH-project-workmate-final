import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msfmylthrithala/Utils/colors.dart';

void showPayConfirmDialog({
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.payment_outlined,
              size: 50,
              color: Colors.green,
            ),

            const SizedBox(height: 12),

            const Text(
              "Confirm Payment",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Do you want to continue?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back(); // close popup
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),

                const SizedBox(width: 12),

                // OK Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // close popup
                      onConfirm(); // continue payment
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("OK",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false, // user must choose
  );
}
