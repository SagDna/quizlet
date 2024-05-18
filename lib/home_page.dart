import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'create_sets.dart';
import 'flash_card.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> logout(BuildContext context) async {
    //logout logic
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStudySetsTab(), // Tab 1
                  Center(child: Text('Classes')), // Tab 2
                  Center(child: Text('Folders')), // Tab 3
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Library'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateSets()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Study sets'),
        Tab(text: 'Classes'),
        Tab(text: 'Folders'),
      ],
    );
  }

  Widget _buildStudySetsTab() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('sets');
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData) {
          Map<dynamic, dynamic> sets =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<Widget> setCards = sets.keys.map((key) {
            return _buildSetCard(
                key, sets[key]['English Name'], sets[key]['Tên tiếng Việt']);
          }).toList();
          return ListView(
            children: setCards,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Có lỗi xảy ra khi lấy dữ liệu.'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildSetCard(String title, String englishName, String vietnameseName) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: FlashCard(
                  title: title,
                  englishName: englishName,
                  vietnameseName: vietnameseName,
              ),
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.all(20.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

