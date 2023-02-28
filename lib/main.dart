import 'package:fake_api/logic/view_models/navigation_provider.dart';
import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/routes/app_pages.dart';
import 'package:fake_api/ui/routes/app_routes.dart';
import 'package:fake_api/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: GetMaterialApp(
        title: 'Fake Api',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
