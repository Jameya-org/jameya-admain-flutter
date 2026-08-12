import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_model.dart';
import '../../../viewmodel/society_details_cubit.dart';

class EndSocietyDialog extends StatelessWidget {
  final SocietyModel society;
  const EndSocietyDialog({super.key, required this.society});

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
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final cubit = context.read<SocietyDetailsCubit>();
                        navigator.pop();
                        final success = await cubit.finishCircle(society.id);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(success ? 'تم إنهاء الجمعية بنجاح' : 'حدث خطأ أثناء إنهاء الجمعية'),
                            backgroundColor: success ? Colors.green : Colors.red,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                      child: Text('إنهاء', style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold)),
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

