import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterMinusStates) {
           // print('Minus States ${state.counter}');
          }
          if (state is CounterPlusStates) {
          //  print('Plus States ${state.counter}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: Text(
                      'Minus',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                      'Plus',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
