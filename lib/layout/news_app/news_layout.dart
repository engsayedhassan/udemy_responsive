import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/news_app/cubit/cubit.dart';
import 'package:untitled1/layout/news_app/cubit/states.dart';
import 'package:untitled1/modules/news_app/search/search_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/cubit/cubit.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Newslayout'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }
                  ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              )
            ],
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.add),
          ),*/
          body: (cubit.screens[cubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
