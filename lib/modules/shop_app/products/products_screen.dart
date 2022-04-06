import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/models/shop_app/categories_model.dart';
import 'package:untitled1/models/shop_app/home_model.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/styles/color.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model!.status) {
            showToast(text: state.model!.message, state: ToastStates.WARNING);
          } else {
            showToast(text: state.model!.message, state: ToastStates.SUCCESS);
          }
          ;
        }
        ;
        if (state is ShopErrorChangeFavoritesState) {
          showToast(text: state.model!.message, state: ToastStates.SUCCESS);
        }
        ;
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categries',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel!.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data.data.length,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'New Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.55,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: defualtColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (model.discount != 0)
                        Text(
                          '${model.oldprice.round()}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        //color: Colors.black,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                          print('id == ${model.id}');
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? defualtColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
