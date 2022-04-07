/// 云端代码运行器模块
///
/// author: 张果
/// created_date: 2022-04-07
///
/// 参考资料：
///   - https://pub.dev/packages/http


import 'package:http/http.dart' as http;


class CloudExecutor {
  /// 云端代码运行地址
  ///
  /// host: api.quanttide.com，可随着环境切换
  /// path: execute/，通常在一个APP内固定

  String host, path;

  CloudExecutor({required this.host, required this.path});

  Future<String> execute({required String code, Map<String, dynamic>? options}) async {
    /// 执行代码
    ///
    /// HTTPS协议确保安全，POST方法，可选的options作为URL参数，code作为请求报文（POST data）

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
