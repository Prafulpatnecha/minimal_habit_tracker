import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import '../../controller/home_get_controller.dart';

HeatMapCalendar buildHeatMapCalendar(
    BuildContext context, HomeProvider homeProviderTrue) {
  return HeatMapCalendar(
    defaultColor: Theme.of(context).colorScheme.onError,
    flexible: true,
    showColorTip: false,
    weekTextColor: Theme.of(context).colorScheme.onSurface,
    textColor: Theme.of(context).colorScheme.onPrimary,
    colorMode: ColorMode.color,
    datasets: homeProviderTrue.dateSetAll,
    colorsets: {
      1: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      2: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      3: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      4: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
      5: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      6: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
      7: Theme.of(context).colorScheme.secondary.withOpacity(1),
    },
    onClick: (value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      );
    },
  );
}

Widget buildHeatMap(
    BuildContext context, HomeProvider homeProviderTrue) {
  return HeatMap(
    colorMode: ColorMode.color,
    showText: true,
    textColor: Theme.of(context).colorScheme.onSurface,
    showColorTip: true,
    datasets: homeProviderTrue.dateSetAll,
    colorsets: {
      1: Colors.green.withOpacity(0.1),
      2: Colors.green.withOpacity(0.2),
      3: Colors.green.withOpacity(0.3),
      4: Colors.green.withOpacity(0.4),
      5: Colors.green.withOpacity(0.5),
      6: Colors.green.withOpacity(0.6),
      7: Colors.green.withOpacity(0.9),
    },
    startDate: DateTime(homeProviderTrue.dateTime.year, homeProviderTrue.dateTime.month, homeProviderTrue.dateTime.day),
    endDate: DateTime(homeProviderTrue.dateTime.year, homeProviderTrue.dateTime.month, homeProviderTrue.dateTime.day),
    onClick: (value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value.toString())));
    },
  );
}
