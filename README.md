tilemapgen
==========

Basic tilemap generation based on http://gamedev.tutsplus.com/tutorials/implementation/cave-levels-cellular-automata/

Demo here: http://npretto.github.io/tilemapgen/ (really bad) source of the demo in example/

How to use
==========
```
var generator = new LevelGenerator();
var map:Map2d = generator.getMap(50, 50);
```

Example use on haxeflixel:

```
var generator = new LevelGenerator();
map = generator.getMap(widthInTiles, heightInTiles);
tilemap = new MyTilemap();
tilemap.widthInTiles = widthInTiles;
tilemap.heightInTiles = heightInTiles;
tilemap.loadMap(
	map.to2d(),
	"assets/img/autotiles.png",
	24,
	24,
	FlxTilemap.AUTO,
	1,
	0,
	1
);
```
