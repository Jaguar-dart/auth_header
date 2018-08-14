// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:auth_header/auth_header.dart';

main() {
  String header = "Basic something-something";
  AuthHeaders authHeader = AuthHeaders.fromHeaderStr(header);
  print(authHeader);

  AuthHeaderItem items = AuthHeaderItem('some-scheme', 'teja');
  String headerManipulated = AuthHeaders.addItemToHeaderStr(header, items);
  print(headerManipulated);

  headerManipulated =
      AuthHeaders.removeSchemeFromHeaderStr(header, items.authScheme);
  print(headerManipulated);
}
