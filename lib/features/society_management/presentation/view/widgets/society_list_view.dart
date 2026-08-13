import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import '../../viewmodel/society_cubit.dart';
import '../../viewmodel/society_state.dart';
import 'society_card.dart';
import 'society_shimmer_loading.dart';
import 'society_empty_state.dart';

class SocietyListView extends StatelessWidget {
  const SocietyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocietyCubit, SocietyState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => context.read<SocietyCubit>().refreshSocieties(),
          color: AppColors.primary,
          child: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, SocietyState state) {
    if (state is SocietyLoading || state is SocietyInitial) {
      return const SocietyShimmerLoading();
    } else if (state is SocietyLoaded) {
      if (state.societies.isEmpty) {
        return SocietyEmptyState(
          onCreateTap: () => context.push(AppRoutes.kCreateJameyaView),
        );
      }
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: state.societies.length,
        padding: EdgeInsets.only(bottom: 80.h),
        itemBuilder: (context, index) {
          return SocietyCard(society: state.societies[index]);
        },
      );
    } else if (state is SocietyError) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
