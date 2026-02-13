import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/character.dart';

class CharacterDetail extends StatelessWidget {
  final Character character;

  const CharacterDetail({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.black,
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported, size: 100, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              character.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            character.description != null && character.description!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Html(
                      data: character.description!,
                      style: {
                        "body": Style(
                          fontSize: FontSize(16),
                          lineHeight: LineHeight(1.5),
                        ),
                        "img": Style(
                          width: Width(300),
                          margin: Margins.symmetric(vertical: 12),
                          display: Display.block,
                        )
                      },
                    )
                  )
                : const Text(
                    'Описание недоступно',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
          ],
        ),
      ),
    );
  }
}