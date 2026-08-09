import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/services_locator.dart';
import '../../data/membership_service.dart';
import '../../models/membership_model.dart';

part 'member_circles_state.dart';

class MemberCirclesCubit extends Cubit<MemberCirclesState> {
  MemberCirclesCubit()
      : super(MemberCirclesInitial());

  Future<void> getMemberships(
      String customerId,
      ) async {
    emit(MemberCirclesLoading());

    try {
      final memberships =
      await getIt<MembershipService>().getMemberships(
        customerId,
      );

      emit(
        MemberCirclesSuccess(
          memberships,
        ),
      );
    } on DioException catch (e) {
      emit(
        MemberCirclesFailure(
          e.response?.data?.toString() ??
              'حدث خطأ أثناء تحميل الدوائر',
        ),
      );
    } catch (e) {
      emit(
        MemberCirclesFailure(
          e.toString(),
        ),
      );
    }
  }
}