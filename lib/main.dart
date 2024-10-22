import 'package:flutter/material.dart';

import 'core/blocs/blocs.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_themes.dart';

void main() {
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
