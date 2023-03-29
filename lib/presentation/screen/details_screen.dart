import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/viewmodel/details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:marvel_app/data/model/character.dart';

class DetailsScreen extends StatelessWidget {
  final int characterId;
  const DetailsScreen({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailsViewModel.buildWithProvider(
      builder: (_, __) => DetailsContent(characterId: characterId),
    );
  }
}

class DetailsContent extends StatelessWidget {
  final int characterId;
  const DetailsContent({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailsViewModel>(
          builder: (context, detailsViewModel, child) {
        return SingleChildScrollView(
          controller: detailsViewModel.scrollController,
          child: Column(
            children: [],
          ),
        );
      }),
    );
  }
}
