import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/modules/bmi_app/bmi_result/bmi_result_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool is_Male = true;
  double height = 120;
  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bmi Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          is_Male = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: is_Male ? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/male.png'),
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          is_Male = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: is_Male ? Colors.grey[400] : Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/female.png'),
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${height.round()}',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'cm',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: height,
                      max: 220,
                      min: 50,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                child: Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            '$weight',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                child: Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed: () {
                double result = weight / pow(height / 100, 2);
                print(result.round());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BmiResultScreen(
                        age1: age, isMale1: is_Male, result1: result),
                  ),
                );
              },
              height: 50,
              child: Text(
                'calculator',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
