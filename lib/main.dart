import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark')??true;


  runApp( MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required bool isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit() ,
      child: BlocBuilder<AppCubit , AppStates>(
        builder: (context , state) =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lihgtTheme,
        darkTheme: darkTheme,
        themeMode: CacheHelper.getData(key: 'isDark') ?? false ? ThemeMode.dark : ThemeMode.light,
        home: BlocProvider(create: (context) => NewsCubit()..getBussiness()..getSports()..getScience(),
          child: NewsLaayout(),
        ),
      ),

      ),
    );
  }
}

