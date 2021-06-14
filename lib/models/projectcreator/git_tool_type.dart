enum GitToolType { GITLAB, GITHUB }

extension GitToolTypeExtension on GitToolType {
  String get name {
    switch (this) {
      case GitToolType.GITLAB:
        return 'GITLAB';
      case GitToolType.GITHUB:
        return 'GITHUB';
    }
  }
}
