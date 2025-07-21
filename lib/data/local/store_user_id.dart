
import 'package:focus_mate/data/local/hive_boxs.dart';
import 'package:focus_mate/data/local/hive_keys.dart';

class StoreUserId {
   static Future<void> storeUserId(int value) async {
    await HiveBoxs.userBox.put(HiveKeys.userId, value);
  }

  static Future<void> deleteUserId() async {
    await HiveBoxs.userBox.delete(HiveKeys.userId);
  }
  static Future<dynamic>getUserId()async{
    return await HiveBoxs.userBox.get(HiveKeys.userId, defaultValue:null);
}
}