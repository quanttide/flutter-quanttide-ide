/// 终端组件（Console）
///
/// author: 张果
/// created at: 2021-03-01
/// updated at: 2021-03-01


import 'package:flutter/material.dart';


class PythonConsoleItemWidget extends StatefulWidget {
  /// Python终端Item组件

  const PythonConsoleItemWidget({Key? key}) : super(key: key);

  @override
  State createState() => PythonConsoleItemWidgetState();
}

class PythonConsoleItemWidgetState extends State<PythonConsoleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: const [
              Text(">>>"),
              Text("input"),
              // FormField(builder: ),
            ],
          ),
          const Text('output')
        ]
    );
  }
}


class PythonConsoleWidget extends StatefulWidget {
  /// Python终端组件

  const PythonConsoleWidget({Key? key}) : super(key: key);

  @override
  createState() => PythonConsoleWidgetState();
}

class PythonConsoleWidgetState extends State<PythonConsoleWidget>{
  @override
  Widget build(BuildContext context){
    // TODO: implement build
    throw UnimplementedError();
  }
}
