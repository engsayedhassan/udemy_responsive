import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled1/modules/shop_app/search/search_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.curruntIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.curruntIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Cateogries',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
