# auth_header

Utility library to parse and manipulate HTTP Authorisation header

## Usage

A simple usage example:

```dart
import 'dart:io';
import 'package:auth_header/auth_header.dart';

main() {
  HttpRequest request;  // TODO get from the real request

  List<String> headers = request.headers[HttpHeaders.AUTHORIZATION];
  if(headers is! List) {
    throw new Exception('No authorization header!');
  }

  String header = headers.first;

  AuthHeaders authHeader = new AuthHeaders.fromHeaderStr(header);
  print(authHeader);

  AuthHeaderItem items = new AuthHeaderItem('some-scheme', 'teja');
  String headerManipulated = AuthHeaders.addItemToHeaderStr(header, items);
  print(headerManipulated);

  headerManipulated = AuthHeaders.removeSchemeFromHeaderStr(header, items.authScheme);
  print(headerManipulated);
}
```
