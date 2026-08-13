import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/logout.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';
import '../widgets/account_settings.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProfileFailure) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is ProfileSuccess) {
              final data = state.data;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    ProfileHeader(
                      name: 'أحمد سامح',
                      email: data['email'] ?? '',
                    ),

                    SizedBox(height: 32.h),

                    const AccountSettingsCard(),

                    SizedBox(height: 24.h),

                    ProfileLogoutButton(
                      onPressed: () async {
                        await logout();

                        if (!context.mounted) return;
                        context.go(AppRoutes.kAdminLoginView);
                      },
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}