package  
{
	import flash.utils.Timer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class ResourceNode extends FlxSprite 
	{
		public static const MAX_QUANTITY:uint = 50;
		public var quantity:uint;
		
		public var isHarvestable:Boolean;
		
		[Embed(source = "../assets/images/sea-weed.png")]
		private var _gfxSeaWeed:Class;
		
		public function ResourceNode( X:Number=0, Y:Number=0 ) 
		{
			super( X, 0 );
			width = 16;
			height = 79;
			y = Y - height + 13; // fix offset
			x = X - 4;
			
			loadGraphic( _gfxSeaWeed, true, false, 16, 70 );
			addAnimation( "full", [0, 2, 1, 2], 1, true );
			addAnimation( "half", [3, 5, 4, 5], 1, true );
			addAnimation( "empty", [6], 0, false );
			play("full");
			var randomizeAnimationTimer:FlxTimer = new FlxTimer();
			randomizeAnimationTimer.start( uint(Math.random() * 3), 1, randomizeAnimationTimerComplete );
			
			quantity = MAX_QUANTITY;
			
			isHarvestable = true;
		}
		
		private function randomizeAnimationTimerComplete( timer:FlxTimer ):void
		{
			if ( _curAnim.name == "full" )
				play("full", true);
		}
		
		/// subtracts input amount from quantity (cannot go below zero), and returns amount subtracted
		public function harvest( Amount:uint = 1 ):uint
		{
			if ( quantity - Amount <= 0 )
			{
				Amount += quantity - Amount; // adding a negative value
				quantity = 0;
				isHarvestable = false;
			}
			else
				quantity -= Amount;
			
			if ( quantity > MAX_QUANTITY * 0.5 )
				play( "full" );
			else if ( quantity > 0 )
				play("half");
			else
				play("empty");
			
				
			return Amount;
		}
	}

}