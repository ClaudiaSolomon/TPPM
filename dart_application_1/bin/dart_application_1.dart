
import 'package:xml/xml.dart' as xml;

class Example {
  int varA;
  int varB;
  String varC;
  List<int> varD;
  double varE;

  Example(this.varA, this.varB, this.varC, this.varD, this.varE);

  factory Example.fromXml(String xmlString) {
    var element = xml.XmlDocument.parse(xmlString).rootElement;

    return Example(
      int.parse(element.findElements('varA').single.innerText),
      int.parse(element.findElements('varB').single.innerText),
      element.findElements('varC').single.innerText,
      element.findElements('varD').single.innerText.split(',').map(int.parse).toList(),
      double.parse(element.findElements('varE').single.innerText),
    );
  }

  xml.XmlElement toXml() {
    return xml.XmlElement(xml.XmlName('Example'), [], [
      xml.XmlElement(xml.XmlName('varA'), [], [xml.XmlText(varA.toString())]),
      xml.XmlElement(xml.XmlName('varB'), [], [xml.XmlText(varB.toString())]),
      xml.XmlElement(xml.XmlName('varC'), [], [xml.XmlText(varC)]),
      xml.XmlElement(xml.XmlName('varD'), [], [xml.XmlText(varD.join(','))]),
      xml.XmlElement(xml.XmlName('varE'), [], [xml.XmlText(varE.toString())]),
    ]);
  }
}

void main() {
  var example = Example(100, 5, "da", [1, 2, 3,4], 2.90);
  var xmlElement = example.toXml();
  var xmlString = xmlElement.toXmlString(pretty: true);
  print(xmlString);

  var exampleFromXml = Example.fromXml(xmlString);
  print(exampleFromXml.varA);
  print(exampleFromXml.varB);
  print(exampleFromXml.varC);
  print(exampleFromXml.varD);
  print(exampleFromXml.varE);
}