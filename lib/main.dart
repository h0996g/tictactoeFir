import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoefir/about.dart';
import 'package:tictactoefir/offline/cubit/logic_cubit.dart';
import 'package:tictactoefir/online/cubit/online_cubit.dart';

import 'firebase_options.dart';
import 'shared/observer/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogicCubit(),
        ),
        BlocProvider(
          create: (context) => OnlineCubit()..startGame(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: About(),
      ),
    );
  }
}
