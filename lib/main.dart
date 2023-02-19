import 'package:diamond_app/utils/service/service_app_util.dart';
import 'package:diamond_app/utils/service/service_firebase.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/data/provider/storage/storage_token.dart';
import 'app/modules/root/bindings/root_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'utils/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await ServiceFirebase.instance.initializer();
  ServiceAppUtil.setupAppConfig();
  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              //** global unfocus || hide keyboard when user tap out side any Textfield ... */
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: GetMaterialApp(
              navigatorKey: Get.key,
              title: "DiamondApp",
              builder: (context, child) => ScrollConfiguration(
                behavior: const ScrollBehaviorModified(),
                child: child!,
              ),
              initialRoute: StorageToken.isAccessTokenExist()
                  ? AppPages.MAIN
                  : AppPages.INITIAL,
              themeMode: ThemeMode.light,
              theme: AppThemes.lightTheme,
              getPages: AppPages.routes,
              initialBinding: RootBinding(),
            ),
          );
        }),
  );
}

// set global scrollview's behavior
class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
        return const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return const ClampingScrollPhysics();
    }
  }
}
