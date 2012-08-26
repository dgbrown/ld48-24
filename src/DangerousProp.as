package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class DangerousProp extends FlxSprite 
	{
		
		public var isDangerous:Boolean;
		
		public function DangerousProp(X:Number=0, Y:Number=0) 
		{
			super(X, Y, null);
			makeGraphic( 28, 28, 0xFFFC8FEE );
			isDangerous = true;
		}
		
	}

}