package de.waveumleditor.model
{
	public class Position
	{
		private var x:int;
		private var y:int;
		
		public function Position(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
		
		public function getX():int 
		{
			return this.x;
		}
		
		public function getY():int 
		{
			return this.y;
		}
		
		public function toString():String
		{
			return x + ":" + y;
		}
	}
}