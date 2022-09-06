# `cloud_ide_widgets`

Cloud IDE Widgets for Flutter

## Usage

```dart
import 'pacakge:cloud_ide_widgets/cloud_ide_widgets.dart';

executor = CloudExecutor(
    host: 'your.host.com',
    path: '/path',
);

String input = 'print("Hello, world!")';
String output = await executor.execute(input);
print(output);
```
