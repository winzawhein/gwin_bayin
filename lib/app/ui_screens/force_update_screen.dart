import 'package:flutter/material.dart';

class ForceUpdateScreen extends StatelessWidget {
  final String? updateMessage;
  final String? updateUrl;

  const ForceUpdateScreen({super.key, this.updateMessage, this.updateUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.system_update, size: 64, color: Color(0xFFE53935)),
                const SizedBox(height: 16),
                const Text(
                  'Update Required',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  updateMessage ?? 'A newer version of the app is required.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Open external store url would require url_launcher.
                    // Keep as no-op for now.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

