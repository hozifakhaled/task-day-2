import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SourceButtons extends StatelessWidget {
  const SourceButtons({
    super.key,
    required this.youtube,
    required this.source,
  });

  final String youtube;
  final String source;

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (youtube.isNotEmpty)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(youtube),
              icon: const Icon(Icons.play_circle_fill),
              label: const Text("YouTube"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

        if (youtube.isNotEmpty && source.isNotEmpty)
          const SizedBox(width: 15),

        if (source.isNotEmpty)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _launchUrl(source),
              icon: const Icon(Icons.language),
              label: const Text("Source"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: const BorderSide(
                  color: Colors.orange,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
      ],
    );
  }
}