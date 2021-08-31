enum DashboardWidgetType {
  COMMIT_BY_DAY,
  BUILD
}

extension DashboardWidgetTypeExtension on DashboardWidgetType {
  String get name {
    switch (this) {
      case DashboardWidgetType.COMMIT_BY_DAY:
        return 'COMMIT BY DAY';
      case DashboardWidgetType.BUILD:
        return 'BUILD';
    }
  }

  String get value {
    switch (this) {
      case DashboardWidgetType.COMMIT_BY_DAY:
        return 'COMMIT_BY_DAY';
      case DashboardWidgetType.BUILD:
        return 'BUILD';
    }
  }
}
