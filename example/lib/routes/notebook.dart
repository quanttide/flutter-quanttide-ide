/// 笔记本组件示例

import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

import 'package:cloud_ide_widgets/cloud_ide_widgets.dart';

import '../environment_config.dart';


const markdownCodeText = """
```python
print("Hello, world!")
```
""";


class NotebookRoute extends StatelessWidget {
  const NotebookRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
        key: const Key("notebook-example"),
        data: markdownCodeText,
        selectable: true,
        builders: {
          'code': CustomMarkdownCodeExecutingBuilder(
              CloudExecutor(
                host: EnvironmentConfig.executorHost,
                path: EnvironmentConfig.executorPath,
              )
          ),
        }
    );
  }
}


class CustomMarkdownCodeExecutingBuilder extends MarkdownCodeExecutingBuilder {
  CustomMarkdownCodeExecutingBuilder(CloudExecutor executor) : super(executor);

  /// 渲染输入
  ///
  /// 参考资料：
  ///   - https://pub.dev/packages/flutter_highlight#-readme-tab-
  @override
  Widget buildInput(String input){
    return Container(
        decoration: BoxDecoration(
          // 黑框
          border: Border.all(),
        ),
        child: HighlightView(
          // 代码高亮
          input,
          language: 'python',
        )
    );
  }

  /// 渲染输出
  @override
  Widget buildOutput(String output){
    return Text(output);
  }

  /// 渲染输出前的加载状态
  @override
  Widget buildProgressiveOutput(){
    return const Text('代码运行中...');
  }

  /// 渲染异常输出
  @override
  Widget buildErrorOutput(e){
    return Text("代码运行异常：\n$e");
  }

  /// 渲染输入组件和输出组件的布局
  /// 如果需要可以覆盖默认方法进行自定义
  /*
  @override
  Widget buildLayout(Widget inputWidget, Widget outputWidget){
    return Column(
      children: [
        inputWidget,
        outputWidget,
      ],
    );
  }
   */
}