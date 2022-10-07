import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({Key? key}) : super(key: key);

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  IconData? selectedIcon = Icons.favorite;
  final List<IconData> allIcons = [
    Icons.headphones,
    Icons.home,
    Icons.fitness_center,
    Icons.radar,
    // add more icons here if you want
  ];

  _onsave(IconData icono) {
    Navigator.of(context).pop(icono);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemCount: allIcons.length,
          itemBuilder: ((context, index) {
            final icono = allIcons[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: InkWell(
                onTap: () {
                  _onsave(icono);
                },
                child: Icon(icono),
              ),
            );
          }),
        ),
      ),
    );
  }
}
