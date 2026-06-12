import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({
    http.Client? httpClient,
    String? baseUrl,
  })  : _httpClient = httpClient ?? http.Client(),
        baseUrl = baseUrl ?? _defaultBaseUrl;

  static const _defaultBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  final http.Client _httpClient;
  final String baseUrl;

  Future<HomeSummary> fetchHomeSummary() async {
    final uri = Uri.parse('$baseUrl/api/home/');
    final response = await _httpClient.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'Backend returned ${response.statusCode}',
        response.body,
      );
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    return HomeSummary.fromJson(payload);
  }
}

class HomeSummary {
  const HomeSummary({
    required this.title,
    required this.tagline,
    required this.actions,
  });

  factory HomeSummary.fromJson(Map<String, dynamic> json) {
    final rawActions = json['actions'] as List<dynamic>? ?? [];

    return HomeSummary(
      title: json['title'] as String? ?? 'Density',
      tagline: json['tagline'] as String? ?? '',
      actions: rawActions
          .map((item) => HomeAction.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  final String title;
  final String tagline;
  final List<HomeAction> actions;
}

class HomeAction {
  const HomeAction({
    required this.label,
    required this.endpoint,
  });

  factory HomeAction.fromJson(Map<String, dynamic> json) {
    return HomeAction(
      label: json['label'] as String? ?? '',
      endpoint: json['endpoint'] as String? ?? '',
    );
  }

  final String label;
  final String endpoint;
}

class ApiException implements Exception {
  const ApiException(this.message, this.detail);

  final String message;
  final String detail;

  @override
  String toString() => '$message: $detail';
}
