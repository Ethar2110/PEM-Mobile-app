import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/validators.dart';
import '../bloc/forgetpassword_cubit.dart';
import '../widgets/TextField.dart';
import '../widgets/customButton.dart';
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
                    'Reset Your Password',
                    style: TextStyle(
                      fontSize: width * 0.08,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    'Enter your email to receive a reset link',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    label: "Email",
                    icon: Icons.email,
                    controller: emailController,
                    fontSize: width * 0.045,
                    validator: Validators.email,
                  ),

                  SizedBox(height: height * 0.03),


                  BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Reset link sent! ✅")),
                        );
                      } else if (state is ForgetPasswordError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: "Reset Password",
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
                      "Back to Login",
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
