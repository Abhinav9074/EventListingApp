import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkImageAvatar extends StatefulWidget {
  final String imageQuery;
  final double radius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const NetworkImageAvatar({
    super.key,
    required this.imageQuery,
    this.radius = 60,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<NetworkImageAvatar> createState() => _NetworkImageAvatarState();
}

class _NetworkImageAvatarState extends State<NetworkImageAvatar> {
  Future<String> _getPexelsImageUrl(String query) async {
    await dotenv.load();
    
    final apiKey = dotenv.env['PEXELS_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      log('Pexels API key not found in .env file');
      return _getFallbackImage();
    }

    final formattedQuery = query.toLowerCase().replaceAll(' ', '+');
    final url = "https://api.pexels.com/v1/search?query=$formattedQuery&per_page=10";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final photos = data['photos'] as List;
        if (photos.isNotEmpty) {
          final randomIndex = DateTime.now().millisecond % photos.length;
          return photos[randomIndex]['src']['medium'];
        }
      } else {
        log('Pexels API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log("Pexels API Error: $e");
    }

    return _getFallbackImage();
  }

  String _getFallbackImage() {
    return "https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getPexelsImageUrl(widget.imageQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[300],
            child: widget.placeholder ?? const CupertinoActivityIndicator(),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[300],
            child: widget.errorWidget ?? const Icon(Icons.error),
          );
        } else {
          return CircleAvatar(
            radius: widget.radius,
            backgroundImage: NetworkImage(snapshot.data!),
          );
        }
      },
    );
  }
}