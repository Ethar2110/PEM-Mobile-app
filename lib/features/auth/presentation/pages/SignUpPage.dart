import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/signUp_cubit.dart';
import '../bloc/signUp_state.dart';
import '../widgets/TextField.dart';
import '../widgets/customButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Account created successfully ✅"),
            ),
          );
          Navigator.pop(context);
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.05),

                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: width * 0.08,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: height * 0.02),

                        CustomTextField(
                          label: "Username",
                          icon: Icons.person,
                          controller: usernameController,
                          fontSize: width * 0.045,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: height * 0.03),

                        CustomTextField(
                          label: "Email",
                          icon: Icons.email,
                          controller: emailController,
                          fontSize: width * 0.045,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: height * 0.03),

                        CustomTextField(
                          label: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                          controller: passwordController,
                          fontSize: width * 0.045,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: height * 0.03),

                        CustomTextField(
                          label: "Phone Number",
                          icon: Icons.phone,
                          controller: phoneController,
                          fontSize: width * 0.045,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: height * 0.03),

                        CustomButton(
                          text: "Sign Up",
                          isLoading: state is SignUpLoading,
                          onPressed: state is SignUpLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpCubit>().signUp(
                                email:
                                emailController.text.trim(),
                                password:
                                passwordController.text.trim(),
                              );
                            }
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
          ),
        );
      },
    );
  }
}
