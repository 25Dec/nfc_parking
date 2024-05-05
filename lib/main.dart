import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/res/app_theme.dart';
import 'core/routes/app_route_config.dart';
import 'core/services/firebase_options.dart';
import 'core/services/injection_container.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/nfc_cards/presentation/bloc/nfc_cards_bloc.dart';
import 'features/parking_history/presentation/bloc/parking_history_bloc.dart';
import 'features/staff/presentation/bloc/staff_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await InjectionContainer.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<NfcCardsBloc>()),
        BlocProvider(create: (context) => sl<StaffBloc>()),
        BlocProvider(create: (context) => sl<ParkingHistoryBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(
      GetUserDataEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NFC Parking",
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).theme,
      routerConfig: AppRouteConfig(context).router,
    );
  }
}
