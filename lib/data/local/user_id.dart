
import 'package:focus_mate/data/local/hive_boxs.dart';
import 'package:focus_mate/data/local/hive_keys.dart';

class UserId {
   static Future<void> storeUserId(int value) async {
    await AppHiveBox.userBox.put(HiveKeys.userId, value);
  }

  static Future<void> deleteUserId() async {
    await AppHiveBox.userBox.delete(HiveKeys.userId);
  }
  static Future<dynamic>getUserId()async{
    return await AppHiveBox.userBox.get(HiveKeys.userId, defaultValue:null);
}
}