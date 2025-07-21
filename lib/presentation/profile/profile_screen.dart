import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/core/constants/app_size.dart';
import 'package:focus_mate/data/models/profile_model.dart';
import 'package:focus_mate/data/repo/profile_repo.dart';
import 'package:focus_mate/presentation/profile/bloc/profile_bloc.dart';

class ProfileAndStatusScreen extends StatelessWidget {
  const ProfileAndStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(GetProfileRepo())..add(LoadProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          } else if (state is ProfileLoaded) {
            return _buildProfileUI(context, state.profile, isCached: state.isCached);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileUI(BuildContext context, GetProfile profile, {bool isCached = false}) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      children: [
        if (isCached)
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Showing cached profile data (offline or timeout fallback)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange),
            ),
          ),
        AppSize.commonHeight,
        const CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.kWhite,
          child: FlutterLogo(),
        ),
        Column(
          children: [
            AppSize.commonHeight,
            Text(
              profile.name?.toUpperCase() ?? 'No Name',
              style: TextTheme.of(context).bodyLarge,
            ),
            AppSize.commonHeight,
            Text(
              profile.email ?? "No Email",
              style: const TextStyle(color: Colors.grey),
            ),
            AppSize.commonHeight,
          ],
        ),
        _buildStatusCard(context),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kSecondryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          _infoRow(Icons.local_fire_department, 'Streak', '7 days', context),
          Divider(color: Colors.grey.shade600),
          _infoRow(Icons.bar_chart, 'Habits', '2 / week', context),
          Divider(color: Colors.grey.shade600),
          AppSize.commonHeight,
          Text('Productivity Badges', style: TextTheme.of(context).bodyLarge),
          AppSize.commonHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _BadgeItem(icon: Icons.check_circle, label: 'Task Master', color: Colors.green),
              _BadgeItem(icon: Icons.star, label: 'Focused', color: Colors.blue),
              _BadgeItem(icon: Icons.calendar_today, label: 'Consistency', color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value, BuildContext context) {
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

  const _BadgeItem({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
         
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextTheme.of(context).bodyMedium),
      ],
    );
  }
}
