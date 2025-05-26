import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/prediction.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';
import 'package:football_live_app/presentation/widgets/loading_indicator.dart';
import 'package:football_live_app/presentation/widgets/prediction_card.dart';

class PredictionsTab extends StatefulWidget {
  const PredictionsTab({Key? key}) : super(key: key);

  @override
  State<PredictionsTab> createState() => _PredictionsTabState();
}

class _PredictionsTabState extends State<PredictionsTab> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadPredictions();
    _scrollController.addListener(_onScroll);
  }

  void _loadPredictions() {
    // Use the PredictionBloc that's provided by the parent widget
    context.read<PredictionBloc>().add(FetchMultipleMatchPredictionsEvent());
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      setState(() {
        _isLoadingMore = true;
      });

      // For pagination, we'll just reload the predictions for now
      context.read<PredictionBloc>().add(FetchMultipleMatchPredictionsEvent());

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        if (state is PredictionInitial || state is PredictionLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is PredictionError) {
          return ErrorView(
            message: state.message,
            onRetry: _loadPredictions,
          );
        } else if (state is PredictionLoaded && state.prediction != null) {
          // Single prediction case
          return _buildPredictionList([state.prediction!]);
        } else if (state is MultiPredictionLoaded) {
          // Multiple predictions case
          return _buildPredictionList(state.predictions);
        } else {
          return const Center(
            child: Text('No predictions available'),
          );
        }
      },
    );
  }

  Widget _buildPredictionList(List<Prediction> predictions) {
    if (predictions.isEmpty) {
      return const Center(
        child: Text('No predictions available'),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _loadPredictions();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: predictions.length + (_isLoadingMore ? 1 : 0),
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          if (index == predictions.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return PredictionCard(prediction: predictions[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
