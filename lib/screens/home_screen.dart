import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/modules/reusable_widgets.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.appBarTitle[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archive',
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (val) {
                cubit.changeIndex(val);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: cubit.currentIndex == 0
                ? FloatingActionButton(
                    child: Icon(
                        cubit.isBottomSheetOpened ? Icons.add : Icons.edit),
                    onPressed: () {
                      if (cubit.isBottomSheetOpened) {
                        if (formKey.currentState!.validate()) {
                          cubit
                              .insertToDataBase(titleController.text,
                                  timeController.text, dateController.text)
                              .then((value) {
                            Navigator.of(context).pop();
                            cubit.toggleBottomSheet(false);
                          });
                        }
                      } else {
                        scaffoldKey.currentState!
                            .showBottomSheet(
                                (context) => Container(
                                      padding: EdgeInsets.all(20),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            customTextFormField(
                                              controller: titleController,
                                              function: (val) {
                                                if (val.isEmpty) {
                                                  return 'Task title cant be empty';
                                                }
                                                return null;
                                              },
                                              label: 'Title',
                                              prefixIcon: Icons.title,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            customTextFormField(
                                                controller: timeController,
                                                function: (val) {
                                                  if (val.isEmpty) {
                                                    return 'Task time cant be empty';
                                                  }
                                                  return null;
                                                },
                                                label: 'Time',
                                                prefixIcon:
                                                    Icons.watch_later_outlined,
                                                textInputType:
                                                    TextInputType.datetime,
                                                onTap: () {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  ).then((value) {
                                                    timeController.text = value!
                                                        .format(context)
                                                        .toString();
                                                  });
                                                }),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            customTextFormField(
                                                controller: dateController,
                                                function: (val) {
                                                  if (val.isEmpty) {
                                                    return 'Task date cant be empty';
                                                  }
                                                  return null;
                                                },
                                                label: 'Date',
                                                prefixIcon:
                                                    Icons.calendar_today,
                                                textInputType:
                                                    TextInputType.datetime,
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime.now().add(
                                                      Duration(days: 30),
                                                    ),
                                                  ).then((value) {
                                                    dateController.text =
                                                        DateFormat.yMMMd()
                                                            .format(value!);
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                elevation: 20)
                            .closed
                            .then((value) {
                          cubit.toggleBottomSheet(false);
                        });
                        cubit.toggleBottomSheet(true);
                      }
                    },
                  )
                : null,
          );
        },
      ),
    );
  }
}
