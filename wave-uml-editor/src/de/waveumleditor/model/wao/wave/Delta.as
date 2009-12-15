package de.waveumleditor.model.wao.wave
{
	public class Delta
	{
		public static const IDS_SEPERATOR:String = "_";
		
		private var delta:Object;
		
		public function Delta()
		{
			delta = new Object();
		}
		
		public function setValue(key:String, value:String):void
		{
			delta[key]= value;
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