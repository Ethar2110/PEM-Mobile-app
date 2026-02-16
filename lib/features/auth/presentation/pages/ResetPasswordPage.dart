import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/Custom_snackBar.dart';
import '../../../../core/utils/TextField.dart';
import '../../../../core/utils/customButton.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/forgetpassword_cubit.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}




class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();


    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.05),
                  Text(
                    "reset_your_password".tr(),
                    style: TextStyle(
                      fontSize: width * 0.08,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    "enter_email_reset_link".tr(),
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    label: "email".tr(),
                    icon: Icons.email,
                    controller: emailController,
                    fontSize: width * 0.045,
                    validator: Validators.email,
                  ),

                  SizedBox(height: height * 0.03),


                  BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordSuccess) {
                        CustomSnackBar.show(
                          context,
                          text: "reset_link_sent".tr(),
                          backgroundColor: Colors.green,
                        );
                      } else if (state is ForgetPasswordError) {
                        CustomSnackBar.show(
                          context,
                          text: state.message,
                          icon: Icons.error,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: "reset_password".tr(),
                        isLoading: state is ForgetPasswordLoading,
                        onPressed: () {
                          if (state is! ForgetPasswordLoading) {
                            context.read<ForgetPasswordCubit>().resetPassword(
                              emailController.text,
                            );
                          }
                        },
                      );
                    },
                  ),




                  SizedBox(height: height * 0.025),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "back_to_login".tr(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
