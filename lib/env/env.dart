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

  // GRIFFIN_GET_URL
  @EnviedField()
  static const String griffinGetUrl = _Env.griffinGetUrl;

  // GRIFFIN_POST_URL
  @EnviedField()
  static const String griffinPostUrl = _Env.griffinPostUrl;

  // GRIFFIN_ACCOUNT_URL
  @EnviedField()
  static const String griffinAccountUrl = _Env.griffinAccountUrl;

  // SAMPLE_ACCOUNT_INFO
  @EnviedField()
  static const String sampleAccountUserid = _Env.sampleAccountUserid;
  @EnviedField()
  static const String sampleAccountUsername = _Env.sampleAccountUsername;
  @EnviedField()
  static const String sampleAccountEmail = _Env.sampleAccountEmail;
  @EnviedField()
  static const String sampleAccountPassword = _Env.sampleAccountPassword;

  // ANDROID_APPLICATION_ID
  @EnviedField()
  static const String androidApplicationId = _Env.androidApplicationId;

  // IOS_APPLICATION_ID
  @EnviedField()
  static const String iosApplicationId = _Env.iosApplicationId;
}
