package tilemapgen;

/**
 * ...
 * @author lordkryss
 */
class LevelGenerator
{
	public var chanceToStartAlive:Float;
	public var minToSetAlive:Int;
	public var deathLimit:Int;


	public function new(chanceToStartAlive:Float = 0.4,minToSetAlive = 4,deathLimit = 4) 
	{
		this.chanceToStartAlive = chanceToStartAlive;
		this.minToSetAlive = minToSetAlive;
		this.deathLimit = deathLimit;
	}
	
	public function getMap(width:Int = 40, height:Int = 40, steps:Int = 3, forceBorder:Bool = false ):Map2d
	{
		var map = new Map2d(width, height);
		randomize(map);
		for (i in 0...steps)
		{
			map = doStep(map, minToSetAlive, deathLimit);
			if (forceBorder)
			{
				putBorder(map);
			}
		}
		return map;
	}
	
	public function putBorder(map:Map2d) 
	{
		var w:Int = map.width;
		var h:Int = map.height;
		for (x in 0...w)
		{
			map.set(x, 0, 1);
			map.set(x, h-1, 1);
		}
		for (y in 0...h)
		{
			map.set(0, y, 1);
			map.set(w-1, y, 1);
		}
	}
	
	function doStep(map:Map2d, minToSetAlive:Int, deathLimit:Int) 
	{
		var newMap = new Map2d(map.width, map.height);
		for (x in 0...map.width)
		{
			for (y in 0...map.height)
			{
				var nbAlive = countAliveNeighbours(map, x, y);

				if (map.get(x, y)== 1 )
				{
					newMap.set(x, y, nbAlive<deathLimit ? 0 : 1);
				}else
				{
					newMap.set(x, y, nbAlive > minToSetAlive ? 1 : 0);
				}
			}
		}
		map = newMap;
		return newMap;
	}
	
	function randomize(map) 
	{
		for (x in 0...map.width)
		{
			for (y in 0...map.height)
			{
				map.set(x,y, (Math.random() < chanceToStartAlive) ? 1 : 0);
			}
		}
	}
	
	public static function countAliveNeighbours(map:Map2d, x:Int, y:Int):Int
	{
		var count:Int = 0;
		for(i in -1...2)
		{
			for(j in -1...2)
			{
				if(i!=0 || j!=0)
					count += checkTile(map, i+x, j + y);
			}
		}
		return count;
	}
	
	static private function checkTile(map:Map2d, x:Int, y:Int) :Int
	{
		if (x < 0 || y < 0 || x >= map.width || y >= map.height || map.get(x, y) != 0)
			return 1;
		else
			return 0;
	}

}