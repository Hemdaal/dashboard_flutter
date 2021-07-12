import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';

import 'ui/pages/createProject/create_project_page.dart';
import 'ui/pages/login/login_page.dart';
import 'ui/pages/projectDashboard/project_dashboard_page.dart';
import 'ui/pages/projects/projects_page.dart';
import 'ui/pages/signup/signup_page.dart';
import 'ui/pages/splash/splash_page.dart';

class AppRouter {
  static Widget route(String path) {

    if (path == CreateProjectPage.route) {
      return CreateProjectPage();
    } else if (path == ProjectsPage.route) {
      return ProjectsPage();
    } else if (ProjectDashboardPage.isMatchingPath(path)) {
      final projectId = ProjectDashboardPage.parseProjectId(path);
      if (projectId != null) {
        return ProjectDashboardPage(projectId);
      }
    } else if (path == LoginPage.route) {
      return LoginPage();
    } else if (path == SignupPage.route) {
      return SignupPage();
    } else if (path == SplashPage.route) {
      return SplashPage();
    }
    return SplashPage();
  }
}
