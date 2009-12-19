package de.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.Variable;
	
	public class WAOVariable
	{
		public static const TYPE:String = "t";
		public static const NAME:String = "n";
		public static const DEFAULT:String = "d";
		
		/**
		 * Returns a plain object that represents a variable and that
		 * can be encoded as JSON-String.
		 */ 
		public static function getEncodableObject(variable:Variable):Object
		{
			var variableData:Object = new Object();
			
			variableData[NAME] = variable.getName();
			variableData[DEFAULT] = variable.getDefaultValue();
			variableData[TYPE] = WAOType.getEncodableObject(variable.getType());
			
			return variableData;
		}

	}
}