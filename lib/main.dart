import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/constants/app_theme.dart';
import 'data/services/firebase_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/tournament/tournament_bloc.dart';
import 'presentation/bloc/wallet/wallet_bloc.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/admin/admin_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Firebase Service
  FirebaseService();
  
  runApp(const AxiovaXApp());
}

class AxiovaXApp extends StatelessWidget {
  const AxiovaXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(const AuthEvent.started()),
        ),
        BlocProvider(
          create: (context) => TournamentBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'AxiovaX - Gaming Tournaments',
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        home: const _HomeRouting(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/admin': (context) => const AdminHomeScreen(),
        },
      ),
    );
  }
}

/// Routing Logic based on Authentication & User Type
class _HomeRouting extends StatelessWidget {
  const _HomeRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          authenticated: (userId) {
            // TODO: Check if user is admin
            // Navigate to admin or home based on role
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
            );
          },
          unauthenticated: () {
            // Navigate to login screen
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          initial: () {},
          loading: () {},
          phoneVerificationNeeded: () {},
          deviceCheckFailed: (message) {},
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.when(
            authenticated: (userId) => const HomeScreen(),
            unauthenticated: () => const SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            loading: () => const SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            initial: () => const SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            phoneVerificationNeeded: () => const SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: Text('OTP Verification'),
                ),
              ),
            ),
            deviceCheckFailed: (message) => SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: Text(message),
                ),
              ),
            ),
            error: (message) => SizedBox.expand(
              child: Scaffold(
                body: Center(
                  child: Text(message),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
