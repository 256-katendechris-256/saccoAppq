
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Pages/add_members.dart';
import 'Pages/add_sacco.dart';
import 'Pages/dashboard.dart';
import 'Pages/items.dart';

import 'Pages/questions.darts.dart';
import 'Pages/survey.dart';

// Define the enum for SideBarItem
enum SideBarItem {
  dashboard(
      value: 'Dashboard', iconData: Icons.dashboard, body: DashboardScreen()),
  sacco_list(value: 'Sacco list', iconData: Icons.business, body: SaccolistPage()),
  member_list(value: 'Member List', iconData: Icons.card_membership_rounded, body: MemberPage()),
  survey(value: 'Survey', iconData: Icons.campaign, body: SurveyListPage ()),
  apply(value: 'apply4loan', iconData: Icons.campaign, body: QuestionnairePage()),
 ;



   const SideBarItem(
      {required this.value, required this.iconData, required this.body});
  final String value;
  final IconData iconData;
  final Widget body;
}

// Define a provider for the selected SideBarItem
final sideBarItemProvider = StateProvider<SideBarItem>((ref) => SideBarItem.dashboard);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // Function to get the SideBarItem from AdminMenuItem
  SideBarItem getSideBarItem(AdminMenuItem item) {
    for (var value in SideBarItem.values) {
      if (item.route == value.name) {
        return value;
      }
    }
    return SideBarItem.dashboard;
  }

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final sideBarItem = ref.watch(sideBarItemProvider);
    final sideBarKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: sideBarKey,
      appBar: AppBar(title: const Text('welcome to Kambascco Dashboard')),
      drawer: SideBar(
        activeBackgroundColor: Colors.white,
        onSelected: (item) {
          ref.read(sideBarItemProvider.notifier).update((state) => getSideBarItem(item));
          sideBarKey.currentState?.openEndDrawer(); // Close the drawer
        },
        items: SideBarItem.values
            .map((e) => AdminMenuItem(
            title: e.value, icon: e.iconData, route: e.name))
            .toList(),
        selectedRoute: sideBarItem.name,
      ),
      body: ProviderScope(
        overrides:  [],
        child: sideBarItem.body,


      ),
    );
  }
}
