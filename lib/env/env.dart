import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'TMD_APIKEY', obfuscate: true)
  static final String tmdApiKey = _Env.tmdApiKey;
}
