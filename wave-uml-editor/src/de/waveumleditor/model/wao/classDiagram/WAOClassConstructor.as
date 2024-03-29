package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import mx.collections.IList;
	
	/**
	 * This class maps ClassConstructorMethod objects into key-value-pairs, which are
	 * stored in the Wave state.
	 * 
	 * @see de.waveumleditor.model.classDiagram.ClassConstructorMethod
	 */ 
	public class WAOClassConstructor
	{
		public static const VISIBILITY:String = "vi";
		public static const PARAMETERS:String = "p";
		
		public static function store(delta:Delta, nodeId:String, constructor:MClassConstructorMethod):void
		{
			var constructorData:Object = getEncodableObject(constructor);
			
			var json:String = JSON.encode(constructorData);
			
			trace(json);
			
			var key:String = nodeId + WAOKeyGenerator.IDS_SEPERATOR + constructor.getIdentifier().getId();
			delta.setValue(key, json);
		}
		
		/**
		 * Returns a plain object that represents a constructor and that
		 * can be encoded as JSON-String.
		 */ 
		public static function getEncodableObject(constructor:MClassConstructorMethod):Object
		{
			var constructorData:Object = new Object();
			
			// build an object that be encoded as JSON
			constructorData[VISIBILITY] = constructor.getVisibility().getValue();
			
			var parameters:IList = constructor.getVariables();
			var parametersData:Array = new Array(parameters.length);
			for(var i:int = 0; i < parameters.length; i++)
			{
				var parameter:MVariable = parameters.getItemAt(i) as MVariable;
				parametersData[i] = WAOVariable.getEncodableObject(parameter);
			}
			constructorData[PARAMETERS] = parametersData;
			
			return constructorData;
		}
		
		public static function remove(delta:Delta, nodeId:String, constructorId:String):void
		{
			WAOClassAttribute.remove(delta, nodeId, constructorId);
		}
		
		public static function getFromState(stateKey:String, stateValue:String):MClassConstructorMethod
		{
			if (stateValue == null)
			{
				return null;
			}
			var constructorId:String = WAOKeyGenerator.getNodeElementIdentifier(stateKey);
			
			
			var constructorData:Object = JSON.decode(stateValue);
			
			var constructor:MClassConstructorMethod = new MClassConstructorMethod(
				new Identifier(constructorId),
				EVisibility.getEVisibilityFromVal(constructorData[VISIBILITY]));
				
			getParametersFromDecodedObject(constructor, constructorData[PARAMETERS]);
			
			return constructor;	
		}
		
		public static function getParametersFromDecodedObject(method:MClassConstructorMethod, parametersData:Array):void
		{
			for (var i:int = 0; i < parametersData.length; i++)
			{
				method.addVariable(WAOVariable.getFromDecodedObject(parametersData[i]));
			}
		}
	}
}