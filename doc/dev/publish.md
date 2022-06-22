# 发布

Google网站在大陆可能有问题，命令行使用代理：
```shell
export https_proxy=http://127.0.0.1:8889
```

发布：
```shell
flutter packages pub publish --server=https://pub.dartlang.org
```
如果配置过国内的镜像，注意增加server参数。

根据我们的规则，预发布版本不加入Changelog，Flutter/Dart发布工具会报警告。手动选择y即可。

在浏览器复制打开验证身份的链接，用QuantTide的Google账号验证身份。

获取AccessToken和RefreshToken，即可在CI中使用。
> Since Dart 2.15, the third-party pub's token is stored at /Users/username/Library/Application Support/dart/pub-tokens.json (macOS)
实际位置是"pub-credentials.json"

## 参考资料

- https://pub.dev/packages/unpub_auth
