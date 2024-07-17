
import 'package:flutter/material.dart';

class CustomSegmentButton extends StatelessWidget {
 final  void Function(Set)? onSelectionChanged;
 final Set selected;
 final List<ButtonSegment<dynamic>> segments;
  const CustomSegmentButton({required this.onSelectionChanged,required this.selected,required this.segments,super.key});

  @override
  Widget build(BuildContext context) {
    return  SegmentedButton(
      style: SegmentedButton.styleFrom(
        foregroundColor: Colors.white,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.red.shade100,
        side: const BorderSide(color: Colors.white),
      ),
      onSelectionChanged: onSelectionChanged,
      segments: segments,
      selected: selected,
    );
  }
}
