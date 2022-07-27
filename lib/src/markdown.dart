/// Markdown组件

import "package:flutter/material.dart";
import 'package:flutter_highlight/flutter_highlight.dart';

import "package:flutter_markdown/flutter_markdown.dart";
import "package:markdown/markdown.dart" as md;

import "executor.dart";


/*
Dart Markdown
*/

class ExecutiveCodeSyntax extends md.BlockSyntax {
  const ExecutiveCodeSyntax();

  @override
  md.Node? parse(md.BlockParser parser) {
    // TODO: implement parse
    throw UnimplementedError();
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => throw UnimplementedError();
  // TODO: 复制并修改FencedCodeSyntax。考虑定义一个抽象类方便MyST继承。
  // tag暂定code-cell
}


final md.ExtensionSet mystMarkdown = md.ExtensionSet(
  List<md.BlockSyntax>.unmodifiable(
    <md.BlockSyntax>[
      const ExecutiveCodeSyntax(),
      const md.FencedCodeBlockSyntax(),
    ],
  ),
  List<md.InlineSyntax>.unmodifiable(
    <md.InlineSyntax>[
    ],
  ),
);


/*
Flutter Markdown组件
*/

/// 抽象类
abstract class BaseExecutiveCodeBuilder extends MarkdownElementBuilder {

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
    return buildExecutiveCodeBlock(input);
  }

  /// 渲染输入组件和输出组件的布局
  Widget buildExecutiveCodeBlock(String input);

  /// 渲染输入组件
  Widget buildInput(String input);

  /// 渲染输出组件
  Widget buildOutput(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    switch (snapshot.connectionState){
      case ConnectionState.none:
      // 初始
        return buildOutputNone();
      case ConnectionState.waiting:
      // 加载
        return buildOutputWaiting();
      default:
      // 异常
        if (snapshot.hasError){
          return buildOutputWithError(snapshot.error);
        }
        // 正常
        return buildOutputWithData(snapshot.data);
    }
  }

  /// 渲染正常输出
  Widget buildOutputWithData(String output);

  /// 渲染初始状态
  Widget buildOutputNone();

  /// 渲染加载状态
  Widget buildOutputWaiting();

  /// 渲染异常输出
  Widget buildOutputWithError(dynamic error);

}

/// Markdown代码运行渲染器抽象类
///
/// TODO: 增加编辑输入功能。
class ExecutiveCodeBuilder extends BaseExecutiveCodeBuilder {
  /// 代码运行器实例
  CloudExecutor executor;

  ExecutiveCodeBuilder(this.executor);

  @override
  Widget buildExecutiveCodeBlock(String input) {
    return Column(
      children: [
        buildInput(input),
        FutureBuilder(
          future: executor.execute(input),
          builder: buildOutput,
        )
      ]
    );
  }

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

  @override
  Widget buildOutputWithData(String output){
    return Text(output);
  }

  @override
  Widget buildOutputNone() {
    return const Text('');
  }

  @override
  Widget buildOutputWaiting(){
    return const Text('代码运行中...');
  }

  @override
  Widget buildOutputWithError(error){
    return Text("代码运行异常：\n${error.toString()}");
  }
}
