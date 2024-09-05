


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  final int gridSize;

  const GameScreen({super.key, required this.gridSize});
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> gridNumbers = [];
  Timer? _timer;
  int timeRemaining = 120;

  @override
  void initState() {
    super.initState();
    initializeGrid();
    startTimer();
  }

  // Инициализация сетки значениями 1
  void initializeGrid() {
    gridNumbers = List.generate(
      widget.gridSize,
          (i) => List.generate(widget.gridSize, (j) => 1),
    );
  }

  // Таймер для отсчета времени
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        timer.cancel(); // Остановка таймера по истечению времени
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Обработка клика по кликабельной плитке
  void onTileClicked(int i, int j) {
    setState(() {
      gridNumbers[i][j] = gridNumbers[i][j] ==
          5 ? 1 : gridNumbers[i][j] + 1;
    });
  }

  // Перезапуск уровня
  void restartGame() {
    setState(() {
      initializeGrid();
      timeRemaining = 120; // Время для перезапуска
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child:
            Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/top.png',fit: BoxFit.fitWidth,),
          Expanded(
            child: GridView.builder(

              padding: const EdgeInsets.symmetric(horizontal: 30,
                  vertical: 10),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridSize,

                  mainAxisSpacing: 10,

                  crossAxisSpacing:10



              ),
              itemCount: widget.gridSize *  widget.gridSize,
              itemBuilder: (context, index) {
                int i = index ~/ widget.gridSize;
                int j = index % widget.gridSize;


                if (i == 0 || j == 0) {
                  if(i==0 && j ==0 ){
                    return SizedBox.shrink();
                  }
                  else{
                    return Image.asset('assets/none.png',
                      fit: BoxFit.fill,);
                  }
                }

                return GestureDetector(
                  onTap: () {
                    if (gridNumbers[i][j] != 0) {
                      onTileClicked(i, j);
                    }
                  },
                  child: Container(
                    width:10,
                    height:10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,

                          image:
                          gridNumbers[i][j]==1 ?
                          AssetImage('assets/1.png') :
                          gridNumbers[i][j]==2? AssetImage(
                              'assets/2.png') :
                          gridNumbers[i][j]==3?AssetImage(
                              'assets/3.png') :
                          gridNumbers[i][j]==4?AssetImage(
                              'assets/4.png') :
                          AssetImage(

                            'assets/5.png',

                          )
                      ),



                    ),
                  ),
                );
              },
            ),
          ),
          // Таймер и кнопка Restart
          Stack(
            children: [
              Image.asset('assets/bot.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,
                    vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO( 204, 98, 12, 1)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('timer:',
                                  style: GoogleFonts.share(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Color
                                          .fromRGBO(255, 255, 255, 0.6)
                                  ),),
                              ),
                              Expanded(
                                child: Text(
                                  ' ${(timeRemaining ~/ 60)
                                      .toString().padLeft(2, '0')}:'
                                      '${(timeRemaining % 60).toString()
                                      .padLeft(2, '0')}',
                                  style: GoogleFonts.share(fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                        onTap: (){
                          restartGame();
                        },
                        child: Image.asset('assets/restart.png'))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}