package de.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.nodes.MType;
	
	public class WAOType
	{
		public static const NAME:String = "n";
		
		/**
		 * Returns a plain object that represents a type and that
		 * can be encoded as JSON-String.
		 */ 
		public static function getEncodableObject(type:MType):Object
		{
			var typeData:Object = new Object();
			
			typeData[NAME] = type.getName();
			
			return typeData;
		}
		
		/**
		 * Creates a Type object from a plain object that was
		 * decoced from a JSON-String.
		 */ 
		public static function getFromDecodedObject(obj:Object):MType
		{
			return new MType(obj[NAME]);
		}
	}
}