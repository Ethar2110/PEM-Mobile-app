import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled4/features/Expenses/presentation/pages/expensesPage.dart';
import 'package:untitled4/features/Saving_Goals/presentation/pages/SavingGoalsPage.dart';
import 'package:untitled4/features/Splashscreen/presentation/pages/SplashscreenPage.dart';
import 'package:untitled4/features/auth/presentation/pages/Login.dart';
import 'features/Expenses/data/expense_local_datasource.dart';
import 'features/Expenses/domain/repositories/expense_repo_impl.dart';
import 'features/Expenses/presentation/bloc/expense_cubit.dart';
import 'features/auth/presentation/bloc/biometric_cubit.dart';
import 'features/auth/presentation/bloc/fingerPringVal_cubit.dart';
import 'features/auth/presentation/bloc/logout_cubit.dart';
import 'features/auth/presentation/bloc/signUp_cubit.dart';
import 'features/home/presentation/pages/home.dart';
import 'firebase_options.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';
import 'features/auth/presentation/bloc/forgetpassword_cubit.dart';
import 'features/auth/presentation/bloc/signInWithGoogle_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized(); // مهم جدًا

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FingerprintCubit(),
        ),
        BlocProvider(create: (_) => BiometricCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => LogoutCubit()),
        BlocProvider(
          create: (_) => SignInWithGoogleCubit(),
        ),
        BlocProvider<ExpenseCubit>(
          create: (context) {
            final localDataSource = ExpenseLocalDataSource();
            final repository = ExpenseRepositoryImpl(localDataSource);
            return ExpenseCubit(repository);
          },
        ),
      ],
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreenPage(),
    ),

    );
  }
}
