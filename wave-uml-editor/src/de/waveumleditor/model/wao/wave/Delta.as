package de.waveumleditor.model.wao.wave
{
	public class Delta
	{
		
		private var delta:Object;
		
		public function Delta()
		{
			delta = new Object();
		}
		
		public function setValue(key:String, value:String):void
		{
			delta[key]= value;
		}
		
		public function getWaveDelta():Object
		{
			return delta;
		}
		
		public function toString():String
		{
			var out:String = "";
			for (var key:String in delta)
			{
				out += key + " : " + delta[key] + " \n ";
			}
			
			return out;
		} 
	}
}