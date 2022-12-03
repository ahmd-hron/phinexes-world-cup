import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:world_cup/pages/change%20password/change_password_page.dart';
import 'package:world_cup/pages/leader%20board/leader_board_page.dart';
import 'package:world_cup/pages/match%20page/home_page.dart';
import 'package:world_cup/pages/profile/profile_page.dart';
import 'package:world_cup/pages/loading/loading_page.dart';
import 'package:world_cup/pages/login/login_page.dart';
import 'package:world_cup/pages/rules/rules_page.dart';
import 'package:world_cup/pages/settings%20page/settting_page.dart';
import 'package:world_cup/pages/taps_page.dart';
import 'package:world_cup/providers/app_state_provier.dart';
import 'package:world_cup/providers/auth_provider.dart';
import 'package:world_cup/providers/matches_provider.dart';
import 'package:world_cup/providers/players_provider.dart';
import 'package:world_cup/providers/prediction_provider.dart';
import 'package:world_cup/providers/rules_provider.dart';
import 'package:world_cup/providers/theme_provider.dart';
import 'package:world_cup/providers/user_point_provider.dart';
import 'package:world_cup/providers/user_provider.dart';
import 'package:world_cup/utility/scaffold_messenger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MatchProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => RulesProvider()),
        ChangeNotifierProvider(create: (ctx) => PredictionProvider()),
        ChangeNotifierProvider(create: (ctx) => PlayersProvider()),
        ChangeNotifierProvider(create: (ctx) => TotalPointsProvider()),
        ChangeNotifierProvider(
          create: (ctx) => AppStateProvider(),
          builder: (context, child) {
            final appState = Provider.of<AppStateProvider>(context);
            return MaterialApp(
              scaffoldMessengerKey: Messenger.instance.scaffoldState,
              theme: MyTheme.darkTheme,
              darkTheme: MyTheme.darkTheme,
              themeMode: ThemeManager.instance.themeMode,
              title: 'World Cup',
              home: !appState.sizeInit
                  ? const LoadingPage()
                  : FutureBuilder(
                      future: UserData.instance.readUserData(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingPage();
                        } else {
                          if (UserData.instance.user == null) {
                            return const LoginPage();
                          } else {
                            return const TapsPage();
                          }
                        }
                      }),
              routes: {
                LoginPage.routeName: (ctx) => const LoginPage(),
                SettingsPage.routeName: (ctx) => const SettingsPage(),
                HomePage.routeName: (ctx) => const HomePage(),
                Profile.routeName: (ctx) => const Profile(),
                LeaderBoardPage.routeName: (ctx) => const LeaderBoardPage(),
                RulesPage.routeName: (ctx) => const RulesPage(),
                ChangePasswordPage.routeName: (ctx) =>
                    const ChangePasswordPage(),
              },
            );
          },
        )
      ],
    );
  }
}
//date home
//app bar filter and date total points
//input field on matches 



/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MatchProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => RulesProvider()),
        ChangeNotifierProvider(create: (ctx) => PredictionProvider()),
        ChangeNotifierProvider(create: (ctx) => PlayersProvider()),
        ChangeNotifierProvider(create: (ctx) => TotalPointsProvider()),
        ChangeNotifierProvider(
          create: (ctx) => AppStateProvider(),
          builder: (context, child) {
            final appState = Provider.of<AppStateProvider>(context);
            return MaterialApp(
              scaffoldMessengerKey: Messenger.instance.scaffoldState,
              theme: MyTheme.darkTheme,
              darkTheme: MyTheme.darkTheme,
              themeMode: ThemeManager.instance.themeMode,
              title: 'Flutter Demo',
              home: !appState.sizeInit
                  ? const LoadingPage()
                  : FutureBuilder(
                      future: UserData.instance.readUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingPage();
                        } else {
                          if (UserData.instance.user == null) {
                            return const LoginPage();
                          } else {
                            return const TapsPage();
                          }
                        }
                      }),
              routes: {
                LoginPage.routeName: (ctx) => const LoginPage(),
                SettingsPage.routeName: (ctx) => const SettingsPage(),
                HomePage.routeName: (ctx) => const HomePage(),
                Profile.routeName: (ctx) => const Profile(),
                LeaderBoardPage.routeName: (ctx) => const LeaderBoardPage(),
                RulesPage.routeName: (ctx) => const RulesPage(),
                ChangePasswordPage.routeName: (ctx) =>
                    const ChangePasswordPage(),
              },
            );
          },
        )
      ],
    );
  }
}*/



/*
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => MatchProvider()),
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => RulesProvider()),
          ChangeNotifierProvider(create: (ctx) => PredictionProvider()),
          ChangeNotifierProvider(create: (ctx) => PlayersProvider()),
          ChangeNotifierProvider(create: (ctx) => TotalPointsProvider()),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: Messenger.instance.scaffoldState,
          theme: MyTheme.darkTheme,
          darkTheme: MyTheme.darkTheme,
          themeMode: ThemeManager.instance.themeMode,
          title: 'Flutter Demo',
          home: const TapsPage(),
          routes: {
            LoginPage.routeName: (ctx) => const LoginPage(),
            SettingsPage.routeName: (ctx) => const SettingsPage(),
            HomePage.routeName: (ctx) => const HomePage(),
            Profile.routeName: (ctx) => const Profile(),
            LeaderBoardPage.routeName: (ctx) => const LeaderBoardPage(),
            RulesPage.routeName: (ctx) => const RulesPage(),
            ChangePasswordPage.routeName: (ctx) => const ChangePasswordPage(),
          },
        ));
  }
  */