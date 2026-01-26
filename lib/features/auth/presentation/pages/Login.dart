import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/auth/presentation/bloc/fingerPrint_state.dart';
import 'package:untitled4/features/auth/presentation/widgets/customButton.dart';
import '../../../Home/auth/presentation/pages/Homepage.dart';
import '../../../core/utils/validators.dart';
import '../../Data/datasources/local_storage.dart';
import '../bloc/biometric_cubit.dart';
import '../bloc/biometric_state.dart';
import '../bloc/fingerPringVal_cubit.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';
import '../bloc/signInWithGoogle_cubit.dart';
import '../bloc/signInWithGoogle_state.dart';
import '../widgets/Custom_snackBar.dart';
import '../widgets/TextField.dart';
import 'ResetPasswordPage.dart';
import 'SignUpPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool showFingerprint = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  // void checkFingerprintStatus() async {
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   if (uid == null) {
  //     showFingerprint = false;
  //   } else {
  //     showFingerprint = await LocalStorage.isFingerprintEnabled(uid);
  //   }
  //
  //   if (!mounted) return;
  //   setState(() {});
  // }
  Future<void> _loadFingerprintStatusByEmail() async {
    final email = emailController.text.trim();
    final uid = await LocalStorage.getUidByEmail(email);

    if (uid != null) {
      await context.read<FingerprintCubit>().loadFingerprintStatus(uid);
    } else {
      context.read<FingerprintCubit>().emit(
        FingerprintState(uid: null, enabled: false),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<BiometricCubit>().checkAvailability();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener<BiometricCubit, BiometricState>(
            listener: (context, state) {
              if (state is BiometricAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Homepage()),
                );
              }
            },
          ),

          BlocListener<LoginCubit, login_state>(
            listener: (context, state) {
              if (state is FingerprintNotLinked) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      "Please login first to connect fingerprint",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              if (state is FingerprintLinked) {
                context.read<BiometricCubit>().authenticate(state.uid);
              }

              // ✅ SnackBars for Login Success / Error
              if (state is LoginSuccess) {
                CustomSnackBar.show(
                  context,
                  text: "Login Successful",
                  backgroundColor: Colors.green,
                );

              } else if (state is LoginError) {
                CustomSnackBar.show(
                  context,
                  text: state.message,
                  icon: Icons.error,
                  backgroundColor: Colors.red,
                );

              }
            },
          ),

          BlocListener<SignInWithGoogleCubit, SignInWithGoogleState>(
            listener: (context, state) {
              if (state is GoogleAuthSuccess) {
                CustomSnackBar.show(
                  context,
                  text: "Login Successful",
                  backgroundColor: Colors.green,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Homepage()),
                );
              } else if (state is GoogleAuthError) {
                CustomSnackBar.show(
                  context,
                  text: state.message,
                  icon: Icons.error,
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
        ],
        child: BlocConsumer<LoginCubit, login_state>(
          listener: (context, state) {
            // Keep your existing dialog logic here
            if (state is LoginSuccess) {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              context.read<FingerprintCubit>().loadFingerprintStatus(uid);

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text(
                    "Use fingerprint next time?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        await LocalStorage.saveFingerprint(uid, false);
                        context.read<FingerprintCubit>().setEnabled(uid, false);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Homepage()),
                        );
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        await LocalStorage.saveFingerprint(uid, true);
                        context.read<FingerprintCubit>().setEnabled(uid, true);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Homepage()),
                        );
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.2),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: width * 0.09,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.05),

                      CustomTextField(
                        label: "Email",
                        icon: Icons.email,
                        controller: emailController,
                        validator: Validators.email,
                        onChanged: (value) {
                          if (Validators.email(value) == null) {
                            context.read<LoginCubit>().checkFingerprintByEmail(
                              value,
                            );
                            _loadFingerprintStatusByEmail();
                          }
                        },
                      ),
                      SizedBox(height: height * 0.03),

                      CustomTextField(
                        label: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                        controller: passwordController,
                        validator: Validators.password,
                      ),
                      SizedBox(height: height * 0.0010),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "Login",
                              isLoading: state is LoginLoading,
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.login(
                                          email: emailController.text.trim(),
                                          password: passwordController.text
                                              .trim(),
                                        );
                                      }
                                    },
                            ),
                          ),

                          const SizedBox(width: 5),

                          BlocBuilder<FingerprintCubit, FingerprintState>(
                            builder: (context, fpState) {
                              return Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.fingerprint,
                                    color: fpState.enabled
                                        ? Colors.green
                                        : Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    if (!fpState.enabled) {
                                      // Fingerprint disabled dialog
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          backgroundColor: Colors.grey[900],
                                          surfaceTintColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          title: const Text(
                                            "Fingerprint is disabled",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          content: const Text(
                                            "Please login normally first, then enable fingerprint.",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      return;
                                    }

                                    // Fingerprint enabled logic
                                    final email = emailController.text.trim();
                                    final uid =
                                        await LocalStorage.getUidByEmail(email);

                                    if (uid == null) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                            "First login required",
                                          ),
                                          content: const Text(
                                            "Please login once normally to connect fingerprint.",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<BiometricCubit>().authenticate(
                                      uid,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.03),

                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<SignInWithGoogleCubit>()
                              .signInWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                            horizontal: width * 0.08,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child:
                            BlocBuilder<
                              SignInWithGoogleCubit,
                              SignInWithGoogleState
                            >(
                              builder: (context, state) {
                                if (state is GoogleAuthLoading) {
                                  return const CircularProgressIndicator(
                                    color: Colors.green,
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      "Sign In With Google",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.045,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                      ),

                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.04,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
