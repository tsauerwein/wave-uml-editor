package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.wao.wave.Delta;

	public class WAOClassAttribute
	{
		
		public static const STATIC:String = "static";
		public static const VISIBILITY:String = "vis";
		
		public static function store(delta:Delta, key:String, attribute:ClassAttribute):void
		{
			var attributeData:Object = new Object();
			
			attributeData[STATIC] = attribute.isStatic();
			attributeData[VISIBILITY] = attribute.getVisibility().getValue();
			
			var json:String = JSON.encode(attributeData);
			
			trace(json);
			
			delta.setValue(key, json);
		}
	}
}