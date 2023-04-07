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
        characterId: characterId);
  }
}

class DetailsContent extends StatelessWidget {
  final int characterId;
  const DetailsContent({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informations')),
      body: Consumer<DetailsViewModel>(
        builder: (context, detailsViewModel, child) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        "${detailsViewModel.character.thumbnail?.path}.${detailsViewModel.character.thumbnail?.extension}",
                        height: 200,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.no_photography),
                      ),
                    ),
                    Center(
                      child: Text(
                        detailsViewModel.character.name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      detailsViewModel.character.description ?? "",
                      textAlign: TextAlign.justify,
                    ),
                    ExpansionTile(
                      title: const Text("Comics"),
                      children: [
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: detailsViewModel.comics.length,
                            itemBuilder: (context, index) {
                              if (index == detailsViewModel.comics.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final comics = detailsViewModel.comics[index];
                              return SizedBox(
                                width: 200,
                                child: Card(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        '${comics.thumbnail?.path}.${comics.thumbnail?.extension}',
                                        height: 90,
                                        width: 90,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.no_photography),
                                      ),
                                      Text(
                                        comics.title ?? "",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
