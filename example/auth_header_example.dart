// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:auth_header/auth_header.dart';

main() {
  HttpRequest request;  //TODO get from the real request

  List<String> headers = request.headers[HttpHeaders.AUTHORIZATION];
  if(headers is! List) {
    throw new Exception('No authorization header!');
  }

  String header = headers.first;

  Map<String, AuthHeaderItem> authHeader = new AuthHeaders.fromHeaderStr(header);
  print(authHeader.toString());

  AuthHeaderItem items = new AuthHeaderItem('some-scheme', 'teja');
  String headerManipulated = AuthHeaders.addItemToHeaderStr(header, items);
  print(headerManipulated);

  headerManipulated = AuthHeaders.removeSchemeFromHeaderStr(header, items.authScheme);
  print(headerManipulated);
}
