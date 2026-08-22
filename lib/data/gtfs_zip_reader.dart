import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class GtfsZipReader {
  Map<String, String> extract(Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes);

    final files = <String, String>{};

    for (final file in archive) {
      if (!file.isFile) continue;

      final name = file.name;

      if (!name.endsWith('.txt')) continue;

      final content = utf8.decode(
        file.content as List<int>,
        allowMalformed: true,
      );

      files[name] = content;
    }

    return files;
  }
}
