/// 笔记本组件示例

import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';

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
          'code': MarkdownCodeExecutingBuilder(
              CloudExecutor(
                host: EnvironmentConfig.executorHost,
                path: EnvironmentConfig.executorPath,
              )
          ),
        }
    );
  }
}