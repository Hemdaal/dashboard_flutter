class CodeManagement {
  final id;
  final repoUrl;
  final token;
  final type;

  CodeManagement(this.id, this.repoUrl, this.token, this.type);

  CodeManagement.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        repoUrl = json['repoUrl'],
        token = json['token'],
        type = json['type'];
}
