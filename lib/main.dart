import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_teller/shared/cubit/cubit.dart';

import 'modules/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(textDirection: TextDirection.rtl, child: HomeScreen(),),

      ),
    );
  }
}
