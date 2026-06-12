import 'package:flutter/material.dart';

import '../services/api_client.dart';
import '../widgets/status_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _apiClient = ApiClient();
  late Future<HomeSummary> _summaryFuture;

  @override
  void initState() {
    super.initState();
    _summaryFuture = _apiClient.fetchHomeSummary();
  }

  void _reload() {
    setState(() {
      _summaryFuture = _apiClient.fetchHomeSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Density'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _reload,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<HomeSummary>(
          future: _summaryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return StatusPanel(
                icon: Icons.cloud_off_rounded,
                title: 'Backend unavailable',
                message: snapshot.error.toString(),
                actionLabel: 'Try again',
                onAction: _reload,
              );
            }

            final summary = snapshot.requireData;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  summary.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  summary.tagline,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                for (final action in summary.actions)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.api_rounded),
                      title: Text(action.label),
                      subtitle: Text(action.endpoint),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
