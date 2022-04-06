import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/news_app/cubit/states.dart';
import 'package:untitled1/modules/news_app/business/business_screen.dart';
import 'package:untitled1/modules/news_app/scince/scince_screen.dart';
import 'package:untitled1/modules/news_app/settings/settings_screen.dart';
import 'package:untitled1/modules/news_app/sports/sports_screen.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'setting',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SprotsScreen(),
    SineceScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    ;
    if (index == 2) {
      getScience();
    }
    ;
    emit(NeWsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NeWsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      qury: {
        'country':'eg',
        'category':'business',
        'apiKey':'0f825cc052e54af1ae0c7bf40403a5a7',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NeWsGetBusinessSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NeWsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NeWsGetSportsLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        qury: {
          'country':'eg',
          'category':'sports',
          'apiKey':'0f825cc052e54af1ae0c7bf40403a5a7',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NeWsGetSportsSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NeWsGetSportsErrorStates(error.toString()));
      });
    } else {
      emit(NeWsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NeWsGetScienceLoadingStates());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        qury: {
          'country':'eg',
          'category':'science',
          'apiKey':'0f825cc052e54af1ae0c7bf40403a5a7',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NeWsGetScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NeWsGetScienceErrorStates(error.toString()));
      });
    } else {
      emit(NeWsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NeWsGetSearchLoadingStates());
    DioHelper.getData(
      url: 'v2/everything',
      qury: {
        'q': '$value',
        'apiKey': '0f825cc052e54af1ae0c7bf40403a5a7',
      },
    ).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NeWsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NeWsGetSearchErrorStates(error.toString()));
    });
  }
}
