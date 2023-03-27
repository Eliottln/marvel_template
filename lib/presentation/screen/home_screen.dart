import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:marvel_app/data/model/character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewModel.buildWithProvider(
      builder: (_, __) => HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              if (scrollEnd.metrics.pixels ==
                  scrollEnd.metrics.maxScrollExtent) {
                homeViewModel.load();
              }
              return true;
            },
            child: FutureBuilder<List<Character>?>(
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
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
