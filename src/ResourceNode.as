package  
{
	import org.flixel.FlxSprite;
	
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
			super( X, 0, _gfxSeaWeed );
			y = Y - height * 0.95; // fix offset
			
			quantity = MAX_QUANTITY;
			
			isHarvestable = true;
		}
		
		/// subtracts input amount from quantity (cannot go below zero), and returns amount subtracted
		public function harvest( Amount:uint = 1 ):uint
		{
			if ( quantity - Amount < 0 )
			{
				Amount += quantity - Amount; // adding a negative value
				quantity = 0;
				isHarvestable = false;
			}
			else
				quantity -= Amount;
			return Amount;
		}
	}

}