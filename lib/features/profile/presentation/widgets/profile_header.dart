import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() {
    final path = getIt<CacheHelper>().getData(
      key: 'profileImage',
    );

    if (path != null) {
      setState(() {
        selectedImage = File(path);
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      await getIt<CacheHelper>().saveData(
        key: 'profileImage',
        value: image.path,
      );

      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_back_ios
                    : Icons.arrow_forward_ios,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  'الحساب الشخصي',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            SizedBox(width: 48.w),
          ],
        ),

        SizedBox(height: 24.h),

        GestureDetector(
          onTap: pickImage,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : const AssetImage(
                  'assets/images/user.png',
                ) as ImageProvider,
              ),

              Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          'اضغط لتغيير الصورة',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
          ),
        ),

        SizedBox(height: 16.h),

        Text(
          widget.name,
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          widget.email,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ],
    );
  }
}