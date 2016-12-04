// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library auth_header;

import 'dart:io' show HttpHeaders;

/// Represents an item in Authorisation header
class AuthHeaderItem {
  /// Authorisation scheme
  final String authScheme;

  /// Authorisation credentials
  final String credentials;

  AuthHeaderItem(this.authScheme, this.credentials);

  String toString() => '${authScheme} ${credentials}';

  /// Value returned by this function shall be added to request headers
  Map<String, String> toAuthorizationHeader() =>
      {HttpHeaders.AUTHORIZATION: toString()};

  /// Finds Authorisation header item in the given [header] by given [sceme]
  factory AuthHeaderItem.fromHeaderBySchema(String header, String sceme) =>
      headerToItems(header)[sceme];

  /// Creates and returns a Map of scheme to [AuthHeaderItem] from given [header]
  static Map<String, AuthHeaderItem> headerToItems(String header) {
    List<String> authHeaders = _splitAuthHeader(header);

    final map = <String, AuthHeaderItem>{};

    authHeaders.forEach((String headerStr) {
      final List<String> parts = header.split(' ');

      if (parts.length != 2) {
        return;
      }

      map[parts[0]] = new AuthHeaderItem(parts[0], parts[1]);
    });

    return map;
  }

  /// Adds new authorisation item [newItem] to the authorisation header [header]
  static String addItemToAuthHeader(String header, AuthHeaderItem newItem,
      {bool omitIfAuthSchemeAlreadyInHeader: true}) {
    final items = AuthHeaderItem.headerToItems(header);

    if (omitIfAuthSchemeAlreadyInHeader &&
        items.containsKey(newItem.authScheme)) {
      return header;
    } else {
      items[newItem.authScheme] = newItem;

      return items.values.map((h) => h.toString()).join(',');
    }
  }

  /// Removed the requested scheme from the header
  static String removeSchemeFromHeader(String header, String scheme) {
    final items = AuthHeaderItem.headerToItems(header);

    if (items.isEmpty || !items.containsKey(scheme)) {
      return header;
    }

    items.remove(scheme);

    return items.values.map((h) => h.toString()).join(',');
  }
}

/// Splits Authorisation header into items
List<String> _splitAuthHeader(String header) {
  return header == null ? [] : header.split(',');
}