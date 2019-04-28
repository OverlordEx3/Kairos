import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

/* Other services */
import 'GroupDataService.dart' show GroupDataService;
import 'SessionService.dart' show SessionService;
import 'AuthService.dart' show AuthState, AuthService;

/* Model */
import '../models/GroupModel.dart';
import '../models/sessionModel.dart';

class AppServices {
  final SharedPreferences appPrefs;
  final GroupDataService groupService;
  final SessionService sessionService;
  final AuthService authService;

  AppServices(
      {this.appPrefs,
      this.groupService,
      this.sessionService,
      this.authService});

  Future<AppServices> initialize() async {
    final appPrefs = await SharedPreferences.getInstance();
    final authService = await AuthService.initialize();

    /* TODO remove this mock */
    final groupService = GroupDataService(Group("Default", 1));
    final sessionService =
        SessionService(Session('Exequiel', 'Beker', groupService.groupID, [0]));

    return AppServices(
        appPrefs: appPrefs,
        authService: authService,
        groupService: groupService,
        sessionService: sessionService);
  }

  static AppServices of(BuildContext context) {
    final provider = context
        .ancestorInheritedElementForWidgetOfExactType(AppServices)
        .widget as AppServicesProvider;
    return provider.services;
  }
}

class AppServicesProvider extends InheritedWidget {
  final AppServices services;

  AppServicesProvider(Key key, this.services, Widget child)
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
