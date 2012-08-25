package 
{
	import org.flixel.*;
	import org.flixel.FlxGame;

	/**
	 * ...
	 * @author Derek brown
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		public function Main()
		{
			super( 320, 240, MainMenu, 2 ); 
		}
	}

}