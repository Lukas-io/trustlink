import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/resources/enums.dart';

// class _FilterWidgetState extends State<FilterWidget> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   late List<FilterChipData> _filterChips;
//
//   @override
//   void initState() {
//     super.initState();
//     _filterChips = [
//       FilterChipData("Pending", true),
//       FilterChipData("Completed", false),
//       FilterChipData("Refunded", false),
//       FilterChipData("Canceled", false),
//     ];
//   }
//
//   void _updateFilters() {
//     List<String> activeFilters = _filterChips
//         .where((chip) => chip.selected)
//         .map((chip) => chip.label)
//         .toList();
//     widget.onFilterChanged(activeFilters);
//   }
//
//   void _onChipSelected(int index, bool selected) {
//     setState(() {
//       _filterChips[index].selected = selected;
//       if (selected) {
//         // Move the selected chip to the front
//         final chip = _filterChips.removeAt(index);
//         _filterChips.insert(0, chip);
//         _listKey.currentState?.removeItem(
//           index,
//           (context, animation) => _buildChip(chip, animation, index),
//           duration: const Duration(milliseconds: 300),
//         );
//         _listKey.currentState
//             ?.insertItem(0, duration: const Duration(milliseconds: 300));
//       }
//     });
//     _updateFilters();
//   }
//
//   Widget _buildChip(
//       FilterChipData chip, Animation<double> animation, int index) {
//     return SizeTransition(
//       sizeFactor: animation,
//       child: SlideTransition(
//         position: animation.drive(Tween<Offset>(
//           begin: const Offset(-1, 0),
//           end: Offset.zero,
//         )),
//         child: Padding(
//           padding: const EdgeInsets.only(right: 12.0),
//           child: FilterChip(
//             label: Text(chip.label),
//             selected: chip.selected,
//             onSelected: (bool selected) {
//               _onChipSelected(index, selected);
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 45.0,
//       child: AnimatedList(
//         key: _listKey,
//         scrollDirection: Axis.horizontal,
//         initialItemCount: _filterChips.length,
//         itemBuilder: (context, index, animation) {
//           return _buildChip(_filterChips[index], animation, index);
//         },
//       ),
//     );
//   }
// }

// class FilterChipData {
//   final String label;
//   bool selected;
//
//   FilterChipData(this.label, this.selected);
// }

class FilterWidget extends StatelessWidget {
  final Function(TransactionStatus) onFilter;

  const FilterWidget({super.key, required this.onFilter});

  @override
  Widget build(BuildContext context) {
    bool pending = false;
    bool completed = false;
    bool refunded = false;
    bool canceled = false;

    void filter({
      bool pend = false,
      bool comp = false,
      bool ref = false,
      bool can = false,
    }) {
      pending = pend;
      completed = comp;
      refunded = ref;
      canceled = can;

      if (pending) onFilter(TransactionStatus.pending);
      if (completed) onFilter(TransactionStatus.completed);
      if (refunded) onFilter(TransactionStatus.refunded);
      if (canceled) onFilter(TransactionStatus.canceled);

      if (!pending && !canceled && !refunded && !completed) {
        onFilter(TransactionStatus.all);
      }
    }

    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        height: 45.0,
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0),
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FilterChip(
                label: const Text("Pending"),
                selected: pending,
                onSelected: (bool value) {
                  setState(() => filter(pend: !pending));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FilterChip(
                label: const Text("Completed"),
                selected: completed,
                selectedColor: AppColors.completed,
                onSelected: (bool value) {
                  setState(() => filter(comp: !completed));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FilterChip(
                label: const Text("Refunded"),
                selected: refunded,
                selectedColor: AppColors.purple,
                onSelected: (bool value) {
                  setState(() => filter(ref: !refunded));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FilterChip(
                label: const Text("Canceled"),
                selected: canceled,
                selectedColor: AppColors.orange,
                onSelected: (bool value) {
                  setState(() => filter(can: !canceled));
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
