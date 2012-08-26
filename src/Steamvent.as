package  
{
	
	import org.flixel.*;
	
	public class Steamvent extends DangerousProp 
	{
		
		[Embed(source = "../assets/images/seavent.png")]
		private var _gfxSteamvent:Class;
		
		public function Steamvent(X:Number=0, Y:Number=0) 
		{
			super(X, Y);
			loadGraphic( _gfxSteamvent, true, false, 13, 80 );
			addAnimation( "idle", [ 0 ], 20, true  );
			addAnimation( "warning", [ 1, 2 ], 4, true );
			addAnimation( "raising", [ 3, 4, 5, 6, 7 ], 10, false );
			addAnimation( "full", [ 8, 7 ], 4, true );
			addAnimation( "falling", [ 6, 5, 5, 4, 4, 3, 3 ], 20, false );
			addAnimationCallback( animationCallback );
			displayIdle();
			scale.make(1.5, 1.5);
		}
		
		private function displayIdle():void
		{
			play("idle",true);
			isDangerous = false;
			var idleTimer:FlxTimer = new FlxTimer();
			idleTimer.start( 2, 1, displayIdleTimerComplete );
		}
		
		private function displayIdleTimerComplete( timer:FlxTimer ):void { displayWarning(); }
		private function displayWarning():void
		{
			play("warning",true);
			var warningTimer:FlxTimer = new FlxTimer();
			warningTimer.start( 2, 1, displayWarningTimerComplete );
		}
		
		private function displayFull():void
		{
			play("full",true);
			var fullTimer:FlxTimer = new FlxTimer();
			fullTimer.start( 4, 1, displayFullTimerComplete );
		}
		
		private function displayWarningTimerComplete( timer:FlxTimer ):void { displayRaising(); }
		private function displayRaising():void
		{
			play("raising",true);
			isDangerous = true;
		}
		
		private function displayFullTimerComplete( timer:FlxTimer ):void { displayFalling(); }
		private function displayFalling():void
		{
			play("falling",true);
		}
		
		private function animationCallback( AnimName:String, FrameNumber:uint, FrameIndex:uint ):void
		{
			if ( AnimName == "raising" && FrameNumber == 4 )
				displayFull();
			else if ( AnimName == "falling" && FrameNumber == 3 )
				displayIdle();
		}
		
	}

}