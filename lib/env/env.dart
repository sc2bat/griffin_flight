import 'package:envied/envied.dart';



@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // TEST_API_URL
  @EnviedField()
  static const String testApiUrl = _Env.testApiUrl;

  // SAMPLE_AIRPORT_URL
  @EnviedField()
  static const String sampleAirportUrl = _Env.sampleAirportUrl;

// DUMP_AIRPLANE_URL
  @EnviedField()
  static const String dumpAirplaneUrl = _Env.dumpAirplaneUrl;

// DUMP_AIRPORT_URL
  @EnviedField()
  static const String dumpAirportUrl = _Env.dumpAirportUrl;

// DUMP_FLIGHT_URL
  @EnviedField()
  static const String dumpFlightUrl = _Env.dumpFlightUrl;

// DUMP_BOOK_URL
  @EnviedField()
  static const String dumpBookUrl = _Env.dumpBookUrl;
}
