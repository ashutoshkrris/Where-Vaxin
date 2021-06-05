import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key? key,
    required this.name,
    required this.address,
    required this.vaccine,
    required this.date,
    required this.availableCapacityDose1,
    required this.availableCapacityDose2,
    required this.slots,
    required this.minAgeLimit,
  }) : super(key: key);

  final String name, address, date, vaccine;
  final int availableCapacityDose1, availableCapacityDose2, minAgeLimit;
  final List slots;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  minAgeLimit == 18 ? "$minAgeLimit+" : "$minAgeLimit+",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Text(
              address,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$vaccine",
                  style: TextStyle(
                    fontSize: 15,
                    color: vaccine == 'COVISHIELD'
                        ? Colors.blue
                        : Colors.pink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Dose 1 : $availableCapacityDose1",
                      style: TextStyle(
                        fontSize: 15,
                        color: availableCapacityDose1 == 0
                            ? Colors.red
                            : availableCapacityDose1 <= 50
                                ? Colors.orangeAccent
                                : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Dose 2 : $availableCapacityDose2",
                      style: TextStyle(
                        fontSize: 15,
                        color: availableCapacityDose2 == 0
                            ? Colors.red
                            : availableCapacityDose2 <= 50
                                ? Colors.orangeAccent
                                : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
            child: Center(
              child: Wrap(
                children: slots.map((slot) {
                  return Container(
                    margin: const EdgeInsets.all(7),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
