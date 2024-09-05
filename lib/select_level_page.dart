
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                  CupertinoPageRoute(builder:
                      (context)=>GameScreen(
                        gridSize: 4,
                      )));
            }, child: Text('Level 1')),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                  CupertinoPageRoute(builder:
                      (context)=>GameScreen(
                    gridSize: 5,
                  )));
            }, child: Text('Level 2')),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                  CupertinoPageRoute(builder:
                      (context)=>GameScreen(
                    gridSize: 6,
                  )));
            }, child: Text('Level 3')),

          ],
        ),
      ),
    );
  }
}
