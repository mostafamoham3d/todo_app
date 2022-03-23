import 'package:flutter/material.dart';
import 'package:todo_app/bloc/cubit.dart';

Widget customTextFormField({
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.text,
  required function,
  required String label,
  required IconData prefixIcon,
  onTap,
}) {
  return TextFormField(
    onTap: onTap,
    controller: controller,
    keyboardType: textInputType,
    validator: function,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      labelText: label,
      prefixIcon: Icon(prefixIcon),
    ),
  );
}

Widget taskItem(Map model, BuildContext context) {
  return Dismissible(
    direction: DismissDirection.startToEnd,
    background: Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      color: Colors.redAccent,
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteRecord(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${model['title']} has been deleted')));
    },
    key: Key(model['id'].toString()),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateDataBase(status: 'done', id: model['id']);
          },
          icon: Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateDataBase(status: 'archived', id: model['id']);
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  );
}

Widget doneTaskItem(Map model, BuildContext context) {
  return Dismissible(
    direction: DismissDirection.startToEnd,
    background: Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      color: Colors.redAccent,
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteRecord(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${model['title']} has been deleted')));
    },
    key: Key(model['id'].toString()),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateDataBase(status: 'archived', id: model['id']);
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  );
}

Widget archivedTaskItem(Map model, BuildContext context) {
  return Dismissible(
    direction: DismissDirection.startToEnd,
    background: Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      color: Colors.redAccent,
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteRecord(id: model['id']);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${model['title']} has been deleted')));
    },
    key: Key(model['id'].toString()),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context)
                .updateDataBase(status: 'done', id: model['id']);
          },
          icon: Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ),
      ],
    ),
  );
}
