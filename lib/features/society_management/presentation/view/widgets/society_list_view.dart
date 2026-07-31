import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        if (state is SocietyLoading || state is SocietyInitial) {
          return const SocietyShimmerLoading();
        } else if (state is SocietyLoaded) {
          if (state.societies.isEmpty) {
            return const SocietyEmptyState();
          }
          return ListView.builder(
            itemCount: state.societies.length,
            padding: EdgeInsets.only(bottom: 80.h),
            itemBuilder: (context, index) {
              return SocietyCard(society: state.societies[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
