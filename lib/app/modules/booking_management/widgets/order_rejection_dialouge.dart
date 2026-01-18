
import 'package:barberita/common/app_color/app_colors.dart';
import 'package:barberita/common/app_text_style/google_app_style.dart';
import 'package:barberita/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRejectionDialog extends StatelessWidget {
  final VoidCallback? onDecline;
  final VoidCallback? onAccept;

  const OrderRejectionDialog({
    super.key,
    this.onDecline,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Getting rejected is not fun!',
              style: GoogleFontStyles.h4(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Subtitle
            Text(
              'Do you really want to reject the order?',
              style: GoogleFontStyles.h5(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Buttons
            Column(
              children: [
                // Decline Button
                CustomButton(
                  text: 'Decline',
                  onTap: () {
                    Navigator.of(context).pop();
                    onDecline?.call();
                  },
                  color: Colors.red,
                  width: double.infinity,
                ),

                SizedBox(height: 12.h),

                // Accept Button
                CustomButton(
                  text: 'Nope, Accept Order',
                  onTap: () {
                    Navigator.of(context).pop();
                    onAccept?.call();
                  },
                  color: AppColors.secondaryAppColor,
                  width: double.infinity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Static method to show the dialog
  static Future<void> show(
      BuildContext context, {
        VoidCallback? onDecline,
        VoidCallback? onAccept,
      }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return OrderRejectionDialog(
          onDecline: onDecline,
          onAccept: onAccept,
        );
      },
    );
  }
}

// Usage Example Widget
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example')),
      body: Center(
        child: CustomButton(
          text: 'Show Rejection Dialog',
          onTap: () {
            OrderRejectionDialog.show(
              context,
              onDecline: () {
                // Handle decline action
                print('Order declined');
              },
              onAccept: () {
                // Handle accept action
                print('Order accepted');
              },
            );
          },
        ),
      ),
    );
  }
}