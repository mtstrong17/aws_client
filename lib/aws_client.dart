// Copyright (c) 2016, project contributors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

import 'package:http_client/http_client.dart' as http;

import 'src/credentials.dart';
import 'src/config.dart';
import 'sqs.dart';

export './src/config.dart';
export './src/credentials.dart';

/// AWS access facade that helps to initialize multiple services with common
/// settings (credentials and HTTP client).
class AWS {
  AWSConfig config;

  Sqs _sqs;

  ///
  AWS([this.config]);

  /// Returns an SQS service, inheriting the properties of this instance.
  // Sqs get sqs =>
  //     _sqs ??= new Sqs(credentials: _credentials, httpClient: _httpClient);
}
