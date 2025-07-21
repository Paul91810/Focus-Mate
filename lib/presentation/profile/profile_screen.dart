import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';

class ProfileAndStatusScreen extends StatelessWidget {
  const ProfileAndStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
      children: [
        AppSize.commonHeight,
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.kWhite,
          child: FlutterLogo(),
          // backgroundImage: AssetImage('assets/images/profile_pic.png'),
        ),
        Column(
          children: [
            AppSize.commonHeight,
            Text('Jane Doe', style: TextTheme.of(context).bodyLarge),
            AppSize.commonHeight,
            const Text(
              'jane.doe@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            AppSize.commonHeight,
          ],
        ),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            
            color: AppColors.kSecondryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: [
              _infoRow( Icons.local_fire_department, 'Streak', '7 days',context),
               Divider(color: Colors.grey.shade600,),
              _infoRow(Icons.bar_chart, 'Habits', '2 / week',context),
               Divider(color: Colors.grey.shade600,),
              AppSize.commonHeight,
               Text(
                'Productivity Badges',
                style: TextTheme.of(context).bodyLarge,
              ),
              AppSize.commonHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _BadgeItem(
                    icon: Icons.check_circle,
                    label: 'Task Master',
                    color: Colors.green,
                  ),
                  _BadgeItem(
                    icon: Icons.star,
                    label: 'Focused',
                    color: Colors.blue,
                  ),
                  _BadgeItem(
                    icon: Icons.calendar_today,
                    label: 'Consistency',
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String title, String value ,BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: TextTheme.of(context).bodyLarge),
      trailing: Text(value, style: TextTheme.of(context).bodyLarge),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _BadgeItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextTheme.of(context).bodyMedium),
      ],
    );
  }
}
