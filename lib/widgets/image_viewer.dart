import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.contained * 5.0,
    );
  }
}
