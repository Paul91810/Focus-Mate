import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_mate/core/constants/app_colors.dart';
import 'package:focus_mate/presentation/widgets/bottom_nav/bloc/bottom_nav_bloc.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) => BottomNavigationBar(
        currentIndex: state.currentIndex,
        onTap: (index) =>
            context.read<BottomNavBloc>().add(BottomItamTaped(index)),

        backgroundColor: AppColors.kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedFontSize: 15,
        unselectedFontSize: 12,

        selectedIconTheme: const IconThemeData(color: Colors.white, size: 25),
        unselectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 218, 210, 210),
          size: 20,
        ),
        type: BottomNavigationBarType.fixed,
        items: _bottomNavItems,
      ),
    );
  }

  final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: const Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(
      icon: const Icon(Icons.notifications),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Profile'),
  ];
}
