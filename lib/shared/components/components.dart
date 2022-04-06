import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/models/shop_app/favorits_model.dart';
import 'package:untitled1/modules/news_app/web_view/web_view_screen.dart';
import 'package:untitled1/shared/cubit/cubit.dart';
import 'package:untitled1/shared/styles/color.dart';

Widget defualtButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double raduis = 5,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
/////////
Widget defualtTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );
//////////////////////////////////////////
Widget defualtFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
  IconData? sufix,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  String? textValidate,
  bool ispassword = false,
  Function? sufixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufix),
          onPressed: () {
            sufixPressed!();
          },
        ),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return textValidate;
        }
        return null;
      },
      onTap: () {
        onTap!();
      },
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
    );
//////////////////////////////////////////////
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.lightGreen,
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
///////////////////////////////////
Widget tasksBuilder(List<Map> tasks) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 70,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
//////////////////////////////
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
//////////////////////////////
Widget buildArticleItem(articles, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(articles['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${articles['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
////////////////////////////////////
Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: (CircularProgressIndicator())),
    );
////////////////
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
////////////////
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
/////////////////
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
/////////////////////////
Widget buildListProduct(model,context,{bool isOldPrice = true}) => Padding(
  padding: EdgeInsets.all(20),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                  '${model.image}'),
              width: 120,
              height: double.infinity,
            ),
            if (model.discount != 0 && isOldPrice)
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
        SizedBox(width: 10),
        Expanded(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.toString()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: defualtColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  if ( model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice}',
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
                    },
                    icon: CircleAvatar(
                      radius: 20,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defualtColor : Colors.grey,
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
  ),
);

