import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/shop_app/search/cubit/cubit.dart';
import 'package:untitled1/modules/shop_app/search/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defualtFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      lable: 'Search',
                      textValidate: 'enter text to search',
                      prefix: Icons.search,
                      onSubmit: (String text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
