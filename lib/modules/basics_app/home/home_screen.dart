import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'First App',
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('notification_important_sharp');
            },
            icon: Icon(
              Icons.notification_important_sharp,
            ),
          ),
          Icon(
              Icons.search,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  //topStart: const Radius.circular(20),
                  topEnd: const Radius.circular(20),
                  bottomStart: const Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg'),
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.lime.withOpacity(.4),
                    width: 200,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child:IconButton(
                      onPressed: () {
                        print('on press on First word');
                      },
                      icon: Text(
                        'First',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
