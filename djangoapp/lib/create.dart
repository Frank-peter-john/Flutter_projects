import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Create note"),
          ),
        ],
      ),
    );
  }
}
