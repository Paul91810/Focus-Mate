import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 0)
class GetProfile {
   @HiveField(0)
  String? email;
   @HiveField(1)
  String? imageUrl;
   @HiveField(2)
  String? name;
  int? userId;

  GetProfile({this.email, this.imageUrl, this.name, this.userId});

  GetProfile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    imageUrl = json['image_url'];
    name = json['name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    return data;
  }
}
