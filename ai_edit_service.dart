import 'dart:convert';
import 'package:http/http.dart' as http;

class AiEditService {
  static const _apiKey = 'ahamaibyprakash25';
  static const _apiUrl =
      'https://api-aham-ai.officialprakashkrsingh.workers.dev/v1/chat/completions';

  Future<String> editFile(String instructions, String content) async {
    final messages = [
      {
        'role': 'user',
        'content':
            'Apply the following changes to the file and return only the updated file content.\n'
                '$instructions\n\n```
$content
```'
      }
    ];

    final body = json.encode({
      'model': 'gpt-3.5-turbo',
      'messages': messages,
      'temperature': 0,
      'stream': false,
    });

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_apiKey',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data['choices'][0]['message']['content'] as String;
    } else {
      throw Exception('AI request failed: ${response.statusCode}');
    }
  }
}
