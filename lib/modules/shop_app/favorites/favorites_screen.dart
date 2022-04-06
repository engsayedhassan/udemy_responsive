import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) => ConditionalBuilder(
        condition: state is! ShopLoadingGetFavoritesState,
        builder: (context)=>ListView.separated(
          itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        ),
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      ),
      listener: (context, state) => {},
    );
  }
}
