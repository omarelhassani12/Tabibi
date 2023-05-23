import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isLightMode = true;

  void _toggleTheme() {
    setState(() {
      _isLightMode = !_isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Theme'),
      value: _isLightMode,
      onChanged: (value) {
        _toggleTheme();
      },
      secondary: _isLightMode
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode),
    );
  }
}
