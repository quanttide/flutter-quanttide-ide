import 'package:cloud_ide_widgets/src/executors.dart';
import 'package:cloud_ide_widgets/environment_config.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('云端执行', () async {
    CloudExecutor executor = CloudExecutor(
      host: EnvironmentConfig.testExecutorHost,
      path: EnvironmentConfig.testExecutorPath,
    );
    String result = await executor.execute(code: 'print("Hello, world!")');
    // 注意格式为r'xxx'
    assert(result == r'"Hello, world!\n"');
  });
}
