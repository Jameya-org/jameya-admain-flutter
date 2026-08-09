import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_cubit.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_state.dart';
import 'package:jameya_admin/features/member_verification/presentation/widgets/document_accordion_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jameya_admin/features/member_verification/presentation/widgets/member_info_header_card.dart';

class MemberVerificationDetailView extends StatefulWidget {
  final MemberVerificationModel member;

  const MemberVerificationDetailView({
    super.key,
    required this.member,
  });

  @override
  State<MemberVerificationDetailView> createState() =>
      _MemberVerificationDetailViewState();
}

class _MemberVerificationDetailViewState
    extends State<MemberVerificationDetailView> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.member.estimatedAmount != null
          ? widget.member.estimatedAmount.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MemberVerificationCubit>()..loadMemberDetails(widget.member),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_right,
                color: AppColors.primary,
                size: 28.sp,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'توثيق الاعضاء',
              style: AppTextStyles.appBarTitle,
            ),
          ),
          body: BlocConsumer<MemberVerificationCubit, MemberVerificationState>(
            listener: (context, state) {
              if (state is MemberVerificationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                context.pop();
              } else if (state is MemberVerificationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is! MemberVerificationDetailLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              final cubit = context.read<MemberVerificationCubit>();
              final documents = state.documents;
              final isSubmitting = state.isSubmitting;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Member Info Header Card
                    MemberInfoHeaderCard(member: state.member),
                    SizedBox(height: 16.h),

                    // Attached Documents Card Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'المستندات المرفقة',
                            style: AppTextStyles.headline.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // List of Document Accordion Items
                          ...List.generate(documents.length, (index) {
                            final doc = documents[index];
                            return DocumentAccordionItem(
                              document: doc,
                              onToggleExpand: () {
                                cubit.toggleDocumentExpanded(index);
                              },
                              onImagePicked: (_) async {
                                final picker = ImagePicker();
                                final pickedFile =
                                    await picker.pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  cubit.setDocumentLocalImage(index, pickedFile.path);
                                }
                              },
                              onStatusChanged: (status) {
                                cubit.setDocumentStatus(index, status);
                              },
                              onRejectionReasonChanged: (reason) {
                                cubit.setDocumentRejectionReason(index, reason);
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Estimated Amount Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        onChanged: (val) {
                          final parsed = double.tryParse(val);
                          cubit.setEstimatedAmount(parsed);
                        },
                        decoration: InputDecoration(
                          hintText: 'المبلغ التقديري للمشاركة',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Verification Action Button
                    Builder(
                      builder: (context) {
                        final bool isActive = documents.any((d) => d.status != DocumentVerificationStatus.pending) ||
                            (state.estimatedAmount != null && state.estimatedAmount! > 0);

                        return SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: isSubmitting
                                ? null
                                : () {
                                    cubit.submitVerification();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSubmitting
                                  ? Colors.grey.shade400
                                  : isActive
                                      ? AppColors.primary
                                      : const Color(0xFFE2E8F0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: isSubmitting
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'توثيق',
                                    style: TextStyle(
                                      color: isActive ? Colors.white : const Color(0xFF94A3B8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
