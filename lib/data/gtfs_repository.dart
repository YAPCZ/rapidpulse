import 'package:rapidpulse_my/data/gtfs_api.dart';
import 'package:rapidpulse_my/data/gtfs_zip_reader.dart';

class RapidRailRepository {
  final GtfsApi api;
  final GtfsZipReader reader;

  RapidRailRepository({
    required this.api,
    required this.reader,
  });

  Future<void> loadStaticData() async {
    final zipBytes = await api.downloadRapidRail(
      category: 'rapid-rail-kl',
    );

    final files = reader.extract(zipBytes);

    print(files.keys);
  }
}