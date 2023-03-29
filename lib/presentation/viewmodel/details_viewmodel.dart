import 'package:flutter/widgets.dart';
import 'package:marvel_app/data/dto/response_dto.dart';
import 'package:marvel_app/data/endpoint/characters_endpoint.dart';
import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/infrastructure/injections/injector.dart';
import 'package:marvel_app/infrastructure/services/connectivity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/screen/details_screen.dart';

class DetailsViewModel extends ChangeNotifier {
  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive _connectivityServive;
  bool isLoading = true;
  int id = 0;
  Character character = Character();

  DetailsViewModel._(this._connectivityServive,
      {required this.characterEndpoint, required this.id});

  static ChangeNotifierProvider<DetailsViewModel> buildWithProvider(
      {required Widget Function(BuildContext context, Widget? child)? builder,
      Widget? child,
      required int characterId}) {
    return ChangeNotifierProvider<DetailsViewModel>(
      create: (BuildContext context) => DetailsViewModel._(
        injector<ConnectivityServive>(),
        characterEndpoint: injector<CharacterEndpoint>(),
        id: characterId,
      )..load(),
      builder: builder,
      lazy: false,
      child: child,
    );
  }

  Future<void> load() async {
    try {
      final responseDto = await characterEndpoint.getCharacterById(id);
      final charactersJson = responseDto.data['results'] as List<dynamic>;
      character = charactersJson.map((json) => Character.fromJson(json)).first;
      isLoading = !isLoading;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
