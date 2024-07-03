import 'package:flutter/material.dart';
import 'package:sacco/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    final List<Map<String, dynamic>> items = [
      {'title': 'SACCO List', 'icon': Icons.list},
      {'title': 'Member List', 'icon': Icons.people},
      {'title': 'Survey List', 'icon': Icons.book},
      {'title': 'Item List', 'icon': Icons.inventory},
      {'title': 'Tasks List', 'icon': Icons.task},
      {'title': 'Team List', 'icon': Icons.group},
      {'title': 'Segment List', 'icon': Icons.segment},
      {'title': 'Contacts', 'icon': Icons.contact_page},
      {'title': 'Customers', 'icon': Icons.person},
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    // Handle card tap
                  },
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          items[index]['icon'],
                          size: 50,
                        ),
                        SizedBox(height: 10),
                        Text(
                          items[index]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
