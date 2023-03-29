import 'package:flutter/widgets.dart';
import 'package:marvel_app/data/dto/response_dto.dart';
import 'package:marvel_app/data/endpoint/characters_endpoint.dart';
import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:marvel_app/infrastructure/services/connectivity_service.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive _connectivityServive;
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  List<Character> characterList = [];

  int _offset = 0;

  void initScroll() {
    scrollController.addListener(() {
      if (scrollController.offset >=
          (scrollController.position.maxScrollExtent * 0.9)) {
        if (!isLoading) {
          isLoading = !isLoading;
          notifyListeners();
          load();
        }
      }
    });
  }

  HomeViewModel._(this._connectivityServive, {required this.characterEndpoint});

  static ChangeNotifierProvider<HomeViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => HomeViewModel._(
        injector<ConnectivityServive>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      )
        ..load()
        ..initScroll(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  Future<void> load() async {
    try {
      final responseDto =
          await characterEndpoint.getCharacters(offset: _offset);
      final charactersJson = responseDto.data['results'] as List<dynamic>;
      final characters =
          charactersJson.map((json) => Character.fromJson(json)).toList();
      _offset = _offset + 20;
      characterList.addAll(characters);
      isLoading = !isLoading;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
