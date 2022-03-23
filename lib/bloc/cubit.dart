import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/screens/archived_task_screen.dart';
import 'package:todo_app/screens/done_task_screen.dart';
import 'package:todo_app/screens/task_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    NewTaskScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> appBarTitle = ['New Task', 'Done Tasks', 'Archived Tasks'];
  bool isBottomSheetOpened = false;
  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void toggleBottomSheet(bool val) {
    isBottomSheetOpened = val;
    emit(ChangeBottomSheetToggle());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  void createDataBase() {
    try {
      openDatabase('todo.db', version: 1, onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)');
      }, onOpen: (db) {
        getDataFromDataBase(db);
        print('opened');
      }).then((value) {
        database = value;
        emit(CreateDataBaseState());
      });
    } catch (E) {
      print(E.toString());
    }
  }

  insertToDataBase(String title, String time, String date) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('inserted');
        emit(InsertDataToDataBaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print(error);
      });
    });
  }

  void getDataFromDataBase(Database db) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(GetDataFromDataBaseState());
    });
  }

  void updateDataBase({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(UpdateDataBaseState());
    });
  }

  void deleteRecord({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteRecordState());
    });
  }
}
