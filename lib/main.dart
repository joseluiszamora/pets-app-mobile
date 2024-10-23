import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets_app_mobile/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/blocs/blocs.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://yodukrtarbjndxabgmii.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlvZHVrcnRhcmJqbmR4YWJnbWlpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU2NDg5MzksImV4cCI6MjA0MTIyNDkzOX0.Nu7R5Dq0WrDY4W5v2p-rq1G5o2sPrOywgpUKiAiluXE',
  );
  serviceLocatorInit();
  runApp(const BlocProviders());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIt<AuthenticationBloc>()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return MaterialApp.router(
          title: 'PetsApp',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          routerConfig: appRouter(authState),
        );
      },
    );
  }
}
