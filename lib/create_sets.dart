
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


class CreateSets extends StatefulWidget {
  @override
  _CreateSetsState createState() => _CreateSetsState();
}

class _CreateSetsState extends State<CreateSets> with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _vietnameseNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _englishNameController.dispose();
    _vietnameseNameController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    String title = _titleController.text;
    String englishName = _englishNameController.text;
    String vietnameseName = _vietnameseNameController.text;

    if (title.isEmpty || englishName.isEmpty || vietnameseName.isEmpty) {
      // Hiển thị thông báo lỗi nếu người dùng không nhập đủ thông tin
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }


    DatabaseReference ref = FirebaseDatabase.instance.ref('sets/$title');
    try {
      await ref.set({
        'English Name': englishName,
        'Tên tiếng Việt': vietnameseName,
      });
      print('Dữ liệu đã được lưu thành công.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã lưu dữ liệu thành công')),
      );
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (error) {
      print('Có lỗi xảy ra khi lưu dữ liệu: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra khi lưu dữ liệu')),
      );
    }
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
            _buildCard()
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext contex){
    return AppBar(
      title: const Text('Create Sets'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.settings_outlined),
        onPressed: () {
          // Hành động khi nhấn vào biểu tượng cài đặt
        },
      ),
      actions: [
        TextButton(
          onPressed: _saveData ,
          child: const Text(
            'Done',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _englishNameController,
              decoration: InputDecoration(
                labelText: 'English Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _vietnameseNameController,
              decoration: InputDecoration(
                labelText: 'Tên tiếng Việt',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}