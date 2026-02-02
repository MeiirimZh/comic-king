import 'package:flutter/material.dart';
import '../services/auth_storage.dart';
import '../services/auth_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    final login = loginController.text.trim();
    final password = passwordController.text;

    if (login.isEmpty || password.isEmpty) {
      showError('Заполните все поля');
      return;
    }

    final users = await AuthStorage.getUsers();

    if (users.containsKey(login)) {
      showError('Логин уже существует');
      return;
    }

    users[login] = hashPassword(password);
    await AuthStorage.saveUsers(users);

    Navigator.pop(context);
  }

  void showError(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(labelText: 'Логин'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}