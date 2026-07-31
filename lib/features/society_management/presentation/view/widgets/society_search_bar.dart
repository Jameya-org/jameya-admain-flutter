import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodel/society_cubit.dart';

class SocietySearchBar extends StatelessWidget {
  const SocietySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        onChanged: (value) => context.read<SocietyCubit>().search(value),
        decoration: InputDecoration(
          hintText: 'البحث عن جمعية...',
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          prefixIcon: Icon(Icons.search, size: 20.sp, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}
