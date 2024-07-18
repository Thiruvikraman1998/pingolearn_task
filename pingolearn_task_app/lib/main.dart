import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn_task_app/firebase_options.dart';
import 'package:pingolearn_task_app/models/user_model.dart';
import 'package:pingolearn_task_app/services/firebase_remote_config/firebase_remote_config_service.dart';
import 'package:pingolearn_task_app/utils/theme_data.dart';
import 'package:pingolearn_task_app/viewmodels/auth_viewmodels/auth_viewmodel.dart';
import 'package:pingolearn_task_app/viewmodels/news_headlines_viewmodels/news_headlines_viewmodel.dart';
import 'package:pingolearn_task_app/viewmodels/remote_config_viewmodel/remote_config_viewmode.dart';
import 'package:pingolearn_task_app/views/auth/login_page.dart';
import 'package:pingolearn_task_app/views/auth/signup.dart';
import 'package:pingolearn_task_app/views/news_headlines_views/news_headlines_pages/news_headlines_list.dart';
import 'package:pingolearn_task_app/widgets/ui_providers/ui_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfigService = FirebaseRemoteConfigService();
  await remoteConfigService.initializeConfigMethods();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsHeadLineProvider()),
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (context) => UiProvider()),
        ChangeNotifierProvider(
            create: (context) => FirebaseRemoteConfigProvider()),
      ],
      child: MaterialApp(
        title: 'MyNews',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: AppTheme.scaffoldBgColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppTheme.primaryColor,
            titleTextStyle: TextStyle(color: AppTheme.secondaryColor, fontSize: 24,fontWeight: FontWeight.w900),
          ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
          //     textStyle: WidgetStateProperty.all(
          //       TextStyle(color: AppTheme.secondaryColor),
          //     ),
          //   ),
          // ),
          useMaterial3: true,
        ),
        home: Consumer<FirebaseAuthProvider>(
          builder: (context, authProvider, child) => StreamBuilder<UserModel?>(
            stream: authProvider.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const NewsHeadlinesList();
              } else {
                return const Signup();
              }
            },
          ),
        ),
      ),
    );
  }
}
