import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';


class FlashCard extends StatefulWidget {
  final String title;
  final String englishName;
  final String vietnameseName;

  FlashCard({
    required this.title,
    required this.englishName,
    required this.vietnameseName,
  });

  @override
  _FlashCardState createState() => _FlashCardState();
}



class _FlashCardState extends State<FlashCard> {
  //final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make it the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: _buildFrontCard(),
      back: _buildBackCard(),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(minHeight: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.vietnameseName,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              //_speak(widget.vietnameseName);
            },
          ),
        ],
      ),
    );
  }


  Widget _buildBackCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(minHeight: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.englishName,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              //_speak(widget.vietnameseName);
            },
          ),
        ],
      ),
    );
  }

  // Future<void> _speak(String text) async {
  //   await flutterTts.setSpeechRate(1.0);
  //   await flutterTts.setVolume(10.0);
  //   await flutterTts.setPitch(1.0);
  //   await flutterTts.speak(text);
  //   await flutterTts.areLanguagesInstalled(["vi-VN", "en-US"]);
  //   await flutterTts.speak(text);
  // }

}
