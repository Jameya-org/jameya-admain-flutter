import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:jameya_admin/features/home/presentation/view/widgets/home_header.dart';
import 'package:jameya_admin/features/home/presentation/view/widgets/home_societies_section.dart';
import 'package:jameya_admin/features/home/presentation/view/widgets/home_stats_grid.dart';
import 'package:jameya_admin/features/home/presentation/view/widgets/home_task_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.onNavigateToSocieties});

  final VoidCallback onNavigateToSocieties;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchDashboardData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                SizedBox(height: 20.h),
                const HomeStatsGrid(),
                SizedBox(height: 24.h),
                const HomeTaskList(),
                SizedBox(height: 24.h),
                HomeSocietiesSection(
                  onNavigateToSocieties: onNavigateToSocieties,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
