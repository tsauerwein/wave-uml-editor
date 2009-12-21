package de.tests
{
	import com.nextgenapp.wave.gadget.WaveState;

	public class TestUtil
	{
		/**
		 * Checks if the searchItem is part of the text.
		 * 
		 * @param text The string in which we search
		 * @param searchTerm The string to look for
		 * @return True - if searchTerm is part of text
		 */
		public static function contains(text:String, searchTerm:String):Boolean
		{
			return text.indexOf(searchTerm) > -1;
		}
		
		public static function printTrace(state:WaveState):void
		{
			var keys:Array = state.getKeys();
			
			for (var i:int = 0; i < keys.length; i++)
			{
				var key:String = keys[i];
				trace(key + " = " + state.getStringValue(key));
			}
		}
	}
}