import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/models/shop_app/categories_model.dart';
import 'package:untitled1/shared/components/components.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder:(context,state)=>ListView.separated(
        itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
      ),
       listener:(context,state)=>{},
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  '${model.image}'),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.teal,
            ),
          ],
        ),
      );
}
