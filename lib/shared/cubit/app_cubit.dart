import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:News_App/shared/cubit/app_statues.dart';
import 'package:News_App/shared/network/local/cache_helper.dart';
import '../components/News_app_components.dart';
import '../network/remote/dio_helper.dart';
import 'app_statues.dart';

import 'package:News_App/modules/business/business_screen.dart';
import 'package:News_App/modules/science/science_screen.dart';
import 'package:News_App/modules/settings_screen/settings.dart';
import 'package:News_App/modules/sports/sports_screen.dart';

class AppCubit extends Cubit<AppStatues> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode(){
    isDark = !isDark ;
    CacheHelper.setMode(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });

  }


}
