import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/news_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class NewsLaayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state)  {},
      builder: (context, state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
              icon: Icon(Icons.search,),
              onPressed: ()
              {
                navigateTo(context, SearchScreen(),);
              },
          ),
              IconButton(
              icon: Icon(
                Icons.brightness_4_outlined,
              ),
              onPressed: ()
              {
                AppCubit.get(context).changeAppMode(formShared: true);
              },
          ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          // floatingActionButton: FloatingActionButton(
          //   onPressed: ()
          //   {
          //     DioHelper.getData(
          //         url: 'v2/top-headlines',
          //         query:  {
          //           'country':'eg',
          //           'category':'business',
          //           'apiKey':'b4a9c8b128934dd8a0a19fb2ac5be1ab',
          //         },
          //     ).then((value)
          //     {
          //       print(value.data['articles'][0]['title']);
          //     }).catchError((erorr)
          //         {
          //           print(erorr.toString());
          //         });
          //     },
          //   child: Icon(
          //     Icons.add,
          //   ),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
                cubit.changeBottomNavState(index);
            },
            items: cubit.bottomItems,
            selectedItemColor: Colors.deepOrange,
          ),
        );
      },
    );
  }
}
