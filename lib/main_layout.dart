import 'package:sacco/screens/appointment_page.dart';
import 'package:sacco/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sacco/screens/profile.dart';
import 'package:sacco/utils/config.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back icon
        backgroundColor:
            Config.primsryColor, // Same color as the BottomNavigationBar
        title: Row(
          children: [
            Image.asset(
              'assets/kamba.png', // Replace with your logo asset path
              height: 45,
              // Increased size to match the AppBar text
            ),
            SizedBox(width: 10),
            Text(
              'KambaSacco',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ), // Ensure the text size matches the image
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _page,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: const <Widget>[
          HomePage(),
          AppointmentPage(),
          Profilr(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration:
                  const Duration(milliseconds: 500), // Changed to milliseconds
              curve: Curves.easeInOut,
            );
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarWeek),
            label: 'This Month',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userCircle),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            label: 'search',
          ),
        ],
      ),
    );
  }
}
