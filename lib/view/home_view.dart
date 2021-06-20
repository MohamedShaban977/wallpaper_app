import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Wallpaper Flutter',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
