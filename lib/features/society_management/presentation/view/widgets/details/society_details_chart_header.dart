import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'animated_circular_chart.dart';

class SocietyDetailsChartHeader extends StatelessWidget {
  final String code;
  const SocietyDetailsChartHeader({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(child: AnimatedCircularChartWidget()),
                Positioned(
                  bottom: -10.h,

                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      code.isNotEmpty ? code : 'JMY-2024-001',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xff575757).withValues(alpha: 0.6),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
