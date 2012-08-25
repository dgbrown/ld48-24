package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class Game extends FlxState 
	{
		
		private var _ground:FlxSprite;
		private var _player:FlxSprite;
		
		[Embed(source="../assets/images/sea_background.png")]
		private var _gfxBackground:Class;
		private var _bmdBackground:BitmapData;
		
		[Embed(source = "../assets/images/floor.png")]
		private var _gfxFloor:Class;
		private var _bmdFloor:BitmapData;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.mouse.hide();
			FlxG.bgColor = FlxG.BLUE;
			
			initializeGraphics();
			
			_ground = new FlxSprite( 0, FlxG.height - _bmdFloor.height, _gfxFloor );
			_ground.immovable = true;
			add( _ground );
			
			_player = new Player( FlxG.width * 0.15, 20 );
			add( _player );
		}
		
		public function initializeGraphics():void
		{
			_bmdBackground = FlxG.addBitmap( _gfxBackground, false, true );
			_bmdFloor = FlxG.addBitmap( _gfxFloor, false, false );
		}
		
		override public function draw():void 
		{
			FlxG.camera.buffer.copyPixels( _bmdBackground, _bmdBackground.rect, new Point() );
			super.draw();
		}
		
		override public function update():void 
		{
			FlxG.collide( _player, _ground );
			
			super.update();
		}
		
	}

}