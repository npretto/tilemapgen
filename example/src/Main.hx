package ;

import com.bit101.components.HSlider;
import com.bit101.components.NumericStepper;
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.utils.CompressionAlgorithm;
import tilemapgen.LevelGenerator;
import tilemapgen.Map2d;

/**
 * ...
 * @author lordkryss
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	var generator:LevelGenerator;
	var sprite:Sprite;
	var numSteps:NumericStepper;
	var birthLimit:NumericStepper;
	var deathLimit:NumericStepper;
	var startChance:HSlider;
	
	var SIZE = 600;
	var chanceLabel:Label;
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		generator = new LevelGenerator();
		sprite = new Sprite();
		
		addChild(sprite);
		sprite.x = Lib.current.stage.stageWidth / 2 - SIZE/2;
		sprite.y = Lib.current.stage.stageHeight-SIZE-20;
		stage.color = 0xFFafafaf;
		
		//renderTilemap(sprite, generator.getMap(30, 30, 3));
		
		new Label(this, 10, 10, "Number of steps:");
		numSteps = new NumericStepper(this, 100, 10, update);
		numSteps.value = 3;
		numSteps.step = 1;
		numSteps.maximum = 1000;
		numSteps.minimum = 0;
		
		new Label(this, 10, 30, "Birth Limit:");
		birthLimit = new NumericStepper(this, 100, 30, update);
		birthLimit.value = 4;
		birthLimit.step = 1;
		birthLimit.maximum = 1000;
		birthLimit.minimum = 1;
		
		new Label(this, 210, 10, "Death Limit:");
		deathLimit = new NumericStepper(this, 280, 10, update);
		deathLimit.value = 3;
		deathLimit.step = 1;
		deathLimit.maximum = 1000;
		deathLimit.minimum = 1;
		
		chanceLabel =new Label(this, 210, 30, "Chance to start alive:");
		startChance = new HSlider(this, 210, 50, update);
		startChance.value = 0.4;
		startChance.maximum = 1;
		startChance.minimum = 0;		
		
		new PushButton(this, 500, 10, "GENERATE", generate);
		
		update(null);
		generate(null);
	}
	
	function generate(e:MouseEvent) 
	{
		renderTilemap(sprite, generator.getMap(50, 50, Std.int(numSteps.value)),SIZE,SIZE);
	}
	
	function update(e:Event) 
	{	
		chanceLabel.text = "Chance to start alive: " + startChance.value;
		generator.chanceToStartAlive = startChance.value;
		generator.deathLimit = Std.int(deathLimit.value);
		generator.minToSetAlive = Std.int(birthLimit.value);
	}
	
	
	function renderTilemap(sprite:Sprite, map:Map2d, width:Int = 300, height:Int = 300 ) 
	{
		var tileWidth = width / map.width;
		var tileHeigth = height / map.height;
		
		for (x in 0...map.width)
		{
			for (y in 0...map.height)
			{
				drawSquare(sprite, x * tileWidth, y * tileHeigth, tileWidth,tileHeigth, (map.get(x, y) == 0 ?  0xFF123456 : 0xFF000000));
			}
		}
	}
	
	function drawSquare(sprite:Sprite, x:Float, y:Float,width:Float,height:Float, color:UInt) 
	{
		var g:Graphics = sprite.graphics;
		g.beginFill(color);
		g.drawRect(x, y, width, height);
		g.endFill();
	}
	
	

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
