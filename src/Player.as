package  
{
	import org.flixel.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class Player extends FlxSprite 
	{
		
		private var _jumpKeyMark:int;
		private var _jumpKeyDelta:Number;
		private var _maxJumpKeyDelta:Number;
		
		public function Player( X:Number = 0, Y:Number = 0 )
		{
			super( X, Y );
			makeGraphic( 15, 24, 0xFFFFDF2D, true );
			acceleration.y = 20;
			maxVelocity.y = 50;
			maxVelocity.x = 35;
			_maxJumpKeyDelta = 1.5;
		}
		
		override public function update():void 
		{
			// calculate custom control variables
			if ( FlxG.keys.justPressed( "SPACE" ) )
				_jumpKeyMark = getTimer();
			
			if ( touching & FLOOR && ( FlxG.keys.SPACE || FlxG.keys.justReleased("SPACE") ) )
			{
				_jumpKeyDelta = ( getTimer() - _jumpKeyMark ) / 1000.0; // number of seconds jump key was held
				if ( _jumpKeyDelta > 1.5 || FlxG.keys.justReleased( "SPACE" ) )
				{
					if ( _jumpKeyDelta > 1.5 )
						_jumpKeyDelta = 1.5 ;
						
					velocity.y -= 30.0 * _jumpKeyDelta;
					
					_jumpKeyDelta = 0;
				}
			}
			
			// adjust physics
			drag.x = touching&FLOOR ? 60 : 5;
			
			// apply physics based on control input
			velocity.x += !(touching&FLOOR) ? 0 : FlxG.keys.RIGHT ? 5 : FlxG.keys.LEFT ? -5 : 0;
			if ( FlxG.keys.justPressed("UP") && touching&FLOOR )
				velocity.y -= 10;
			
			super.update();
		}
		
		override public function draw():void 
		{
			super.draw();
			
			var jumpPower:Number = ( _jumpKeyDelta / _maxJumpKeyDelta );
			var nPixels:uint = height * jumpPower;
			// yellow 0xFFFF55 --> green 0x00FF00
			var lineColor:uint = ((0xFF*(1-jumpPower))<<16) + ((0xFF*(1-jumpPower)+0xFF*jumpPower)<<8) + (0x55*(1-jumpPower)); //(red)+(green)+(blue);
			
			for ( var i:uint = 1; i <= nPixels; i++ )
			{
				FlxG.camera.buffer.setPixel( x - 2, y + height - i, lineColor );
			}
		}
		
	}

}