import 'package:flutter/material.dart';

class LevelTile extends StatefulWidget {
  final String ImgPath;
  final String level;
  final String display;
  final bool isLocked;
  final VoidCallback onTap;
  const LevelTile(
      {super.key,
      required this.ImgPath,
      required this.level,
      required this.isLocked,
      required this.onTap, required this.display});

  @override
  State<LevelTile> createState() => _LevelTileState();
}

class _LevelTileState extends State<LevelTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        foregroundDecoration: widget.isLocked
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:
                    DecorationImage(image: AssetImage('assets/icons/lock.png')),
                color: Colors.black.withOpacity(0.5),
              )
            : null,
        height: 200,
        width: 160,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.level,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.ImgPath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
