import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_game/home_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}
final play = AudioPlayer();

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  int player1Score = 0;
  int player2Score = 0;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _winner = "";
    _currentPlayer = "X";
    _gameOver = false;
  }

  //reset
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ""));
      _winner = "";
      _currentPlayer = "X";
      _gameOver = false;
      
    });
  }


   

  void _makeMove(int row, int col) {
    play.play(AssetSource('pop-94319.mp3'));
    
    if (_board[row][col] != "" || _gameOver) {
      

      return;
      
    }

    setState(() {
      _board[row][col] = _currentPlayer;
      play.play(AssetSource('pop-94319.mp3'));

      //check winner
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
        if (_winner == "X") {
         player1Score++;
        } else {
           player2Score++;
        }
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
        if (_winner == "X") {
         player1Score++;
        } else {
           player2Score++;
        }
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
        if (_winner == "X") {
          play.play(AssetSource('1.mp3'));
         player1Score++;
        } else {
           player2Score++;
        }
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
        if (_winner == "X") {
         player1Score++;
        } else {
           player2Score++;
        }
      }

      //swith player
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      

      //check for tie
      if (!_board.any((row) => row.any((cell) => cell == ""))) {
        
        _gameOver = true;
        _winner = "It's a Tie";
        
        
        
        
      }

      // Show dialog if there's a winner
      if (_winner != "") {
        
        AwesomeDialog(
         
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again",
          
          title: _winner == "X"
          
              ? widget.player1  + "Won!"
              : _winner == "O"
                  ? widget.player2 +"Won!"
                  : "It's a Tie",
          btnOkOnPress: () {
            _resetGame();
           
          },
        )..show();
         
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 176, 49),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _currentPlayer == "X"
                            ? Color.fromARGB(255, 46, 255, 49)
                            : const Color(0xff332167)),
                    color: const Color(0xff332167),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 50.0, 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/man.png',
                          width: 40,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPlayer == "" ? widget.player2 : widget.player1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/x.png',
                          width: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.075,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: _currentPlayer == "O"
                            ? const Color(0xfffed031)
                            : const Color(0xff332167)),
                    color: const Color(0xff332167),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/woman.png',
                          width: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _currentPlayer == "" ? widget.player1 : widget.player2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/o.png',
                          width: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Row(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                          "Score",
                          style: TextStyle(color: Colors.white),
                                               ),
                       ),
                      Text(
                        player1Score.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                        width: 200,
                      ),
                   Row(
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                          "Score",
                          style: TextStyle(color: Colors.white),
                                               ),
                       ),
                      Text(
                        player2Score.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2),
          SizedBox(height: 2),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 214, 128),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(5),
            child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  
                  return GestureDetector(
                    
                    onTap: () => _makeMove(row, col),
                    
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF0E1E3A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          
                          // Adjust the value as needed
                          child: Text(
                            _board[row][col],
                            style: TextStyle(
                              fontSize: 95,
                              fontWeight: FontWeight.bold,
                              color: _board[row][col] == "X"
                                  ? Color(0xFFE25041)
                                  : Color(0xfffed031),
                                  
                                  
                                  
                                  
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: _resetGame,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    "Reset Game",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                  widget.player1 = "";
                  widget.player2 = "";
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    "Restart Game",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
