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
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return FutureBuilder<List<Character>?>(
            future: homeViewModel.load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final characters = snapshot.data!;
                  return ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return ListTile(
                        title: Text(character.name ?? "")
                      );
                    },
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
