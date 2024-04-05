import 'dart:developer';

import 'package:extractor/extractor.dart';
import 'package:video_downloader/models/video_download_model.dart';
import 'package:video_downloader/models/video_quality_model.dart';

class VideoDownloaderRepository {
  Future<VideoDownloadModel?> getAvailableVideos(String url) async {
    try {
      final response = await Extractor.getDirectLink(link: url);

      if (response != null) {
        return VideoDownloadModel.fromJson({
          "title": response.title,
          "source": response.links?.first.href,
          "thumbnail": response.thumbnail,
          "videos": [
            VideoQualityModel(
              url: response.links?.first.href,
              quality: "720",
            )
          ]
        });
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("Exception occured $e");
      return null;
    }
  }
}
