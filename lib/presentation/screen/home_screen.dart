import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:marvel_app/data/model/character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewModel.buildWithProvider(
      builder: (_, __) => const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters')
      ),
      body: Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
        return SingleChildScrollView(
          controller: homeViewModel.scrollController,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeViewModel.isLoading
                    ? homeViewModel.characterList.length + 1
                    : homeViewModel.characterList.length,
                itemBuilder: (context, index) {
                  if (index == homeViewModel.characterList.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final character = homeViewModel.characterList[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        '${character.thumbnail?.path}.${character.thumbnail?.extension}',
                        height: 60,
                        width: 60,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.no_photography),
                      ),
                      title: Text(character.name ?? ""),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        homeViewModel.navigateToDetail(context, index);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
