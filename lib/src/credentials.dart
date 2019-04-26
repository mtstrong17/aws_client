// Copyright (c) 2016, project contributors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

import 'dart:io' show Platform, File;

import 'package:path/path.dart' as path;
import 'package:ini/ini.dart' as ini;

String os = Platform.operatingSystem;

/// AWS credentials.
class Credentials {
  /// AWS access key
  final String accessKey;

  /// AWS secret key
  final String secretKey;

  /// AWS temporary credentials session token
  final String sessionToken;

  /// AWS credentials.
  Credentials({this.accessKey, this.secretKey, this.sessionToken}) {
    assert(accessKey != null);
    assert(secretKey != null);
  }
}

class SharedCredentials implements Credentials {
  /// AWS access key
  @override
  String accessKey;

  /// AWS secret key
  @override
  String secretKey;

  /// AWS temporary credentials session token
  @override
  String sessionToken;

  /// Contains default region from config
  String defaultRegion;

  ///Constructor for shared credentails
  SharedCredentials({profile='default', configLocation}) {
    var context = new path.Context(style: path.Style.platform);
    String home;
    Map<String, String> envVars = Platform.environment;
    if (configLocation == null) {
      if (Platform.isWindows) {
        home = envVars['UserProfile'];
      } else if (Platform.isLinux || Platform.isMacOS) {
        home = envVars['HOME'];
      }
      configLocation = context.join(home, '.aws');
    }
    String credentialsFile = File(context.join(configLocation, 'credentials')).readAsStringSync();
    String configFile = File(context.join(configLocation, 'config')).readAsStringSync();
    
    ini.Config credentials = ini.Config.fromString(credentialsFile);
    ini.Config config = ini.Config.fromString(configFile);

    
    if (credentials.hasSection(profile)) {
      accessKey = credentials.get(profile, 'aws_access_key_id');
      secretKey = credentials.get(profile, 'aws_secret_access_key');
      sessionToken = credentials.get(profile, 'aws_session_token');
      defaultRegion = config.get("profile $profile", 'region');
    } else {
      throw Exception('Specified profile: $profile not found');
    }
  }
}
