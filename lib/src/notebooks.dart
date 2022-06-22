/// 笔记本组件（Notebook）
///
/// Inspired by Jupyter and RMarkdown.
///
/// TODO：
///   - 抽象Notebook类组件的共同接口。

import "package:flutter/material.dart";

import "package:flutter_markdown/flutter_markdown.dart";
import "package:markdown/markdown.dart" as md;

import "executors.dart";


/// Markdown代码运行渲染器抽象类
///
/// TODO: 增加编辑输入功能。
/// TODO：考虑重命名为MarkdownExecutiveCodeBuilder
abstract class MarkdownCodeExecutingBuilder extends MarkdownElementBuilder {
  /// 代码运行器实例
  CloudExecutor executor;

  MarkdownCodeExecutingBuilder(this.executor);

  /// 渲染输入
  Widget buildInput(String input);

  /// 渲染输出
  Widget buildOutput(String output);

  /// 渲染输出前的加载状态
  Widget buildProgressiveOutput();

  /// 渲染异常输出
  Widget buildErrorOutput(e);

  /// 渲染输入组件和输出组件的布局
  Widget buildLayout(Widget inputWidget, Widget outputWidget){
    return Column(
      children: [
        inputWidget,
        outputWidget,
      ],
    );
  }

  /// 运行输入得到输出并渲染
  ///
  /// 参考资料：
  ///   - API文档：https://pub.dev/documentation/flutter_markdown/latest/flutter_markdown/MarkdownElementBuilder/visitElementAfter.html
  ///   - 样例：https://github.com/flutter/packages/blob/main/packages/flutter_markdown/example/lib/demos/subscript_syntax_demo.dart#L147
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // 输入
    String input = element.textContent;
    // 运行和渲染输出
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
              return buildErrorOutput(snapshot.error);
            } else {
              // 请求成功，显示数据
              return buildOutput(snapshot.data);
            }
          } else {
            // 请求未结束，显示正在加载的状态
            return buildProgressiveOutput();
          }
        },
      ),
    );
  }
}
