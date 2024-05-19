import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:flutter_sms/flutter_sms.dart';

void main() {
  TorchController().initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String _displayText = '';
  final torchController = TorchController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _decryptedTextController =
      TextEditingController();
  String code = '';
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
    code = morseCode(_messageController.text);

    flashlight(code);
  }

  void onSendSMSPressed() {
    String message = code;
    // String msg = message.replaceAll("#", "\n");
    List<String> recipients = _recipientController.text.split(',');
    sendSMStopeople(message, recipients);
  }

  void onDecryptPressed() {
    setState(() {
      _displayText = decryptMorseCode(_decryptedTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Morse Code App")),
        backgroundColor: Color.fromARGB(255, 231, 209, 233),
        body: ListView(
          children: [
            GetBody(),
          ],
        ),
      ),
    );
  }

  Widget GetBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: "Enter text here"),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _recipientController,
              decoration:
                  const InputDecoration(labelText: "Enter recipients here"),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onButtonPressed,
            child: const Text("Convert to Morse"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSendSMSPressed,
            child: const Text("Send SMS"),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _decryptedTextController,
              decoration: const InputDecoration(labelText: "Decrypted text"),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onDecryptPressed,
            child: const Text("Decrypt"),
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
  }

  String decryptMorseCode(String text) {
    String result = '';
    List<String> words = text.split('#'); // cuvinte

    for (String word in words) {
      List<String> letters = word.split(' ');  // litere
      for (String letter in letters) {
        String decodedLetter = morseCodeMap.entries
            .firstWhere(
              (entry) => entry.value == letter,
              orElse: () => MapEntry('', ''),
            )
            .key;
        result += decodedLetter;
      }
      result += ' ';
    }

    return result.trim();
  }

  /*
  1 secunda intre fiecare . sau -
  3 secunde intre fiecare litera
  5 secunde intre fiecare cuvant
  . 1 secunda
  - 3 secunde
  */
  void flashlight(String text) async {
    int i = 0;
    int j = 0;
    String letter = '';
    bool isOn = await torchController.toggle() as bool;
    while (i < text.length) {
      setState(() {
        if (text[i] != '#' && text[i] != ' ') {
          letter += text[i];
        }

        if (_messageController.text[j] == ' ') {
          j++;
        }
        _displayText = '${_messageController.text[j]}:$letter';
      });
      if (text[i] == '.') {
        if (isOn == false) {
          await torchController.toggle();
          isOn = true;
        }
        await Future.delayed(Duration(seconds: 1));
        await torchController.toggle();
        await Future.delayed(Duration(seconds: 1));
        isOn = false;
      } else if (text[i] == '-') {
        if (isOn == false) {
          await torchController.toggle();
          isOn = true;
        }
        await Future.delayed(Duration(seconds: 3));
        await torchController.toggle();
        await Future.delayed(Duration(seconds: 1));
        isOn = false;
      } else if (text[i] == '#') {
        if (isOn == true) {
          await torchController.toggle();
          isOn = false;
        }
        await Future.delayed(Duration(seconds: 4));
      } else if (text[i] == ' ') {
        j++;
        letter = '';
        if (isOn == true) {
          await torchController.toggle();
          isOn = false;
        }
        await Future.delayed(Duration(seconds: 2));
      }
      i++;
    }
  }

  void sendSMStopeople(String message, List<String> recipients) async {
    await sendSMS(message: message, recipients: recipients);
  }
}
