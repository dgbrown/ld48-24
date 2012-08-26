package  
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.FileReferenceList;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class HeartBar extends FlxObject 
	{
		
		private var _heartIcons:Vector.<HeartIcon>;
		public var hearts:uint;
		private var _maxHearts:uint;
		
		private var _bmdBackground:BitmapData;
		
		public function HeartBar( MaxHearts:uint ) 
		{	
			_maxHearts = MaxHearts;
			hearts = _maxHearts;
			
			_heartIcons = new Vector.<HeartIcon>();
			for ( var i:uint = 0; i < MaxHearts; i++ )
			{
				var heartIcon:HeartIcon = new HeartIcon();
				heartIcon.scrollFactor.make( 0, 0 );
				heartIcon.displayFull();
				_heartIcons.push( heartIcon );
			}
			
			super( 0, 0, 2 + 17 * MaxHearts, 15 + 4 );
			
			_bmdBackground = new BitmapData( width, height, true, 0x88000000 );
			
			scrollFactor.make( 0, 0 );
		}
		
		public function updateStates():void
		{
			for ( var i:int = _maxHearts - 1; i >= 0; --i )
			{
				var heartIcon:HeartIcon = _heartIcons[i];
				if ( i >= _maxHearts - hearts )
					heartIcon.displayFull();
				else
					heartIcon.displayEmpty();
			}
		}
		
		public function updatePositions():void
		{
			for ( var i:uint = 0; i < _maxHearts; i++ )
			{
				var heartIcon:HeartIcon = _heartIcons[i];
				heartIcon.y = y + 2;
				heartIcon.x = x + 2 + (heartIcon.width + 2) * i;
			}
		}
		
		override public function update():void 
		{
			super.update();
			updateStates();
			updatePositions();
		}
		
		override public function draw():void 
		{
			//FlxG.camera.buffer.draw( _bmdBackground, new Matrix( 1, 0, 0, 1, x, y ) );
			for ( var i:uint = 0; i < _maxHearts; ++i )
			{
				_heartIcons[i].drawFrame();
				_heartIcons[i].draw();
			}
		}
		
	}

}