package  
{
	/**
	 * ...
	 * @author Derek brown
	 */
	public class Coral extends DangerousProp 
	{
		
		[Embed(source = "../assets/images/coral.png")]
		private var _gfxCoral:Class;
		
		public function Coral(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic( _gfxCoral );
		}
		
	}

}