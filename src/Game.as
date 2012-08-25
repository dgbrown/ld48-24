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
		[Embed(source="../assets/images/level.png")]
		private var _gfxLevel:Class;
		private var _bmdLevel:BitmapData;
		[Embed(source = "../assets/images/autotiles.png")]
		private var _gfxTilesetSeabed:Class;
		
		private var _terrain:FlxTilemap;
		
		private var _seaweeds:FlxGroup;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.mouse.hide();
			FlxG.bgColor = FlxG.BLUE;
			
			initializeGraphics();
			
			/*
			_ground = new FlxSprite( 0, FlxG.height - _bmdFloor.height, _gfxFloor );
			_ground.immovable = true;
			add( _ground );
			*/
			
			_terrain = new FlxTilemap();
			_terrain.loadMap( FlxTilemap.bitmapToCSV( _bmdLevel ), _gfxTilesetSeabed, 8, 8, FlxTilemap.AUTO );
			_terrain.allowCollisions = FlxObject.ANY;
			add( _terrain );
			
			generateSeaweeds();
			
			_player = new Player( FlxG.width * 0.15, 20 );
			add( _player );
			
			FlxG.camera.follow( _player );
			_terrain.follow( FlxG.camera );
		}
		
		private function generateSeaweeds():void
		{
			_seaweeds = new FlxGroup();
			add( _seaweeds );
			for ( var half:uint = 0; half <= 1; ++half )
			{
				// place 5 in each half
				for ( var i:uint = 0; i < 5; ++i )
				{
					var seaweedXPos:uint = _terrain.widthInTiles * 0.5 * half + Math.random() * (_terrain.widthInTiles * 0.5 - 1);
					var seaweedYPos:uint = 0;
					while ( seaweedYPos < _terrain.heightInTiles - 1 && _terrain.getTileByIndex( seaweedYPos * _terrain.widthInTiles + seaweedXPos ) == 0 )
						seaweedYPos++;
						
					var seaweed:ResourceNode = new ResourceNode( (seaweedXPos - 1) * 8 + 4, seaweedYPos * 8);
					_seaweeds.add( seaweed );
				}
			}
		}
		
		public function initializeGraphics():void
		{
			_bmdBackground = FlxG.addBitmap( _gfxBackground, false, true );
			_bmdFloor = FlxG.addBitmap( _gfxFloor, false, false );
			_bmdLevel = FlxG.addBitmap( _gfxLevel, false, false );
		}
		
		override public function draw():void 
		{
			FlxG.camera.buffer.copyPixels( _bmdBackground, _bmdBackground.rect, new Point() );
			super.draw();
		}
		
		override public function update():void 
		{
			FlxG.collide( _player, _terrain );
			super.update();
		}
		
	}

}