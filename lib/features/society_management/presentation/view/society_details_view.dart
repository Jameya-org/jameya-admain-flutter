import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/society_model.dart';
import '../viewmodel/society_details_cubit.dart';
import 'widgets/details/society_details_app_bar.dart';
import 'widgets/details/society_details_chart_header.dart';
import 'widgets/details/overview_tab_view.dart';
import 'widgets/details/members_tab_view.dart';
import 'widgets/details/payments_tab_view.dart';

class SocietyDetailsView extends StatelessWidget {
  final SocietyModel society;
  const SocietyDetailsView({super.key, required this.society});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SocietyDetailsCubit()..initDetails(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: SocietyDetailsAppBar(title: society.name),
          body: Column(
            children: [
              SocietyDetailsChartHeader(code: society.code),
              TabBar(
                labelColor: const Color(0xFF00CECD),
                unselectedLabelColor: Colors.grey.shade400,
                indicatorColor: const Color(0xFF00CECD),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.h,
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'نظرة عامة'),
                  Tab(text: 'الأعضاء'),
                  Tab(text: 'المدفوعات'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OverviewTabView(society: society),
                    const MembersTabView(),
                    const PaymentsTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
