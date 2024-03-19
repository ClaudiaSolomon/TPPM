import 'dart:convert';
import 'dart:io';
import 'lab4-ex4.dart';
//1
List<String> match_expresii_regulate(String input, List<RegExp> expresii) {
  List<String> matches = [];

  for (RegExp expresie in expresii) {
    Iterable<RegExpMatch> match = expresie.allMatches(input);
    if (match != null) {
      for(RegExpMatch m in match)
      {
        matches.add(m.group(0)!);
      }
    }
  }

  return matches;
}

//2
class Stack {
  late File _file;
  late RandomAccessFile _raf;

  Stack(String filename) {
    _file = File(filename);
  }

  Future<void> open() async {
    _raf = await _file.open(mode: FileMode.write);
  }

  Future<void> push(String data) async {
    await _raf.writeString(data + '\n');
  }

  Future<String?> pop() async {
    var lines = await _file.readAsLines();
    if (lines.isEmpty) return null;
    var data = lines.removeLast();
    await _file.writeAsString(lines.join('\n'));
    return data;
  }

  Future<String?> peek() async {
    var lines = await _file.readAsLines();
    if (lines.isNotEmpty) {
      return lines.last;
    } else {
      return null;
    }
  }

  bool isEmpty() {
    return _file.lengthSync() == 0;
  }

  Future<void> clear() async {
    await _file.writeAsString('');
  }

  Future<void> close() async {
    await _raf.close();
  }
}


//3
class MathOps<T, G> {
  int sub(T obj1, G obj2) {
    if(obj1 is int)
    {
      if(obj2 is int)
      {
        return (obj1 as int) - (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
          return (obj1 as int) - (obj2 as double).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
    }
    else
    {
      if(obj1 is double)
      {
        if(obj2 is int)
      {
        return (obj1 as double).toInt() - (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
           return ((obj1 as double) - (obj2 as double)).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
      }
      else{
        throw ArgumentError("obj1=String");
      }
    }

  }

  int prod(T obj1, G obj2) {
   if(obj1 is int)
    {
      if(obj2 is int)
      {
        return (obj1 as int) * (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
          return (obj1 as int) * (obj2 as double).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
    }
    else
    {
      if(obj1 is double)
      {
        if(obj2 is int)
      {
        return (obj1 as double).toInt() * (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
           return ((obj1 as double) * (obj2 as double)).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
      }
      else{
        throw ArgumentError("obj1=String");
      }
    }
    }

  int mod(T obj1, G obj2) {
    if(obj1 is int)
    {
      if(obj2 is int)
      {
        return (obj1 as int) % (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
          return (obj1 as int) % (obj2 as double).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
    }
    else
    {
      if(obj1 is double)
      {
        if(obj2 is int)
      {
        return (obj1 as double).toInt() % (obj2 as int);
      }
      else{
        if(obj2 is double)
        {
           return ((obj1 as double) % (obj2 as double)).toInt();
        }
        else{
          throw ArgumentError("obj2=String");
        }
      }
      }
      else{
        throw ArgumentError("obj1=String");
      }
    }
  }
}


Future<void> main() async {
  print("--------------1--------------");
  String input = "Ana are  2 mere si  3 pere";
  List<RegExp> expresii = [
    RegExp(r'\d+'),
    RegExp(r'[A-Z]+')
  ];

  List<String> potriviri = match_expresii_regulate(input, expresii);
    for (String potrivire in potriviri) {
      print(potrivire);
    }

  print("--------------2--------------");

  var stack = Stack('stack.txt'); 
  
  await stack.open();

  await stack.push('Element 1');
  await stack.push('Element 2');
  await stack.push('Element 3');

  var top = await stack.peek();
  print('Vârful stivei: $top');
  var popped = await stack.pop();
  print('Element extras din stivă: $popped');
  var empty = stack.isEmpty();
  print('Stiva este goală: $empty');
  // await stack.clear();
  await stack.close();

  print("--------------3--------------");
  MathOps mathOps = MathOps();
try {
    print(mathOps.sub(5, 2));
  } catch (e) {
    print("Eroare: $e");
  }
  try {
    print(mathOps.prod(3.5, 2.0));
  } catch (e) {
    print("Eroare: $e");
  }
  try {
    print(mathOps.mod(10, 3.0)); 
  } catch (e) {
    print("Eroare: $e");
  }
  try {
    print(mathOps.mod(2.0,"da"));
  } catch (e) {
    print("Eroare: $e");
  }

  print("--------------4--------------");
  String jsonPath1 = 'C:\\Users\\Claudia\\OneDrive\\Documente\\GitHub\\TPPM\\lab4\\json1.json';
  String jsonPath2 = 'C:\\Users\\Claudia\\OneDrive\\Documente\\GitHub\\TPPM\\lab4\\json2.json';

  Map<String, dynamic> result = jsonSubJson(jsonPath1, jsonPath2);
  print(jsonEncode(result));
}
