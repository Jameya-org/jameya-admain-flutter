import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndSocietyDialog extends StatelessWidget {
  const EndSocietyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إنهاء الجمعية',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
            ),
            SizedBox(height: 12.h),
            Text(
              'سيتم إنهاء الجمعية وإغلاق جميع العمليات الخاصة بها. لن تتمكن من إضافة أعضاء أو تعديل بياناتها بعد الآن.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700, height: 1.5),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF59E0B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('حذف', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
