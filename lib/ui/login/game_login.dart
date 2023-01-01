class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlenth = 9; // 3*3 bloklardan oluşan bir tahta oluşturacağız;
  static final blocSize = 100.0;

  //Boş bir tahta oluşturma
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardlenth, (index) => Player.empty);

  //şimdi kazanan çek algoritmasını oluşturmamız gerekiyor
  //bunun için öncelikle ana dosyamızda bir skorbordd tanımlamamız gerekiyor
  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    //önce satır ve sütunu tanımlayalım
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //Skorbordda 3 mü yoksa -3 mü oludğunu konrtol ediyoruz
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    ;

    //Varsayılan olarak false döndürür
    return false;
  }
}