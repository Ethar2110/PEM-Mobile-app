import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/presentation/bloc/signUp_cubit.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/pages/Login.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';
import 'features/auth/presentation/bloc/forgetpassword_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(),
        ),
        BlocProvider(
          create: (_) => ForgetPasswordCubit(),
        ),
        BlocProvider(create: (_) => SignUpCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
