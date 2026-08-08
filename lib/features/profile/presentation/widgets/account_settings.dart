import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../view_model/profile_cubit.dart';
import 'settings_item.dart';

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard({super.key});

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('تغيير كلمة المرور'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'كلمة المرور الحالية',
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'كلمة المرور الجديدة',
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('إلغاء'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<ProfileCubit>().changePassword(
                  currentPassword: currentPasswordController.text,
                  newPassword: newPasswordController.text,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r),
              ),
            ),
            child: Text(
              'إعدادات الحساب',
              textAlign: TextAlign.start,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              _showChangePasswordDialog(context);
            },
            child: const SettingsItem(
              title: 'تغيير كلمة المرور',
              icon: Icons.person_2_outlined,
            ),
          ),
        ],
      ),
    );
  }
}