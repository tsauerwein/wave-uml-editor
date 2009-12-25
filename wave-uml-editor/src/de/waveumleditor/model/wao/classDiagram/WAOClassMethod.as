package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.wao.wave.Delta;
		
	/**
	 * This class maps ClassMethod objects into key-value-pairs, which are
	 * stored in the Wave state.
	 * 
	 * @see de.waveumleditor.model.classDiagram.ClassMethod
	 */ 
	public class WAOClassMethod
	{
		public static const NAME:String = "n";
		public static const STATIC:String = "s";
		public static const ABSTRACT:String = "a";
		public static const RETURN_TYPE:String = "t";
		
		public static function store(delta:Delta, nodeId:String, method:MClassMethod):void
		{
			var methodData:Object = WAOClassConstructor.getEncodableObject(method);
			
			methodData[NAME] = method.getName();
			methodData[STATIC] = method.isStatic();
			methodData[ABSTRACT] = method.isAbstract();
			methodData[RETURN_TYPE] = WAOType.getEncodableObject(method.getReturnType());
			
			var json:String = JSON.encode(methodData);
			
			trace(json);
			
			var key:String = nodeId + WAOKeyGenerator.IDS_SEPERATOR + method.getIdentifier().getId();
			delta.setValue(key, json);
		}
		
		public static function remove(delta:Delta, nodeId:String, methodId:String):void
		{
			WAOClassAttribute.remove(delta, nodeId, methodId);
		}

		public static function getFromState(stateKey:String, stateValue:String):MClassMethod
		{
			var methodId:String = WAOKeyGenerator.getNodeElementIdentifier(stateKey);
			
			var methodData:Object = JSON.decode(stateValue);
			
			var method:MClassMethod = new MClassMethod(
				new Identifier(methodId),
				methodData[NAME],
				EVisibility.getEVisibilityFromVal(methodData[WAOClassConstructor.VISIBILITY]),
				WAOType.getFromDecodedObject(methodData[RETURN_TYPE]),
				methodData[ABSTRACT],
				methodData[STATIC]);
				
			WAOClassConstructor.getParametersFromDecodedObject(method, methodData[WAOClassConstructor.PARAMETERS]);
			
			return method;	
		}
	}
}