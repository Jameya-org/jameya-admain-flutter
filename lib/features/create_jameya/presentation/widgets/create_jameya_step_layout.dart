import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/features/create_jameya/presentation/widgets/create_jameya_header.dart';
import 'package:jameya/features/create_jameya/presentation/widgets/create_jameya_progress_indicator.dart';

/// Shared scaffold for steps 0–2. Composes:
///   • dismiss arrow (top-right)
///   • progress indicator
///   • scrollable header + body
///   • pinned footer (buttons)
class CreateJameyaStepLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final int currentStep;
  final Widget body;
  final Widget footer;

  const CreateJameyaStepLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentStep,
    required this.body,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Dismiss / skip button ──────────────────────────────────────────
        _DismissButton(),

        // ── Step progress ──────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CreateJameyaProgressIndicator(currentStep: currentStep),
        ),
        SizedBox(height: 4.h),

        // ── Scrollable body ────────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),
                CreateJameyaHeader(title: title, subtitle: subtitle),
                SizedBox(height: 32.h),
                body,
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // ── Pinned footer ──────────────────────────────────────────────────
        footer,
      ],
    );
  }
}

/// Small "›" dismiss icon at top-right. Pops the route on tap.
class _DismissButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, right: 8.w, left: 8.w),
      child: Align(
        alignment: Alignment.centerRight, // Always physical right, RTL-safe
        child: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Directionality(
            // Force LTR so the chevron always renders as "›" regardless of locale
            textDirection: TextDirection.ltr,
            child: Icon(
              Icons.navigate_next,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
