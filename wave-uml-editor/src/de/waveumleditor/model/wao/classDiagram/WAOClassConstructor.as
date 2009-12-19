package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import mx.collections.IList;
	
	public class WAOClassConstructor
	{
		public static const VISIBILITY:String = "vi";
		public static const PARAMETERS:String = "p";
		
		public static function store(delta:Delta, nodeId:String, constructor:ClassConstructorMethod):void
		{
			var constructorData:Object = getEncodableObject(constructor);
			
			var json:String = JSON.encode(constructorData);
			
			trace(json);
			
			var key:String = nodeId + Delta.IDS_SEPERATOR + constructor.getIdentifier().getId();
			delta.setValue(key, json);
		}
		
		/**
		 * Returns a plain object that represents a constructor and that
		 * can be encoded as JSON-String.
		 */ 
		public static function getEncodableObject(constructor:ClassConstructorMethod):Object
		{
			var constructorData:Object = new Object();
			
			// build an object that be encoded as JSON
			constructorData[VISIBILITY] = constructor.getVisibility().getValue();
			
			var parameters:IList = constructor.getVariables();
			var parametersData:Array = new Array(parameters.length);
			for(var i:int = 0; i < parameters.length; i++)
			{
				var parameter:Variable = parameters.getItemAt(i) as Variable;
				parametersData[i] = WAOVariable.getEncodableObject(parameter);
			}
			constructorData[PARAMETERS] = parametersData;
			
			return constructorData;
		}
		
		public static function remove(delta:Delta, nodeId:String, constructorId:String):void
		{
			WAOClassAttribute.remove(delta, nodeId, constructorId);
		}
	}
}