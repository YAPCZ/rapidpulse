import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscure;
  final String? value;
  const AppInput({
    super.key,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.value,
  });
  @override
  Widget build(BuildContext context) => TextField(
    obscureText: obscure,
    controller: value == null ? null : TextEditingController(text: value),
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF9DA5B1)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

class StatusLegend extends StatelessWidget {
  final Color color;
  final String text;
  const StatusLegend({super.key, required this.color, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Text(text),
      ],
    ),
  );
}
