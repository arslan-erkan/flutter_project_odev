


import 'package:flutter/material.dart';
import 'package:erkan/ui/color.dart';
import 'package:erkan/ui/login/game_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //gerekli değişkenleri ekliyoruz
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //Skor oyunun farkı kombinasyonalrı içindir[Sıra 1,2,3,Sütun 1,2,3 , Diagonal 1,2]
  //Yeni bir oyun bileşenleri ilan edelim

  Game game = Game();

  //let's initi the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sıra  ${lastValue} oyuncusunda ".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Şimdi oyun tahtasını yapacağız
            //Ancak önce ihtiyazımız olacak tüm verileri ve yönetemi içeren bir Game sınıfı oluşturacağız
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/
                    3, // ~ operatörü,tamsayıyı kanıtlamanıza ve sonuç olarak bir int döndürmenize izin verir
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                      //tıkladığımızda yeni değeri panoya eklememiz ve ekranı yenilememiz gerekiyor
                      //oynatıcıyı da değiştirmemiz gerekiyor
                      //şimdi tıklamayı yalnızca alan boşsa uygulamamız gerekiyor
                      //şimdi oyunu tekrarlamak için bir buton oluşturalım

                      if (game.board![index] == "") {
                        setState(() {
                          game.board![index] = lastValue;
                          turn++;
                          gameOver = game.winnerCheck(
                              lastValue, index, scoreboard, 3);

                          if (gameOver) {
                            result = "$lastValue Kazandı";
                          } else if (!gameOver && turn == 9) {
                            result = "Berabere";
                            gameOver = true;
                          }
                          if (lastValue == "X")
                            lastValue = "O";
                          else
                            lastValue = "X";
                        });
                      }
                    },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.pink
                                : Colors.purple,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 54.0),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  //erase the board
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              label: Text("Oyunu tekrar başlat"),
            ),
          ],
        ));
    //ilk adım ,proje klasör yapınızı organize etmektedir.
  }
}

