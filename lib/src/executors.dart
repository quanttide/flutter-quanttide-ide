/// 云端代码运行器（CloudExecutor）
///
/// author: 张果
/// created_date: 2022-04-07
///
/// 参考资料：
///   - https://pub.dev/packages/http
///
/// TODO：
///   - 为CloudExecutor定义Type（https://api.dart.dev/stable/2.16.1/dart-core/Type-class.html），方便自定义代码执行器在其他组件使用。
///   - 拆分CloudExecutor为Abstract和它的实现两个类，以方便开发者使用库时二次定义CloudExecutor的execute等方法。


import 'package:http/http.dart' as http;


/// 云端代码执行器
///
/// 输入（input） -> 云端执行 -> 输出（output）
/// 以云原生的标准，input通常由代码（code）、声明式配置（config）、环境变量（envvar）三个部分。
///
/// 定义Provider监听input和output，和Input、Output、ControlPanel组件一起工作。
///
/// TODO：声明式配置的形态还不能确定，暂时先不定义，留待后续进行break change或者no break change。
class CloudExecutor {
  /// 云端代码运行地址
  /// api.quanttide.com，可随着环境切换
  String host;
  /// execute/，通常在一个APP内固定
  String path;

  CloudExecutor({required this.host, required this.path});

  /// 执行代码
  ///
  /// HTTPS协议确保安全，POST方法，可选的options作为URL参数，code作为请求报文（POST data）
  Future<String> execute(String code, {Map<String, dynamic>? options}) async {
    // https://api.dart.dev/stable/2.16.1/dart-core/Uri/Uri.https.html
    Uri url = Uri.https(host, path, options);
    // https://pub.dev/documentation/http/latest/http/post.html
    // 关于body参数：
    // > If it's a String, it's encoded using encoding and used as the body of the request.
    // > The content-type of the request will default to "text/plain".
    http.Response response = await http.post(url, body: code);
    return response.body;
  }
}
