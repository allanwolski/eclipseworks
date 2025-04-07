import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String url;
  const ImageViewer(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
