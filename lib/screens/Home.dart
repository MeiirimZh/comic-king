import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/character.dart';
import '../services/comic_vine_api.dart';
import 'CharacterDetail.dart';

import '../src/theme/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ComicVineApi api = ComicVineApi();

  Character? dailyCharacter;
  bool isLoading = true;

  static const String _dateKey = 'daily_character_date';
  static const String _characterIdKey = 'daily_character_id';

  @override
  void initState() {
    super.initState();
    _loadDailyCharacter();
  }

  Future<void> _loadDailyCharacter() async {
    final prefs = await SharedPreferences.getInstance();

    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    final savedDate = prefs.getString(_dateKey);
    final savedCharacterId = prefs.getString(_characterIdKey);

    final characters = await api.fetchCharacters();

    if (savedDate == todayString && savedCharacterId != null) {
      try {
        dailyCharacter = characters.firstWhere(
          (c) => c.id.toString() == savedCharacterId,
        );
      } catch (_) {
        dailyCharacter = _getRandomCharacter(characters);
        await _saveDailyCharacter(prefs, todayString);
      }
    } else {
      dailyCharacter = _getRandomCharacter(characters);
      await _saveDailyCharacter(prefs, todayString);
    }

    setState(() {
      isLoading = false;
    });
  }

  Character _getRandomCharacter(List<Character> characters) {
    final random = Random();
    return characters[random.nextInt(characters.length)];
  }

  Future<void> _saveDailyCharacter(SharedPreferences prefs, String date) async {
    await prefs.setString(_dateKey, date);
    await prefs.setString(_characterIdKey, dailyCharacter!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : dailyCharacter == null
              ? const Center(child: Text('Ошибка загрузки'))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Персонаж дня',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CharacterDetail(
                                character: dailyCharacter!,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 300,
                          height: 500,
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.black,
                                    child: Center(
                                      child: Image.network(
                                        dailyCharacter!.imageUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                          Icons.image_not_supported,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    dailyCharacter!.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}