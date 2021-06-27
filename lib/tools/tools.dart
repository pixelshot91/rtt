import 'dart:convert';
import 'dart:html';

class Tools {
  static void downloadFile(String str, String filename) {
    final content = base64Encode(str.codeUnits);
    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute('download', filename)
      ..click();
  }
}
