package de.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.Type;
	
	public class WAOType
	{
		public static const NAME:String = "n";
		
		/**
		 * Returns a plain object that represents a type and that
		 * can be encoded as JSON-String.
		 */ 
		public static function getEncodableObject(type:Type):Object
		{
			var typeData:Object = new Object();
			
			typeData[NAME] = type.getName();
			
			return typeData;
		}

	}
}