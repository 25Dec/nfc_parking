part of 'app_route_config.dart';

class AppRouteConfig {
  final BuildContext context;
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  AppRouteConfig(this.context);

  GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppPage.signIn.toPath,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ShellPage(child: child);
        },
        routes: [
          GoRoute(
            path: AppPage.nfcCardsShell.toPath,
            name: AppPage.nfcCardsShell.toName,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const MaterialPage(
              child: NfcCardsShellPage(),
            ),
          ),
          GoRoute(
            path: AppPage.parkingHistoryShell.toPath,
            name: AppPage.parkingHistoryShell.toName,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const MaterialPage(
              child: ParkingHistoryShellPage(),
            ),
          ),
          GoRoute(
            path: AppPage.staff.toPath,
            name: AppPage.staff.toName,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const MaterialPage(
              child: StaffPage(),
            ),
          ),
          GoRoute(
            path: AppPage.settings.toPath,
            name: AppPage.settings.toName,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const MaterialPage(
              child: SettingsPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppPage.signIn.toPath,
        name: AppPage.signIn.toName,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignIn(),
        ),
      ),
      GoRoute(
        path: AppPage.scanNfc.toPath,
        name: AppPage.scanNfc.toName,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => const MaterialPage(
          child: ScanNfcPage(),
        ),
      ),
      GoRoute(
        path: AppPage.scanLicensePlate.toPath,
        name: AppPage.scanLicensePlate.toName,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ScanLicensePlatePage(),
          );
        },
      ),
      GoRoute(
        path: AppPage.detailInfoLicensePlate.toPath,
        name: AppPage.detailInfoLicensePlate.toName,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: DetailInfoLicensePlatePage(),
          );
        },
      ),
      GoRoute(
        path: AppPage.signUpStaffAccount.toPath,
        name: AppPage.signUpStaffAccount.toName,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignUpStaffAccountPage(),
          );
        },
      ),
    ],
  );
}
