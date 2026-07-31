import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_details_cubit.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_details_state.dart';
import 'member_card_item.dart';

class MembersTabView extends StatelessWidget {
  const MembersTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          // Search Bar
          Container(
            height: 46.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (val) =>
                  context.read<SocietyDetailsCubit>().searchMember(val),
              decoration: InputDecoration(
                hintText: 'البحث عن عضو...',
                hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, size: 20.sp, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 13.h),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: BlocBuilder<SocietyDetailsCubit, SocietyDetailsState>(
              builder: (context, state) {
                if (state is SocietyDetailsLoaded) {
                  return ListView.builder(
                    itemCount: state.members.length,
                    itemBuilder: (context, index) {
                      return MemberCardItem(member: state.members[index]);
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00CECD),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
