import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Future<int> _getUserCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      return snapshot.size;
    } catch (e) {
      print('Error fetching user count: $e');
      return -1;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,

          children: [
            _buildCard1(),
            _buildCard2(),
            _buildCard3(),
            _buildCard4(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard1() {
    return Card(
      color: Colors.grey[500],
      child: FutureBuilder<int>(
        future: _getUserCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Users: ${snapshot.data}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard2() {
    return Card(
      color: Colors.grey[300],
      child: const Center(
        child: Text(
          'Card 2 Content',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildCard3() {
    return Card(
      color: Colors.grey[300],
      child: const Center(
        child: Text(
          'Card 3 Content',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildCard4() {
    return Card(
      color: Colors.grey[300],
      child: const Center(
        child: Text(
          'Card 4 Content',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
