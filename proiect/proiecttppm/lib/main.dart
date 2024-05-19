import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

void main() {
  TorchController().initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';
  final torchController = TorchController();
  Map<String, String> morseCodeMap = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    ', ': '--..--',
    '.': '.-.-.-',
    '?': '..--..',
    '/': '-..-.',
    '-': '-....-',
    '(': '-.--.',
    ')': '-.--.-'
  };

  void onButtonPressed() {
    String code=morseCode(_controller.text);

    flashlight(code);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("Morse Code App")), body: GetBody()));
  }

  Widget GetBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter text here"),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onButtonPressed,
            child: const Text("Submit"),
          ),
          const SizedBox(height: 20),
          Text(_displayText, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  String morseCode(String text) {
    String result = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] == ' ') {
        result += '#'; //intre cuvinte se pune #
      } else {
        result += morseCodeMap[text[i].toUpperCase()]!;
        result += ' '; //intre litere se pune spatiu
      }
    }
    return result;
    // setState(() {
    //   _displayText = result;
    // });
  }
  void flashlight(String text) async{
    int i=0;
    int j=0;
    String letter='';
    bool isOn= await torchController.toggle() as bool;
    while(i<text.length){
      setState(() {
        letter+=text[i];
      _displayText = '${_controller.text[j]}:$letter';
    });
      if(text[i]=='.'){
        if(isOn==false){
          await torchController.toggle();
          isOn=true;
        }
        await Future.delayed(Duration(seconds: 1));
        await torchController.toggle();
        await Future.delayed(Duration(seconds: 1));
        isOn=false;
      }
      else if(text[i]=='-'){
        if(isOn==false){
          await torchController.toggle();
          isOn=true;
        }
        await Future.delayed(Duration(seconds: 3));
        await torchController.toggle();
        await Future.delayed(Duration(seconds: 1));
        isOn=false;
      }
      else if(text[i]=='#'){
        if(isOn==true){
          await torchController.toggle();
          isOn=false;
        }
        await Future.delayed(Duration(seconds: 4));
      }
      else if(text[i]==' '){
        j++;
        letter='';
        if(isOn==true){
          await torchController.toggle();
          isOn=false;
        }
        await Future.delayed(Duration(seconds: 2));
      }
      i++;
    }

  }
}
