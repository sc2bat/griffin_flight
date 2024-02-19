import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // TEST_API_URL
  @EnviedField()
  static const String testApiUrl = _Env.testApiUrl;

  // SAMPLE_AIRPORT_URL
  @EnviedField()
  static const String sampleAirportUrl = _Env.sampleAirportUrl;
}
