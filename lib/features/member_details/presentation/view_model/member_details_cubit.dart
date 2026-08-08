import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/services_locator.dart';
import '../../data/member_details_service.dart';
import '../../models/member_details_model.dart';

part 'member_details_state.dart';

class MemberDetailsCubit extends Cubit<MemberDetailsState> {
  MemberDetailsCubit() : super(MemberDetailsInitial());

  Future<void> getMember(String id) async {
    emit(MemberDetailsLoading());

    try {
      final member =
      await getIt<MemberDetailsService>().getMember(id);

      emit(MemberDetailsSuccess(member));
    } on DioException catch (e) {
      emit(
        MemberDetailsFailure(
          e.response?.data.toString() ??
              'حدث خطأ أثناء تحميل البيانات',
        ),
      );
    } catch (e) {
      emit(MemberDetailsFailure(e.toString()));
    }
  }
}