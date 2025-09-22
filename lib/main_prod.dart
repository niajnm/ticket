import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ticket/app/core/provider/provider.dart';
import 'package:ticket/app/core/services/service_locator.dart';
import 'package:ticket/main.dart';

import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

void main() async {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter Prod",
    baseUrl: "https://api.github.com/",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  WidgetsFlutterBinding.ensureInitialized();

  // await GetStorage.init(databaseName);
  await ScreenUtil.ensureScreenSize();
  await ServiceLocator.setUpServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: ProviderPath.providersList, child: MyApp()));
}
