tilemapgen
==========

Basic tilemap generation based on http://gamedev.tutsplus.com/tutorials/implementation/cave-levels-cellular-automata/
Demo here: http://lordkryss.github.io/tilemapgen/ (really bad) source of the demo in example/

How to use
==========
```haxe
var generator = new LevelGenerator();
var map:Map2d = generator.getMap(50, 50);
```

Example use on haxeflixel:

```haxe
var generator = new LevelGenerator();
		map = generator.getMap(widthInTiles, heightInTiles);
		tilemap = new MyTilemap();
		tilemap.widthInTiles = this.widthInTiles;
		tilemap.heightInTiles = this.heightInTiles;
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
