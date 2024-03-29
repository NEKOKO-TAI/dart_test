import 'dart:html';
import 'dart:json';
import 'dart:async';
import 'dart:math';
//import 'dart:io';

num rotatePos = 0;
String text1="初期値";

void rotateText(Event event) {
  rotatePos += 360;
  query("#text").style
    ..transition = "1s"
    ..transform = "rotate(${rotatePos}deg)";
}
void reverseText(Event event) {
  var text = query("#text").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  query("#text").text = buffer.toString();
}

void clickCalcMethod(Event event) {
  var elemText, d;
  elemText = query("#inputText");
  d = double.parse(elemText.value);
  d = d * 2;
  window.alert('${d}');

  elemText = query("#inputTextArea");
  List individualMakers = elemText.value.split('\n');
  window.alert(individualMakers[0]);

  elemText = query("#outputTextArea");
  elemText.value=individualMakers[0];
}

void clickFile(Event event) {
  var elemText, d;
  elemText = query("#file");
  window.alert('${elemText.value}');

/*
  File file = new File(elemText.value);
  //if (!file.existsSync()) <handle missing file>;
  InputStream file_stream = file.openInputStream();
  StringInputStream lines = new StringInputStream(file_stream);

  lines.lineHandler = () {
    String line, allline;
    while ((line = lines.readLine()) != null) {
      allline = allline + "\n" + line;
    }
  };
  lines.closeHandler = () {
    //...
  };*/
}

void processJson(String jsonString){
  //このハンドラはmain終了後に実行される
  var data = parse(jsonString);
  text1=data['name'];

  print("The contents of your data1 ---: ${jsonString}");
  print("The contents of your data2 ---: ${text1}");

  var aa= query("#text");
  aa.text = text1;//"Click me!"

  aa.onClick.listen(rotateText);
  aa.onClick.listen(reverseText);
}
void handleError(AsyncError error){window.alert("Error get Json data: $error");}

void main() {
  //query("#text")
  //  ..text = "Click me!"
  //  ..on.click.add(reverseText);

  var aa= query("#text");
  aa.text = text1;//"Click me!"

  HttpRequest.getString("./test.json")
  .then(processJson)
  .catchError(handleError);
  
  
  query("#click_calc").onClick.listen(clickCalcMethod);
  query("#click_calc_b").onClick.listen(clickCalcMethod);
  query("#click_file").onClick.listen(clickFile);

  print("main_end");
}

