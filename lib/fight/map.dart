class Map {
  late List<List<MapTile>> tiles;

  Map(this.tiles);

  Map.generate({required int width, required int height}) {
    tiles = List.generate(height,
            (x) => List.generate(width, (y) => MapTile(x, y, TileType.GROUND)));
  }
}

enum TileType {
  GROUND,
  // Here will be some more: rocks, water, etc.
}

class MapTile {
  final int x;
  final int y;
  final type;

  MapTile(this.x, this.y, this.type);
}
