import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/models/prediction_odds_item.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/prediction_widgets.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class PredictionsTab extends StatelessWidget {
  final int fixtureId;

  const PredictionsTab({Key? key, required this.fixtureId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        if (state is PredictionLoading) {
          return LoadingWidget(message: 'Loading match predictions...');
        } else if (state is PredictionError) {
          return ErrorDisplayWidget(
            message: 'Failed to load predictions: ${state.message}',
            onRetry: () {
              // Retry loading predictions
              context.read<PredictionBloc>().add(
                    FetchMatchPredictionEvent(matchId: fixtureId),
                  );
            },
          );
        } else if (state is PredictionLoaded) {
          // Get prediction data but we'll use dynamic data for the UI later if needed
          // final prediction = state.prediction;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Match Winner Section
                buildPredictionSection(
                  context,
                  title: "Match Winner",
                  icon: Icons.help_outline,
                  children: [
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "1",
                          odd: "2.57",
                          percentage: "41%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "X",
                          odd: "3.2",
                          percentage: "26%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "2",
                          odd: "2.6",
                          percentage: "33%",
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Double Chance Section
                buildPredictionSection(
                  context,
                  title: "Double Chance",
                  icon: Icons.help_outline,
                  children: [
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "1X",
                          odd: "1.46",
                          percentage: "40%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "12",
                          odd: "1.32",
                          percentage: "79%",
                          isSelected: true,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "2X",
                          odd: "1.47",
                          percentage: "84%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Both Teams Score Section
                buildPredictionSection(
                  context,
                  title: "Both Teams Score",
                  icon: Icons.help_outline,
                  children: [
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "YES",
                          odd: "1.87",
                          percentage: "38%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "NO",
                          odd: "1.84",
                          percentage: "62%",
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Goals Over/Under Section
                buildPredictionSection(
                  context,
                  title: "Goals Over/Under",
                  icon: Icons.help_outline,
                  children: [
                    // First Row
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 0.5",
                          odd: "1.05",
                          percentage: "91%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Under 0.5",
                          odd: "7.95",
                          percentage: "9%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Over 1.5",
                          odd: "1.37",
                          percentage: "71%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Second Row
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Under 1.5",
                          odd: "2.85",
                          percentage: "29%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Over 2.5",
                          odd: "2.15",
                          percentage: "45%",
                          isSelected: true,
                        ),
                        PredictionOddsItem(
                          label: "Under 2.5",
                          odd: "1.64",
                          percentage: "55%",
                          isSelected: false,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Third Row
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 3.5",
                          odd: "3.94",
                          percentage: "24%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 3.5",
                          odd: "1.21",
                          percentage: "76%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Over 4.5",
                          odd: "8.09",
                          percentage: "11%",
                          isSelected: false,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Fourth Row
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Under 4.5",
                          odd: "1.05",
                          percentage: "89%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                        PredictionOddsItem(
                          label: "Over 5.5",
                          odd: "15.81",
                          percentage: "4%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 5.5",
                          odd: "1.02",
                          percentage: "96%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Fifth Row
                    buildOddsRow(
                      context,
                      items: [
                        PredictionOddsItem(
                          label: "Over 6.5",
                          odd: "41",
                          percentage: "2%",
                          isSelected: false,
                        ),
                        PredictionOddsItem(
                          label: "Under 6.5",
                          odd: "1",
                          percentage: "98%",
                          isSelected: false,
                          showHighlight: true,
                          highlightColor: Colors.green,
                        ),
                      ],
                      itemCount: 2,
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Legend Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLegendItem(context,
                          color: Colors.purple.shade300,
                          text: "The match is not finished yet"),
                      SizedBox(height: 12),
                      buildLegendItem(context,
                          color: Colors.purple, text: "Optimal"),
                      SizedBox(height: 12),
                      buildLegendItem(context,
                          color: Colors.green,
                          text:
                              "The match is over and the prediction was correct"),
                      SizedBox(height: 12),
                      buildLegendItem(context,
                          color: Colors.red.shade400,
                          text:
                              "The match is over and the prediction was wrong"),
                      SizedBox(height: 24),
                      buildLegendRowItem(context,
                          label: "1X", text: "Prediction type"),
                      SizedBox(height: 12),
                      buildLegendRowItem(context,
                          label: "85%", text: "Probability according to AI"),
                      SizedBox(height: 12),
                      buildLegendRowItem(context,
                          label: "1.34", text: "Average odd"),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is PredictionError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text('Error loading predictions: ${state.message}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PredictionBloc>().add(
                          FetchMatchPredictionEvent(matchId: fixtureId),
                        );
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Center(child: Text('No predictions available'));
      },
    );
  }
}
