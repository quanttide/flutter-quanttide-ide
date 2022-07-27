/// 编辑器组件（Editor）
///
/// 在执行器（Executor）的基础上提供完善的控制器（ControlPanel）。
///
/// 比较其他组件：
///   - 终端（Console）不提供ControlPanel，只通过预定的`enter`执行和返回结果。
///   - 笔记本（Notebook）提供ControlPanel的有限能力或者不提供，主要用以有条理地展示结果。

import 'package:flutter/material.dart';


class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}