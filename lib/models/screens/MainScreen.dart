import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/screens/MoviesList.dart';

import 'UserInfo.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MoviesList(),
    );
  }
}
