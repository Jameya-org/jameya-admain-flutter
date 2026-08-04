import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/services/services_locator.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';
import '../viewmodel/society_cubit.dart';
import 'widgets/society_search_bar.dart';
import 'widgets/society_filter_tabs.dart';
import 'widgets/society_list_view.dart';

class SocietyManagementView extends StatelessWidget {
  const SocietyManagementView({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SocietyCubit>()..fetchSocieties(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: onBack != null
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
                  onPressed: onBack,
                )
              : null,
          title: Text(
            'إدارة الجمعيات',
            style: AppTextStyles.title.copyWith(color: AppColors.primary),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            children: [
              const SocietySearchBar(),
              SizedBox(height: 16.h),
              SocietyFilterTabs(),
              SizedBox(height: 23.h),
              const Expanded(child: SocietyListView()),
            ],
          ),
        ),
      ),
    );
  }
}
