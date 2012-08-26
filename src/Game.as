package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	import flash.utils.getTimer;
	
	public class Game extends FlxState 
	{
	
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
		private var _corals:FlxGroup;
		private var _steamvents:FlxGroup;
		
		private var _ground:FlxSprite;
		private var _player:Player;
		private var _harvestHint:Hint;
		
		private var _txtSeaweed:FlxText;
		private var _txtMinerals:FlxText;
		private var _scoreBackground:FlxSprite;
		private var _heartBar:HeartBar;
		
		private var _playerLastHurtMark:Number;
		
		private var _touchableResourceNode:ResourceNode;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.mouse.hide();
			FlxG.bgColor = FlxG.BLUE;
			_playerLastHurtMark = 0;
			
			initializeGraphics();
			
			_terrain = new FlxTilemap();
			_terrain.loadMap( FlxTilemap.bitmapToCSV( _bmdLevel ), _gfxTilesetSeabed, 8, 8, FlxTilemap.AUTO );
			_terrain.allowCollisions = FlxObject.ANY;
			add( _terrain );
			
			generateSeaweeds();
			generateCorals();
			generateSteamvents();
			
			_player = new Player( FlxG.width * 0.15, 20 );
			add( _player );
			
			// ui elements
			_harvestHint = new Hint( 0, 0, "Press E to harvest!" );
			add( _harvestHint );
			_scoreBackground = new FlxSprite( 3, 3 );
			_scoreBackground.makeGraphic( 100, 30, 0x88000000 );
			_scoreBackground.scrollFactor.make( 0, 0 );
			add( _scoreBackground );
			_txtMinerals = new FlxText( 5, 5, 320, "Minerals 0 / 500" );
			_txtMinerals.setFormat( null, 8, 0x83F5F5, "left", 0x0EA7A7 );
			_txtMinerals.scrollFactor.make( 0, 0 );
			add( _txtMinerals );
			_txtSeaweed = new FlxText( 5, 18, 320, "Seaweed 0 / 500" );
			_txtSeaweed.setFormat( null, 8, 0x2CB82F, "left", 0x1D781F );
			_txtSeaweed.scrollFactor.make( 0, 0 );
			add( _txtSeaweed );
			_heartBar = new HeartBar( 3 );
			_heartBar.x = FlxG.width - _heartBar.width - 2;
			_heartBar.y = 2;
			add( _heartBar );
			
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
						
					var seaweed:ResourceNode = new ResourceNode( (seaweedXPos - 1) * 8 + 6, seaweedYPos * 8);
					_seaweeds.add( seaweed );
				}
			}
		}
		
		private function generateCorals():void
		{
			_corals = new FlxGroup();
			add( _corals );
			for ( var half:uint = 0; half < 1; ++half )
			{
				// place 3 in each half
				for ( var i:uint = 0; i < 3; ++i )
				{
					var xpos:uint = _terrain.widthInTiles * 0.5 * half + Math.random() * (_terrain.widthInTiles * 0.5 - 1);
					var ypos:uint = 0;
					while ( ypos < _terrain.heightInTiles - 1 && _terrain.getTileByIndex( ypos * _terrain.widthInTiles + xpos ) == 0 )
						ypos++;
						
					var coral:Coral = new Coral( (xpos - 1) * 8, ypos * 8 - 13 );
					_corals.add( coral );
				}
			}
		}
		
		private function generateSteamvents():void
		{
			_steamvents = new FlxGroup();
			add( _steamvents );
			for ( var half:int = 0; half <= 1; ++half )
			{
				// place 2 in each half
				for ( var i:int = 0; i < 2; ++i )
				{
					var xpos:uint = _terrain.widthInTiles * 0.5 * half + Math.random() * (_terrain.widthInTiles * 0.5 - 1);
					var ypos:uint = 0;
					while ( ypos < _terrain.heightInTiles - 1 && _terrain.getTileByIndex( ypos * _terrain.widthInTiles + xpos ) == 0 )
						ypos++;
						
					var steamvent:Steamvent = new Steamvent( (xpos - 1) * 8, ypos * 8 - 95 );
					_steamvents.add( steamvent );
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
			// reset collision related variables
			_touchableResourceNode = null;
			
			// collisions
			FlxG.collide( _player, _terrain );
			FlxG.overlap( _player, _seaweeds, playerTouchingResourceNode )
			FlxG.overlap( _player, _corals, playerTouchingDangerousProp );
			FlxG.overlap( _player, _steamvents, playerTouchingDangerousProp );
			
			// process input
			if ( _touchableResourceNode != null && _touchableResourceNode.isHarvestable )
			{
				_harvestHint.x = _player.x + _player.width * 0.5 - _harvestHint.width * 0.5;
				_harvestHint.y = _player.y - 20;
				_harvestHint.show();
				
				if ( FlxG.keys.justPressed("E") )
					_player.harvest( _touchableResourceNode );
			}
			else
				_harvestHint.hide();
				
			// update ui state
			_txtMinerals.text = "Minerals " + _player.nMinerals + " / " + Player.MAX_MINERALS;
			_txtSeaweed.text = "Seaweed " + _player.nSeaweed + " / " + Player.MAX_SEAWEED;
			_heartBar.hearts = _player.health;
			
			super.update();
		}
		
		private function playerTouchingDangerousProp( Obj1:FlxObject, Obj2:FlxObject ):void 
		{	
			var dangerousProp:DangerousProp = Obj2 as DangerousProp;
			if ( dangerousProp != null && dangerousProp.isDangerous )
			{
				var playerLastHurtDelta:Number = (getTimer() - _playerLastHurtMark) / 1000.0;
				if ( playerLastHurtDelta >= 2.0 )
				{
					_playerLastHurtMark = getTimer();
					
					_player.hurt( 1 );
					_player.flicker( 2 );
					
					var propOrigin:FlxPoint = new FlxPoint();
					if (	dangerousProp is Steamvent ) // push out right or left
					{
						propOrigin.x = dangerousProp.x;
						propOrigin.y = _player.y;
					}
					else
					{
						propOrigin.x = dangerousProp.x;
						propOrigin.y = dangerousProp.y;
					}
					var ang:Number = Math.atan2( propOrigin.y - _player.y, propOrigin.x - _player.x )
					_player.velocity.x = Math.cos( ang ) * -40;
					_player.velocity.y = Math.sin( ang ) * -40;
				}
			}
		}
		
		private function playerTouchingResourceNode( Obj1:FlxObject, Obj2:FlxObject ):void
		{
			var resourceNode:ResourceNode = Obj2 as ResourceNode;
			if ( _touchableResourceNode == null )
				_touchableResourceNode = resourceNode;
		}
		
	}

}