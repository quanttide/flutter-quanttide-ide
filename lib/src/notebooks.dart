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
/// ### 用例
///
/// ```flutter
/// Markdown(
///   ...
///   builders: {
///     'code': MarkdownCodeRunningBuilder(),
///   }
/// )
/// ```
class MarkdownCodeRunningBuilder extends MarkdownElementBuilder {
  /// 代码运行器实例
  CloudExecutor executor;

  MarkdownCodeRunningBuilder(this.executor);

  /// 渲染输入
  ///
  /// 参考资料：
  ///   - https://pub.dev/packages/flutter_highlight#-readme-tab-
  Widget buildCodeInput(String codeInput){
    return Container(
      decoration: BoxDecoration(
        // 黑框
        border: Border.all(),
      ),
      child: HighlightView(
        // 代码高亮
        codeInput,
        language: 'python',
      )
    );
  }

  /// 渲染输出
  Widget buildCodeOutput(codeOutput){
    return HighlightView(
      // 代码高亮
      codeOutput,
      language: 'python',
    );
  }

  /// 渲染输入和输出
  Widget? build(String codeInput, String codeOutput){
    return Column(
      children: [
        buildCodeInput(codeInput),
        buildCodeOutput(codeOutput),
      ],
    );
  }

  /// 运行输入得到输出结果，输入和输出为两个组件分别渲染。
  ///
  /// 参考资料：
  ///   - https://stackoverflow.com/questions/59592640/how-to-add-code-syntax-highlighter-to-flutter-markdown
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // 输入代码
    String codeInput = element.textContent;
    dynamic codeOutput;
    executor.execute(codeInput).then((result){
      codeOutput = result;
    });
    return build(codeInput, codeOutput);
  }
}