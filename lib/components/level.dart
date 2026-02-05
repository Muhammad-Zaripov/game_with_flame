import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_with_flame/components/player.dart';

class Level extends World {
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  final String levelName;
  late Player player;
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          // final player = Player(
          //   // character: 'Mask Dude',
          //   position: Vector2(spawnPoint.x, spawnPoint.y),
          // );
          player.position = Vector2(spawnPoint.x, spawnPoint.y);

          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
