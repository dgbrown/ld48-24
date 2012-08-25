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
		
		override public function create():void 
		{
			super.create();
			
			FlxG.mouse.hide();
			FlxG.bgColor = FlxG.BLUE;
			
			initializeGraphics();
			
			_ground = new FlxSprite( 0, FlxG.height - 50 );
			_ground.makeGraphic( 320, 50, 0xFF000000, true );
			_ground.immovable = true;
			add( _ground );
			
			_player = new FlxSprite( FlxG.width * 0.15, 20 );
			_player.makeGraphic( 15, 24, 0xFFFFDF2D, true );
			_player.acceleration.y = 20;
			_player.maxVelocity.y = 50;
			_player.maxVelocity.x = 35;
			// on ground player drag is 15
			// else drag is 1
			add( _player );
		}
		
		public function initializeGraphics():void
		{
			_bmdBackground = FlxG.addBitmap( _gfxBackground, false, true );
		}
		
		override public function draw():void 
		{
			FlxG.camera.buffer.copyPixels( _bmdBackground, _bmdBackground.rect, new Point() );
			super.draw();
		}
		
		override public function update():void 
		{
			FlxG.collide( _player, _ground );
			
			// adjust physics variables
			_player.drag.x = _player.touching ? 60 : 5;
			
			_player.velocity.x += !_player.touching ? 0 : FlxG.keys.RIGHT ? 5 : FlxG.keys.LEFT ? -5 : 0;
			if ( FlxG.keys.justPressed("UP") && _player.touching )
				_player.velocity.y -= 30;
			
			super.update();
		}
		
	}

}