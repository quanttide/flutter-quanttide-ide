import 'package:flutter_test/flutter_test.dart';
import "package:flutter/material.dart";
import "package:markdown/markdown.dart" as md;

import 'package:cloud_ide_widgets/src/executors.dart';
import 'package:cloud_ide_widgets/src/notebooks.dart';

import 'environment_config.dart';


void main() {
  group('MarkdownCodeExecutingBuilder', (){
    /// 测试数据
    /// 代码执行器实例
    CloudExecutor executor = CloudExecutor(
      host: EnvironmentConfig.testExecutorHost,
      path: EnvironmentConfig.testExecutorPath,
    );

    /// Markdown Element实例
    // https://pub.dev/documentation/markdown/latest/markdown/Element-class.html
    md.Element element = md.Element.text('code', r'print("Hello, world!")');
    // 示例单元测试使用方法
    assert(element.textContent == r'print("Hello, world!")');

    /// 单元测试
    test("实例化", (){
      MarkdownCodeExecutingBuilder builder = MarkdownCodeExecutingBuilder(executor);
    });

    test('visitElementAfter方法', () {
      MarkdownCodeExecutingBuilder builder = MarkdownCodeExecutingBuilder(executor);
      Widget widget = builder.visitElementAfter(element, null)!;
      // assert(widget.);
    });
  });
}