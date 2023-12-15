import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> disapleX = ['', '', '', '', '', '', '', '', ''];
  bool isSelected=true;
  int FilledBox=0;
  int ScoreX=0;
  int ScoreO=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          // color: Colors.grey,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.blue,
              ]),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player X",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ScoreX.toString(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player O",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ScoreO.toString(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Tap(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              disapleX[index],
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 40,
                                color: disapleX[index] == 'X'?Colors.red: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
  void Tap(int index){
    setState(() {
     if(isSelected && disapleX[index] == ""){
       FilledBox+=1;
       disapleX[index] = 'X';
     }if(!isSelected && disapleX[index] == ""){
       FilledBox+=1;
       disapleX[index] ='O';
     }
     isSelected=!isSelected;
     Check();
    });
  }

  void Check(){

    //row1
    if(disapleX[0]!="" &&disapleX[0] == disapleX[1] && disapleX[0] == disapleX[2] ){
      _ShowDialog(disapleX[0]);
    }
    //row2
    if(disapleX[3]!="" &&disapleX[3] == disapleX[4] && disapleX[3] == disapleX[5] ){
      _ShowDialog(disapleX[3]);
    }
    //row3
    if(disapleX[6]!="" &&disapleX[6] == disapleX[7] && disapleX[6] == disapleX[8] ){
      _ShowDialog(disapleX[6]);
    }

    //column1
    if(disapleX[0]!="" &&disapleX[0] == disapleX[3] && disapleX[0] == disapleX[6] ){
      _ShowDialog(disapleX[0]);
    }

    //column2

    if(disapleX[1]!="" &&disapleX[1] == disapleX[4] && disapleX[1] == disapleX[7] ){
      _ShowDialog(disapleX[1]);
    }

    //column3

    if(disapleX[2]!="" &&disapleX[2] == disapleX[5] && disapleX[2] == disapleX[8] ){
      _ShowDialog(disapleX[2]);
    }

    // x1

    if(disapleX[0]!="" &&disapleX[0] == disapleX[4] && disapleX[0] == disapleX[8] ){
      _ShowDialog( disapleX[0]);
    }


    //x2

    if(disapleX[2]!="" &&disapleX[2] == disapleX[4] && disapleX[2] == disapleX[6] ){
      _ShowDialog(disapleX[2]);
    }else if(FilledBox == 9 ){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Center(child: Text(' NoBodyWin '),),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              clearBoard();
            }, child: Text('PLay Again'),),
          ],
        );
      });
    }
  }

  void _ShowDialog(String winner){
    if(winner == "X"){
      ScoreX+=1;
    }if(winner=="O"){
      ScoreO+=1;
    }if( ScoreX >= 6){
      ScoreX=0;
      ScoreO=0;
    }if(ScoreO>=6){
      ScoreO=0;
      ScoreX=0;
    }
   showDialog(context: context, builder: (context){
     return AlertDialog(
       title: Center(child: Text('Winner: '+ winner),),
       actions: [
         ElevatedButton(onPressed: (){
           Navigator.pop(context);
           clearBoard();
         }, child: Text('Play Again'))
       ],
     );
   }

   );
  }
  void clearBoard(){
    for(int i =0;i<9;i++){
      setState(() {
        disapleX[i]='';
        FilledBox=0;
      });
    }
  }
}
