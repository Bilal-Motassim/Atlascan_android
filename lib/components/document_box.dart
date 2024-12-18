import 'package:flutter/material.dart';

class DocumentBox extends StatelessWidget {
  final String name;
  final String url;
  final bool isSelected;
  final Function(bool) onSelected;

  const DocumentBox({
    super.key,
    required this.name,
    required this.url,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onSelected(!isSelected);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          // decoration: BoxDecoration(
          //   color: isSelected ? Colors.blue[100] : Colors.grey[200],
          //   borderRadius: BorderRadius.circular(8),
          // ),
          decoration: ShapeDecoration(
            color: isSelected ? Colors.white.withOpacity(0.4000000059604645) : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: [
              BoxShadow(
                color: Color.fromARGB(61, 73, 31, 128),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              // Image on the left
              Image.asset(
                url,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16), // Spacing between image and text
              // Document name
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
