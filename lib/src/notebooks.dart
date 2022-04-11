/// 笔记本组件（Notebook）
///
/// Inspired by Jupyter and RMarkdown.
///
/// - Markdown代码渲染组件，用以辅助`flutter_markdown`库。

import "package:flutter/material.dart";

import "package:flutter_markdown/flutter_markdown.dart";
import "package:markdown/markdown.dart" as md;
import 'package:flutter_highlight/flutter_highlight.dart';

import "executors.dart";


/// Markdown代码运行
///
/// 用例：
///
/// ```flutter
/// Markdown(
///   ...
///   builders: {
///     'code': MarkdownCodeExecutingBuilder(executor),
///   }
/// )
/// ```
///
/// 参考资料：
///   - 最佳实践：https://stackoverflow.com/questions/59592640/how-to-add-code-syntax-highlighter-to-flutter-markdown
class MarkdownCodeExecutingBuilder extends MarkdownElementBuilder {
  /// 代码运行器实例
  CloudExecutor executor;

  MarkdownCodeExecutingBuilder(this.executor);

  /// 渲染输入
  ///
  /// 参考资料：
  ///   - https://pub.dev/packages/flutter_highlight#-readme-tab-
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
  Widget buildOutput(String output){
    return Text(output);
  }

  Widget buildLayout(Widget inputWidget, Widget outputWidget){
    return Column(
      children: [
        inputWidget,
        outputWidget,
      ],
    );
  }

  /// 渲染输入和输出
  Widget? build(String input){
    return buildLayout(
      // 输入组件
      buildInput(input),
      // 输出组件
      FutureBuilder(
        // https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
        future: executor.execute(input),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 请求已结束
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return buildOutput("Error: ${snapshot.error}");
            } else {
            // 请求成功，显示数据
            return buildOutput("${snapshot.data}");
            }
          } else {
            // 请求未结束，显示正在加载的状态
            return buildOutput('代码运行中...');
          }
        },
      ),
    );
  }

  /// 运行输入得到输出结果，输入和输出为两个组件分别渲染。
  ///
  /// 参考资料：
  ///   - API文档：https://pub.dev/documentation/flutter_markdown/latest/flutter_markdown/MarkdownElementBuilder/visitElementAfter.html
  ///   - 样例：https://github.com/flutter/packages/blob/main/packages/flutter_markdown/example/lib/demos/subscript_syntax_demo.dart#L147
  @override
  // ignore: body_might_complete_normally_nullable
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // 输入
    String input = element.textContent;
    // 运行和渲染输出
    return build(input);
  }
}