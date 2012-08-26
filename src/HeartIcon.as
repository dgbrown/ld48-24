package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class HeartIcon extends FlxSprite 
	{
		
		[Embed(source = "../assets/images/ui_heart.png")]
		private var _gfxHeart:Class;
		
		public function HeartIcon( X:Number = 0, Y:Number = 0 )
		{
			super( X, Y );
			loadGraphic( _gfxHeart, true, false, 15, 15, false );
			addAnimation( "empty", [0], 0, false );
			addAnimation( "full", [1], 0, false );
		}
		
		public function displayFull():void
		{
			play( "full", true );
		}
		
		public function displayEmpty():void
		{
			play("empty", true );
		}
		
	}

}