
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';



class GoRouteConfig {
  static GoRouter routerConfig = GoRouter(
    initialLocation:'/login',

    routes: [

      GoRoute(
        path: "/login",
        name: "login",
        pageBuilder: (context, state) {
          return customTransitionPage(state: state, page:  Container());
        },
      ),

      GoRoute(
        path: "/signUp",
        name: "signUp",
        pageBuilder: (context, state) {
          return customTransitionPage(state: state, page:  Container());
        },
      )
    ],
  );

  static String onBoard = "onBoard";
  static String signUp = "signUp";
  static String login = "login";
  static String forgotPassword = "forgotPassword";
  static String homeScreen = "homeScreen";
  static String dashBoard = "dashBoard";
  static String addIncome = "addIncome";
  static String addExpense ="addExpense";

/*Page Route Animation*/

  static CustomTransitionPage<dynamic> customTransitionPage(
      {required GoRouterState state, required Widget page}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
