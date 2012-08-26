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
		
		public static const JUMP_POWER:Number = 20.0;
		public static const MAX_JUMP_CHARGE_BONUS:Number = 20.0;
		
		public static const MAX_MINERALS:uint = 200;
		public static const MAX_SEAWEED:uint = 500;
		
		private var _jumpKeyMark:int;
		private var _jumpKeyDelta:Number;
		private var _maxJumpKeyDelta:Number;
		
		public var nSeaweed:uint;
		public var nMinerals:uint;
		
		public function Player( X:Number = 0, Y:Number = 0 )
		{
			super( X, Y );
			makeGraphic( 15, 24, 0xFFFFDF2D, true );
			acceleration.y = 20;
			maxVelocity.y = 50;
			maxVelocity.x = 35;
			_maxJumpKeyDelta = 1.5;
			
			health = 3;
			
			nMinerals = 0;
			nSeaweed = 0;
		}
		
		public function harvest( Node:ResourceNode ):void
		{
			if( Node.isHarvestable )
				nSeaweed += Node.harvest( 25 );
		}
		
		override public function update():void 
		{
			// calculate custom control variables
			if ( FlxG.keys.justPressed( "SPACE" ) )
				_jumpKeyMark = getTimer();
			
			if ( touching&FLOOR && ( FlxG.keys.SPACE || FlxG.keys.justReleased("SPACE") ) )
			{
				_jumpKeyDelta = ( getTimer() - _jumpKeyMark ) / 1000.0; // number of seconds jump key was held
				if ( _jumpKeyDelta > 1.5 || FlxG.keys.justReleased( "SPACE" ) )
				{
					if ( _jumpKeyDelta > 1.5 )
						_jumpKeyDelta = 1.5 ;
						
					velocity.y -= JUMP_POWER + MAX_JUMP_CHARGE_BONUS * _jumpKeyDelta;
					
					_jumpKeyDelta = 0;
				}
			}
			else
			{
				_jumpKeyDelta = 0;
				_jumpKeyMark = getTimer();
			}
			
			// adjust physics
			drag.x = touching&FLOOR ? 60 : 5;
			
			// apply physics based on control input
			var moveSpeed:Number = (touching&FLOOR) ? 5 : 1;
			velocity.x += FlxG.keys.RIGHT ? moveSpeed : FlxG.keys.LEFT ? -moveSpeed : 0;

			super.update();
		}
		
		override public function draw():void 
		{
			centerOffsets();
			super.draw();
			
			var jumpPower:Number = ( _jumpKeyDelta / _maxJumpKeyDelta );
			var nPixels:uint = height * jumpPower;
			// yellow 0xFFFF55 --> green 0x00FF00
			var lineColor:uint = ((0xFF*(1-jumpPower))<<16) + ((0xFF*(1-jumpPower)+0xFF*jumpPower)<<8) + (0x55*(1-jumpPower)); //(red)+(green)+(blue);
			
			for ( var i:uint = 1; i <= nPixels; i++ )
			{
				FlxG.camera.buffer.setPixel( x - 2 - FlxG.camera.scroll.x, y + height - i, lineColor );
			}
		}
		
	}

}