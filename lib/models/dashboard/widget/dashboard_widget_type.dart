enum DashboardWidgetType {
  COMMIT,
  BUILD
}

extension DashboardWidgetTypeExtension on DashboardWidgetType {
  String get name {
    switch (this) {
      case DashboardWidgetType.COMMIT:
        return 'COMMIT';
      case DashboardWidgetType.BUILD:
        return 'BUILD';
    }
  }
}
