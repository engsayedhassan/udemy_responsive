import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              // المفروض أضع هنا صورة بس مش معابا نت background : networkImage
            ),
            const SizedBox(width: 10),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 13,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 13,
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                    ),
                    SizedBox(height: 10),
                    Text('search'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // List View Story
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 20),
                  itemCount: 10,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics:NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context, index)=>buildChatItem(),
                  separatorBuilder:(context, index)=>SizedBox(height:20),
                  itemCount:15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Container(
    width: 50,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 2, end: 4),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 2, end: 4),
              child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'sayed hassan hamoda',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 2, end: 4),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 2, end: 4),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'eng sayed hassan sayed hassan sayed hassan',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'hello my name is sayedhassan sayed hassan sa;ddddddddd',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Text(' 2 : 33 M'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

}
