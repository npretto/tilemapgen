package tilemapgen;
import flash.geom.Point;

/**
 * ...
 * @author lordkryss
 */
class Map2d
{
	public var width:Int;
	public var height:Int;
	
	public static inline var COLLIDE_INDEX:Int = 1; //everything >= this is a wall
	

	private var m:Array<Array<Int>>;
	
	public function new(width:Int, height:Int)
	{
		this.width = width;
		this.height = height;
		m = getArray(width, height);
	}
	
	public function get(x:Int, y:Int):Int
	{
		return m[x][y];
	}
	
	public function set(x:Int, y:Int, value:Int)
	{
		m[x][y] = value;
	}
	
	private function getArray(width:Int, height:Int, whatTofillWith:Int = 0 ):Array<Array<Int>>
	{
		var a:Array<Array<Int>> = new Array<Array<Int>>();
		for (x in 0...width)
		{
			a[x] = new Array<Int>();
			for (y in 0...height)
			{
				a[x][y] = whatTofillWith;
			}
		}
		return a;
	}
	
	public function to2d():Array<Int> //inversed order, don't ask me why!
	{
		var array:Array<Int> = new Array<Int>();
		for (x in 0...width)
		{
			for (y in 0...height)
			{
				array.push(m[y][x]);
			}
		}
		return array;
	}
	
	public function isWalkable(x:Int, y:Int):Bool
	{
		if (x < 0 || y < 0 || x > width || y > height)
			return false;
		else
			return (get(x, y) < COLLIDE_INDEX );
	}
	
	public function findWalkable(x:Int, y:Int):Point
	{
		var p = new Point(x, y);
		while (!isWalkable(Std.int(p.x), Std.int(p.y)))
		{
			p.x += (Math.random() < 0.5 ? 1 : -1);
			p.y += (Math.random() < 0.5 ? 1 : -1);
		}
		return p;
	}
	
}