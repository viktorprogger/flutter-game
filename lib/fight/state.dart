import 'package:flutter/foundation.dart';
import 'package:game/fight/map.dart';

class FightBoardState extends ChangeNotifier {
  final FightBoardMap _map;
  List<MapTile> _pressed = [];
  Map<MapTile, int> _offsets = {};

  FightBoardState(this._map);

  bool isPressed(MapTile tile) {
    return _pressed.contains(tile);
  }

  void removeMonsterStart(MapTile tile) {
    _offsets[tile] = 1;
  }

  int getMoveOffset(MapTile tile) {
    return 0;
  }
}