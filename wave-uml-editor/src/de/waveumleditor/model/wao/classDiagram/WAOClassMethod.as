package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.wao.wave.Delta;
	
	public class WAOClassMethod
	{
		public static const STATIC:String = "s";
		public static const ABSTRACT:String = "a";
		public static const RETURN_TYPE:String = "t";
		
		public static function store(delta:Delta, nodeId:String, method:ClassMethod):void
		{
			var methodData:Object = WAOClassConstructor.getEncodableObject(method);
			
			methodData[STATIC] = method.isStatic();
			methodData[ABSTRACT] = method.isAbstract();
			methodData[RETURN_TYPE] = WAOType.getEncodableObject(method.getReturnType());
			
			var json:String = JSON.encode(methodData);
			
			trace(json);
			
			var key:String = nodeId + Delta.IDS_SEPERATOR + method.getIdentifier().getId();
			delta.setValue(key, json);
		}
		
		public static function remove(delta:Delta, nodeId:String, methodId:String):void
		{
			WAOClassAttribute.remove(delta, nodeId, methodId);
		}

	}
}