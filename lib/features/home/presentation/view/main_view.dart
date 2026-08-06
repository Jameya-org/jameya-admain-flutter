import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:jameya_admin/features/society_management/presentation/view/society_management_view.dart';
import 'package:jameya_admin/features/tasks/presentation/view/expenses_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // الـ Bottom Nav يظل ظاهراً في صفحة الجمعيات ليكون مطابقاً للتصميم
  bool get _showBottomNav => true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeViewBody(onNavigateToSocieties: () => _onTabSelected(1)),
      // صفحة الجمعيات داخل الـ main view مع الـ bottom nav
      SocietyManagementView(onBack: () => _onTabSelected(0)),
      const Center(child: Text('إضافة جمعية جديدة')),
      const ExpensesView(),
      const Center(child: Text('الملف الشخصي')),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: pages),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 58.w,
        height: 58.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            _onTabSelected(2);
          },
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 30.sp),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.r,
          color: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1. الرئيسية (Home)
              _buildNavItem(
                index: 0,
                label: 'الرئيسية',
                svgIcon: 'assets/icons/Home.svg',
              ),
              // 2. الجمعيات (Societies)
              _buildNavItem(
                index: 1,
                label: 'الجمعيات',
                svgIcon: 'assets/icons/Refresh copy.svg',
              ),
              // Spacer for center FAB
              SizedBox(width: 44.w),
              // 3. المصروفات (Expenses)
              _buildNavItem(
                index: 3,
                label: 'المصروفات',
                svgIcon: 'assets/icons/Payments.svg',
              ),
              // 4. حسابي (Profile)
              _buildNavItem(
                index: 4,
                label: 'حسابي',
                iconData: Icons.person_outline_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    String? svgIcon,
    IconData? iconData,
  }) {
    final bool isSelected = _currentIndex == index;
    final Color itemColor = isSelected
        ? AppColors.primary
        : const Color(0xFF94A3B8);

    return InkWell(
      onTap: () => _onTabSelected(index),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
              )
            else if (iconData != null)
              Icon(iconData, size: 24.sp, color: itemColor),
            SizedBox(height: 3.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
