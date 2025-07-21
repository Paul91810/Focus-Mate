class SentNotificationsModel {
  int? userId;
  String? title;
  String? content;
  int? percentage;
  String? startTime;
  String? endTime;

  SentNotificationsModel(
      {this.userId,
      this.title,
      this.content,
      this.percentage,
      this.startTime,
      this.endTime});

  SentNotificationsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    title = json['title'];
    content = json['content'];
    percentage = json['percentage'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['percentage'] = this.percentage;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
