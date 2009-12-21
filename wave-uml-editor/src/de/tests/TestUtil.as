package de.tests
{
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
	}
}