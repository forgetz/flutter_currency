import 'package:flutter/material.dart';

typedef onSaveCallBack = Function(int currentPageIndex);

class RowButtons extends StatefulWidget {
  final onSaveCallBack onSave;
  final int activePageIndex;

  RowButtons({this.onSave, this.activePageIndex});

  @override
  _RowButtonsState createState() => _RowButtonsState();
}

class _RowButtonsState extends State<RowButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Container(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onSave(0);
                },
                child: singleButtonWidget('Converter',
                    activeColor: widget.activePageIndex == 0
                        ? Colors.black
                        : Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  widget.onSave(1);
                },
                child: singleButtonWidget('Rates',
                    activeColor: widget.activePageIndex == 1
                        ? Colors.black
                        : Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  widget.onSave(2);
                },
                child: singleButtonWidget('Info',
                    activeColor: widget.activePageIndex == 2
                        ? Colors.black
                        : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget singleButtonWidget(String text, {Color activeColor = Colors.white}) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16.0, color: activeColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
