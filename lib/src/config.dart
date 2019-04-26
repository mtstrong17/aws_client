// Copyright (c) 2016, project contributors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

import './credentials.dart';

class AWSConfig {
  ///Regoin to use for requests
  String region;

  ///AWS Credentials
  Credentials credentials;

  /// Constructor
  AWSConfig({this.credentials, this.region});
}