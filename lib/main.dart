import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/layout/News_app/news_layout.dart';
import 'package:News_App/shared/cubit/app_cubit.dart';
import 'package:News_App/shared/cubit/app_statues.dart';
import 'package:News_App/shared/cubit/cubit.dart';
import 'package:News_App/shared/network/local/cache_helper.dart';
import 'package:News_App/shared/network/remote/dio_helper.dart';

void main() async{

  // I use this because I used async
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDark = CacheHelper.getMode(key: 'isDark')!;
    // I create all of my BlocProviders here to use them throughout the app
    // if you had only one you can do that
    // BlocProvider(create: (BuildContext context) => AppCubit(), child:BlocConsumer())
    // ut here we have multiple of them so we have to use this method
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
    BlocProvider(
    //..getThing() by this way I call the function on cubit to be executed
    // once I open this page
    create: (BuildContext context) => NewsCubit()
    ..getBusiness()
    ..getSports()
    ..getScience(),),
      ],
      child: BlocConsumer<AppCubit, AppStatues>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
              // we make the primary color for the whole application is deepOrange
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                // it's responsible for the bar above The AppBar which has battery/wifi/etc
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: const TextTheme(
                bodyText2: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black45,
              // we make the primary color for the whole application is deepOrange
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                // it's responsible for the bar above The AppBar which has battery/wifi/etc
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.black45,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: const TextTheme(
                bodyText2: TextStyle(
                  color: Colors.white70,
                ),
                bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              brightness: Brightness.dark,
            ),
            themeMode: (CacheHelper.getMode(key: 'isDark')!)?ThemeMode.dark:ThemeMode.light,
            home: const Directionality(
              textDirection: TextDirection.rtl,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}

