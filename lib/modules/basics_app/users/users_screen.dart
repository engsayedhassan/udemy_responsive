import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(1, 'sayed', '0102009434455'),
    UserModel(2, 'aml', '8763473870'),
    UserModel(3, 'reda', '7643221098'),
    UserModel(4, 'eman', '67543368986554'),
    UserModel(5, 'basma', '3333345678898'),
    UserModel(6, 'hana', '1097325658'),
    UserModel(7, 'mohamed', '202997732087'),
    UserModel(8, 'mahmod', '0288787499003'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 30),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${user.numberPhone}',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
