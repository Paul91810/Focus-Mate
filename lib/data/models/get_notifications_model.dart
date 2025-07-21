class GetNotificationsModel {
  String? content;
  String? endTime;
  int? id;
  String? percentage;
  String? startTime;
  String? title;

  GetNotificationsModel(
      {this.content,
      this.endTime,
      this.id,
      this.percentage,
      this.startTime,
      this.title});

  GetNotificationsModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    endTime = json['end_time'];
    id = json['id'];
    percentage = json['percentage'];
    startTime = json['start_time'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['end_time'] = this.endTime;
    data['id'] = this.id;
    data['percentage'] = this.percentage;
    data['start_time'] = this.startTime;
    data['title'] = this.title;
    return data;
  }
}
