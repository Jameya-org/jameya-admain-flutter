import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../presentation/view_model/auth_cubit.dart';
import '../presentation/view_model/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_title_section.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/terms_checkbox.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({super.key});

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _acceptedTerms = false;
  bool _isButtonEnabled = false;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        _emailController.text.trim().isNotEmpty &&
            _passwordController.text.trim().isNotEmpty &&
            _acceptedTerms;

    if (isValid != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isValid;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الدخول بنجاح'),
              backgroundColor: Color(0xFF008080),
            ),
          );

          context.go(AppRoutes.kHomeView);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return AuthBackground(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 2.h),

              AuthBackButton(
                onPressed: () => context.pop(),
              ),

              SizedBox(height: 4.h),

              const AuthTitleSection(
                title: 'ادخل بياناتك',
                subtitle: 'اكتب بياناتك علشان تبدأ رحلتك',
              ),
            ],
          ),

          child: SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 32.h),

                  LabeledTextField(
                    label: 'الايميل',
                    controller: _emailController,
                    hintText: 'example@gmail.com',
                  ),

                  SizedBox(height: 16.h),

                  LabeledTextField(
                    label: 'الرقم السري',
                    controller: _passwordController,
                    hintText: 'اكتب المحتوى هنا',
                    obscureText: _isPasswordHidden,
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                  ),

                  SizedBox(height: 240.h),

                  TermsCheckbox(
                    value: _acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value ?? false;
                      });

                      _validateForm();
                    },
                    onTermsTap: () {},
                    onPrivacyTap: () {},
                  ),

                  SizedBox(height: 50.h),

                  PrimaryButton(
                    text: state is AuthLoading
                        ? 'جاري التحميل...'
                        : 'تأكيد',
                    isEnabled:
                    _isButtonEnabled && state is! AuthLoading,
                    onPressed: _isButtonEnabled
                        ? () {
                      context.read<AuthCubit>().login(
                        email:
                        _emailController.text.trim(),
                        password:
                        _passwordController.text.trim(),
                      );
                    }
                        : null,
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}