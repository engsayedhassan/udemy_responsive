import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled1/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:untitled1/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:untitled1/shared/cubit/states.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titels = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];
  Database? database;

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database created ');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT , date TEXT , status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFormDdatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value inserted successfully👌👍');
        emit(AppInsertDatabaseState());
        getDataFormDdatabase(database);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFormDdatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
    // print(task);
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFormDdatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawUpdate(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value) {
      getDataFormDdatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required isShow, required icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) =>
          emit(AppChangeModeState()));
    }
  }

}
