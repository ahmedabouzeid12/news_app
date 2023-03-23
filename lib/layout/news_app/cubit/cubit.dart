
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState(),);

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screen =[
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];


  void changeBottomNavState(int index)
  {
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> bussiness =[];

  void getBussiness()
  {
    emit(NewsGetBussinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:  {
        'country':'eg',
        'category':'business',
        'apiKey':'b4a9c8b128934dd8a0a19fb2ac5be1ab',
      },
      token:'b4a9c8b128934dd8a0a19fb2ac5be1ab',
    ).then((value)
    {
      // print(value.data['articles'][0]['title']);
      bussiness = value.data['articles'];
      print(bussiness[0]['title']);
      emit(NewsGetBussinessSuccessState());
    }).catchError((erorr)
    {
      print(erorr.toString());
      emit(NewsGetBussinessErrorState(erorr.toString()));
    });
  }

  List<dynamic> sports =[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
      if(sports.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:  {
            'country':'eg',
            'category':'sports',
            'apiKey':'b4a9c8b128934dd8a0a19fb2ac5be1ab',
          },
          token:'b4a9c8b128934dd8a0a19fb2ac5be1ab',
        ).then((value)
        {
          // print(value.data['articles'][0]['title']);
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((erorr)
        {
          print(erorr.toString());
          emit(NewsGetSportsErrorState(erorr.toString()));
        });
      }else 
        {
          emit(NewsGetSportsSuccessState());
        }

  }

  List<dynamic> science =[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:  {
            'country':'eg',
            'category':'science',
            'apiKey':'b4a9c8b128934dd8a0a19fb2ac5be1ab',
          },
          token:'b4a9c8b128934dd8a0a19fb2ac5be1ab',
        ).then((value)
        {
          // print(value.data['articles'][0]['title']);
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((erorr)
        {
          print(erorr.toString());
          emit(NewsGetScienceErrorState(erorr.toString()));
        });
      }else
        {
          emit(NewsGetScienceSuccessState());
        }

  }

  List<dynamic> search =[];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    // search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query:  {
        'q':'$value',
        'apiKey':'b4a9c8b128934dd8a0a19fb2ac5be1ab',
      },
      token:'b4a9c8b128934dd8a0a19fb2ac5be1ab',
    ).then((value)
    {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((erorr)
    {
      print(erorr.toString());
      emit(NewsGetSearchErrorState(erorr.toString()));
    });
  }
}