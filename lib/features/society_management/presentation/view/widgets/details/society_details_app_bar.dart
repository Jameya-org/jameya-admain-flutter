import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../dialogs/end_society_dialog.dart';
import '../dialogs/pause_society_dialog.dart';
import '../dialogs/delete_society_dialog.dart';

class SocietyDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const SocietyDetailsAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  void _onMenuSelected(BuildContext context, String value) {
    if (value == 'end') {
      showDialog(context: context, builder: (_) => const EndSocietyDialog());
    } else if (value == 'pause') {
      showDialog(context: context, builder: (_) => const PauseSocietyDialog());
    } else if (value == 'delete') {
      showDialog(context: context, builder: (_) => const DeleteSocietyDialog());
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تم اختيار: $value')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: const Color(0xFF00796B),
          size: 18.sp,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),

      title: Text(
        title.isNotEmpty ? title : 'جمعية شهر 12',
        style: TextStyle(
          color: const Color(0xFF00796B),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: [
        PopupMenuButton<String>(
          onSelected: (val) => _onMenuSelected(context, val),
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 22.sp,
            height: 22.sp,
            colorFilter: const ColorFilter.mode(
              Color(0xFF00796B),
              BlendMode.srcIn,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text('تعديل الجمعية', style: TextStyle(fontSize: 14.sp)),
            ),
            PopupMenuItem(
              value: 'activate',
              child: Text('تفعيل الجمعية', style: TextStyle(fontSize: 14.sp)),
            ),
            PopupMenuItem(
              value: 'end',
              child: Text('إنهاء الجمعية', style: TextStyle(fontSize: 14.sp)),
            ),
            PopupMenuItem(
              value: 'pause',
              child: Text(
                'إيقاف الجمعية مؤقتا',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text(
                'حذف الجمعية',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
