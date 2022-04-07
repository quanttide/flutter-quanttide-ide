/// Notebook组件
///
/// Inspired by Jupyter and RMarkdown.
///
/// - Markdown代码渲染组件，用以辅助`flutter_markdown`库。

import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:markdown/markdown.dart" as md;


class MarkdownCodeRunningBuilder extends MarkdownElementBuilder {
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

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    const markdownCodeResultText = "Hello, world!";
    String returnText = element.textContent + '\n' + markdownCodeResultText;
    return Text(
      returnText,
      style: preferredStyle,
    );
  }
}