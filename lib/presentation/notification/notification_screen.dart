import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/models/get_notifications_model.dart';
import 'package:focus_mate/data/repo/get_notifications_repo.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetNotificationsRepo repo = GetNotificationsRepo();

    return Scaffold(
      body: FutureBuilder<List<GetNotificationsModel>?>(
        future: repo.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications found"));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              int converted = int.parse(item.percentage ?? "0");

              return Card(
                  elevation: 1,
                  color: AppColors.kSecondryColor,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 30,
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Text(
                                    item.title!,
                                    style: TextTheme.of(context).bodyLarge,
                                  ),
                                ),
                                Text(
                                  item.percentage ?? '100',
                                  style: TextTheme.of(context).bodyLarge,
                                ),
                              ],
                            ),
                            AppSize.commonHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.content ?? "",
                                    style: TextTheme.of(context).bodyMedium,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                converted == 0
                                    ? SizedBox()
                                    : LinearPercentIndicator(
                                        width: 140.0,
                                        lineHeight: 14.0,
                                        percent: converted / 100,
                                        backgroundColor: Colors.grey,
                                        progressColor: Colors.blue,
                                      )
                              ],
                            ),
                            AppSize.commonHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(item.startTime ?? ""),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(item.endTime ?? "")
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}
