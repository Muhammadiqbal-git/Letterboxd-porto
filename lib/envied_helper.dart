import 'package:envied/envied.dart';

part 'envied_helper.g.dart';

@envied
abstract class Env{
  @EnviedField(varName: 'TMDB', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}

