import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogicCubit(),
          // lazy: false,
        ),
        BlocProvider(
          create: (context) => OnlineCubit(),
          // lazy: false,
          // ..getRandom(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: About(),
        // theme: ThemeData(
        //   appBarTheme: const AppBarTheme(
        //     systemOverlayStyle: SystemUiOverlayStyle(
        //         statusBarColor: Colors.transparent,
        //         statusBarBrightness: Brightness.light,
        //         statusBarIconBrightness: Brightness.dark),
        //     // color: Colors.white,
        //     elevation: 0,
        //     // iconTheme: IconThemeData(color: Colors.black),
        //   ),
        // ),
      ),
    );
  }
}
