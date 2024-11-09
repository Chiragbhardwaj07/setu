import 'package:flutter/material.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class HomepageButton extends StatefulWidget {
  GestureTapCallback onPressed;
  IconData icon;
  String title;
  HomepageButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.title});

  @override
  State<HomepageButton> createState() => _HomepageButtonState();
}

class _HomepageButtonState extends State<HomepageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          height: AppProportions.screenHeight * 0.19,
          width: AppProportions.screenWidth * 0.42,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 50,
              ),
              Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
