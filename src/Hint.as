package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Derek brown
	 */
	public class Hint extends FlxSprite 
	{
		private var _background:FlxSprite;
		private var _txtHint:FlxText;
		
		public function Hint( X:Number, Y:Number, HintText:String = "Press E to perform action!" ) 
		{
			super( X, Y );
			visible = false;
			
			_txtHint = new FlxText( X+2, Y, 6*HintText.length, HintText );
			_txtHint.size = 8;
			_txtHint.alignment = "center";
			
			width = _txtHint.frameWidth;
			height = _txtHint.frameHeight;
			
			_background = new FlxSprite( X, Y );
			_background.makeGraphic( width , height, 0x88000000 );
		}
		
		public function show():void
		{
			visible = true;
		}
		
		override public function draw():void 
		{
			_background.draw();
			_txtHint.draw();
		}
		
		override public function update():void 
		{
			super.update();
			_background.x = x;
			_background.y = y;
			_txtHint.x = x;
			_txtHint.y = y;
		}
		
		public function hide():void
		{
			visible = false;
		}
		
	}

}