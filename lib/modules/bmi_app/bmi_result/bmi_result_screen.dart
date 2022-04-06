import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final double result1;
  final bool isMale1;
  final int age1;

  BmiResultScreen({
    @required this.result1=2,
    @required this.isMale1=true,
    @required this.age1=1,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Result',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.arrow_back_ios_outlined) ,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale1 ? 'Male':'Female'}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Result : ${result1.round()}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Age : $age1',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
