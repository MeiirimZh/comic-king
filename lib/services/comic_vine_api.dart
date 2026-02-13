import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/character.dart';

class ComicVineApi {
  static const String _baseUrl =
      'https://comicvine.gamespot.com/api';

  static const Set<int> _allowedPublishers = {
    31,
    10,
    135,
  };

  Future<List<Character>> fetchCharacters() async {
    final apiKey = dotenv.env['COMIC_VINE_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API key не найден. Проверь .env');
    }

    final uri = Uri.parse(
      '$_baseUrl/characters/'
      '?api_key=$apiKey'
      '&format=json'
      '&limit=500'
    );

    final response = await http.get(
      uri,
      headers: {
        'User-Agent': 'Flutter App',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка сети: ${response.statusCode}');
    }

    final decoded = json.decode(response.body);

    if (decoded['error'] != 'OK') {
      throw Exception('Ошибка API: ${decoded['error']}');
    }

    final List results = decoded['results'];

    final characters = results
    .map((json) => Character.fromJson(json))
    .where((character) =>
        character.publisherId != null &&
        _allowedPublishers.contains(character.publisherId))
    .toList();

    return characters;
  }
}