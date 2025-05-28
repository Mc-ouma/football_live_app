import 'package:flutter/material.dart';
import 'package:football_live_app/presentation/pages/match_details/models/prediction_odds_item.dart';

/// Builds a section for predictions with title and children
Widget buildPredictionSection(BuildContext context,
    {required String title,
    required IconData icon,
    required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(width: 8),
            Icon(icon, color: Colors.grey, size: 20),
          ],
        ),
      ),
      SizedBox(height: 12),
      ...children,
    ],
  );
}

/// Builds a row of odds items with equal spacing
Widget buildOddsRow(
  BuildContext context, {
  required List<PredictionOddsItem> items,
  int itemCount = 3,
}) {
  return Row(
    children: [
      for (int i = 0; i < items.length; i++)
        Expanded(
          flex: 1,
          child: buildOddItem(context, items[i]),
        ),

      // Add empty boxes to fill the row if items.length < itemCount
      if (items.length < itemCount)
        for (int i = 0; i < itemCount - items.length; i++)
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
    ],
  );
}

/// Builds an individual odds item card
Widget buildOddItem(BuildContext context, PredictionOddsItem item) {
  final primaryColor = Theme.of(context).primaryColor;
  final backgroundColor =
      item.isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent;
  final borderRadius = BorderRadius.circular(8);
  final borderColor = item.isSelected ? primaryColor : Colors.grey.shade300;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              item.label,
              style: TextStyle(
                color: item.isSelected ? primaryColor : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),
          ),
          child: Column(
            children: [
              Text(
                item.odd,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (item.showHighlight)
                    Icon(
                      Icons.bolt,
                      color: item.highlightColor,
                      size: 14,
                    ),
                  SizedBox(width: item.showHighlight ? 4 : 0),
                  Text(
                    item.percentage,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a legend item with a colored box and description text
Widget buildLegendItem(BuildContext context,
    {required Color color, required String text}) {
  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}

/// Builds a legend row item with a labeled box and description text
Widget buildLegendRowItem(BuildContext context,
    {required String label, required String text}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
