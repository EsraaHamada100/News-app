import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/News_app_components.dart';
import '../network/remote/dio_helper.dart';
import 'statues.dart';

import 'package:News_App/modules/business/business_screen.dart';
import 'package:News_App/modules/science/science_screen.dart';
import 'package:News_App/modules/settings_screen/settings.dart';
import 'package:News_App/modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'اقتصاد'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'رياضة'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'علوم'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادت'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    // then means after finishing because the function is async
    // and onError means on case of an error happen
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSucceedState());
    }).catchError((error, stackTrace) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error);
      print(stackTrace);
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    // then means after finishing because the function is async
    // and onError means on case of an error happen
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSucceedState());
    }).catchError((error, stackTrace) {
      emit(NewsGetSportsErrorState(error.toString()));
      print(error);
      print(stackTrace);
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    // then means after finishing because the function is async
    // and onError means on case of an error happen
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSucceedState());
    }).catchError((error, stackTrace) {
      emit(NewsGetScienceErrorState(error.toString()));
      print(error);
      print(stackTrace);
    });

  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    // then means after finishing because the function is async
    // and onError means on case of an error happen
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'bfb2ec776a074c41b125afac379c0fd4',
      'from': '2022-06-20',
      'sortBy': 'popularity'
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSucceedState());
    }).catchError((error, stackTrace) {
      emit(NewsGetSearchErrorState(error.toString()));
      print('there is an error while getting search data');
      // print(stackTrace);
    });

  }


  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }


}
