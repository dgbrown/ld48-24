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
		private var _player:Player;
		private var _harvestHint:Hint;
		
		[Embed(source="../assets/images/sea_background.png")]
		private var _gfxBackground:Class;
		private var _bmdBackground:BitmapData;
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
			
			_terrain = new FlxTilemap();
			_terrain.loadMap( FlxTilemap.bitmapToCSV( _bmdLevel ), _gfxTilesetSeabed, 8, 8, FlxTilemap.AUTO );
			_terrain.allowCollisions = FlxObject.ANY;
			add( _terrain );
			
			generateSeaweeds();
			
			_player = new Player( FlxG.width * 0.15, 20 );
			add( _player );
			
			// ui elements
			_harvestHint = new Hint( 0, 0, "Press E to harvest!" );
			add( _harvestHint );
			
			// setup camera
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
			_bmdLevel = FlxG.addBitmap( _gfxLevel, false, false );
		}
		
		override public function draw():void 
		{
			FlxG.camera.buffer.copyPixels( _bmdBackground, _bmdBackground.rect, new Point() );
			super.draw();
		}
		
		override public function update():void 
		{
			_harvestHint.hide();
			
			FlxG.collide( _player, _terrain );
			FlxG.overlap( _player, _seaweeds, playerTouchingResourceNode )
			
			super.update();
		}
		
		private function playerTouchingResourceNode( Obj1:FlxObject, Obj2:FlxObject ):void
		{
			var resourceNode:ResourceNode = Obj2 as ResourceNode;
			
			_harvestHint.x = _player.x + _player.width * 0.5 - _harvestHint.width * 0.5;
			_harvestHint.y = _player.y - 20;
			_harvestHint.show();
			_player.harvest( resourceNode );
		}
		
	}

}