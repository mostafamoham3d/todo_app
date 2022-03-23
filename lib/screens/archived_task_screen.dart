import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/modules/reusable_widgets.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var tasks = AppCubit.get(context).archivedTasks;
        return tasks.length > 0
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          archivedTaskItem(tasks[index], context),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      );
                    }),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('images/3828537.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Task Added Yet, Add Some.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
