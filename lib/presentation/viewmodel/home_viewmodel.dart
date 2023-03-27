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

  HomeViewModel._(this._connectivityServive, {required this.characterEndpoint});

  static ChangeNotifierProvider<HomeViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child}) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => HomeViewModel._(
        injector<ConnectivityServive>(),
        characterEndpoint: injector<CharacterEndpoint>(),
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  Future<List<Character>?> load() async {
    try {
      final responseDto = await characterEndpoint.getCharacters();
      final charactersJson = responseDto.data['results'] as List<dynamic>;
      final characters = charactersJson.map((json) => Character.fromJson(json)).toList();
    return characters;
    } catch (e) {
      rethrow;
    }
  }
}
