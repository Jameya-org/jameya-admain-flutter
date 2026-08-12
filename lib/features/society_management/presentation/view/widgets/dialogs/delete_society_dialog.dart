import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_model.dart';
import '../../../viewmodel/society_details_cubit.dart';

class DeleteSocietyDialog extends StatelessWidget {
  final SocietyModel society;
  const DeleteSocietyDialog({super.key, required this.society});

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
              'حذف الجمعية؟',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
            ),
            SizedBox(height: 12.h),
            Text(
              'سيتم حذف الجمعية نهائياً ولن يمكن استعادتها. تأكد من رغبتك في المتابعة.',
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
                        final success = await cubit.cancelCircle(society.id);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(success ? 'تم إلغاء/حذف الجمعية بنجاح' : 'حدث خطأ أثناء حذف الجمعية'),
                            backgroundColor: success ? Colors.red : Colors.grey,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                      child: Text('حذف الجمعية', style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold)),
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

