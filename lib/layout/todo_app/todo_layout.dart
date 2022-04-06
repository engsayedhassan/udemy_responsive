import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/cubit/cubit.dart';
import 'package:untitled1/shared/cubit/states.dart';

class Todolayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timingController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context,AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titels[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown &&
                    formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                      title: titleController.text,
                      time: timingController.text,
                      date: dateController.text);
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defualtFormField(
                                  onChange: (value) {
                                    print(value);
                                  },
                                  controller: titleController,
                                  type: TextInputType.text,
                                  lable: 'Task Titel',
                                  prefix: Icons.title,
                                  textValidate: 'title must not be empty',
                                ),
                                SizedBox(height: 20),
                                defualtFormField(
                                  controller: timingController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timingController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  lable: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                  textValidate: 'time must not be empty',
                                ),
                                SizedBox(height: 20),
                                defualtFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-04-12'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    lable: 'Task Date',
                                    prefix: Icons.calendar_today,
                                    textValidate: 'date must not be empty'),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
