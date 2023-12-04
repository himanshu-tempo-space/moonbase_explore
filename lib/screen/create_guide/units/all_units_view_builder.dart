
import 'package:flutter/material.dart';

import 'package:moonbase_explore/screen/create_guide/units/unit_container.dart';

import '../../../model/unit_model.dart';

class AllUnitsViewBuilder extends StatelessWidget {
  const AllUnitsViewBuilder({super.key, required this.allUnits});

  final List<Unit> allUnits;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 5),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemCount: allUnits.length + 1,
      itemBuilder: (BuildContext ctx, index) {
        if (index == allUnits.length) {
          return const UnitContainer.buildAddMoreUnit();
        } else {
          final unit = allUnits[index];
          return UnitContainer.buildWithUnit(
            unit: unit,
          );
        }
      },
    );
  }
}

