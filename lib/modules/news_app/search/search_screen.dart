import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/news_app/cubit/cubit.dart';
import 'package:untitled1/layout/news_app/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(
            title: Text('Hi 😍'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defualtFormField(
                    controller: searchController,
                    type:TextInputType.text,
                    prefix:Icons.search,
                    textValidate:'search must not be embty',
                    lable:'search',
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    }
                ),
              ),
                Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      } ,
    );
  }
}
