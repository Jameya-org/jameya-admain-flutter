import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PauseSocietyDialog extends StatelessWidget {
  const PauseSocietyDialog({super.key});

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
              'إيقاف الجمعية مؤقتاً؟',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
            ),
            SizedBox(height: 12.h),
            Text(
              'سيتم إيقاف جميع العمليات مؤقتاً حتى يتم إعادة تفعيل الجمعية.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700, height: 1.5),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF00796B)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                      child: Text('إلغاء', style: TextStyle(fontSize: 15.sp, color: const Color(0xFF00796B), fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                      child: Text('إيقاف', style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
