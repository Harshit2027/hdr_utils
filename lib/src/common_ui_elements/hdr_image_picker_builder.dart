import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HdrImagePickerBuilder extends StatefulWidget {
  const HdrImagePickerBuilder({
    super.key,
    required this.localImage,
    required this.imageUrl,
    required this.placeholderBuilder,
    this.shape,
    this.onTap,
    this.width,
    this.height,
  });

  final XFile? localImage;
  final String? imageUrl;
  final WidgetBuilder placeholderBuilder;
  final double? height;
  final double? width;
  final ShapeBorder? shape;
  final VoidCallback? onTap;

  @override
  State<HdrImagePickerBuilder> createState() => _HdrImagePickerBuilderState();
}

class _HdrImagePickerBuilderState extends State<HdrImagePickerBuilder> {
  late Future<Uint8List>? _imageDataFuture;

  @override
  void initState() {
    super.initState();
    _imageDataFuture = widget.localImage?.readAsBytes();
  }

  @override
  void didUpdateWidget(covariant HdrImagePickerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.localImage != oldWidget.localImage) {
      _imageDataFuture = widget.localImage?.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl ?? "";
    final Widget placeholder = Builder(builder: widget.placeholderBuilder);
    Widget child;

    if (widget.localImage != null) {
      child = FutureBuilder<Uint8List>(
        future: _imageDataFuture,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting ||
              data == null) {
            return placeholder;
          }
          return Image.memory(
            data,
            height: widget.height,
            width: widget.width,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholder,
          );
        },
      );
    } else if (imageUrl.isNotEmpty) {
      child = CachedNetworkImage(
        imageUrl: imageUrl,
        height: widget.height,
        width: widget.width,
        fit: BoxFit.cover,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      );
    } else {
      child = placeholder;
    }

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: widget.shape,
        child: InkWell(
          customBorder: widget.shape,
          onTap: widget.onTap,
          child: child,
        ),
      ),
    );
  }
}
