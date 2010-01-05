package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.wao.wave.Delta;

	/**
	 * This class maps ClassAttribute objects into key-value-pairs, which are
	 * stored in the Wave state.
	 * 
	 * @see de.waveumleditor.model.classDiagram.ClassAttribute
	 */ 
	public class WAOClassAttribute
	{
		public static const STATIC:String = "s";
		public static const VISIBILITY:String = "vi";
		public static const VARIABLE:String = "va";
		
		public static function store(delta:Delta, nodeId:String, attribute:MClassAttribute):void
		{
			var attributeData:Object = new Object();
			
			// build an object that be encoded as JSON
			attributeData[STATIC] = attribute.isStatic();
			attributeData[VISIBILITY] = attribute.getVisibility().getValue();
			attributeData[VARIABLE] = WAOVariable.getEncodableObject(attribute.getVariable());
			
			var json:String = JSON.encode(attributeData);
			
			var key:String = nodeId + WAOKeyGenerator.IDS_SEPERATOR + attribute.getIdentifier().getId();
			delta.setValue(key, json);
		}
		
		public static function remove(delta:Delta, nodeId:String, attributeId:String):void
		{
			var key:String = nodeId + WAOKeyGenerator.IDS_SEPERATOR + attributeId;
			delta.setValue(key, null);
		}
		
		public static function getFromState(stateKey:String, stateValue:String):MClassAttribute
		{
			if (stateValue == null)
			{
				return null;
			}
			var attributeId:String = WAOKeyGenerator.getNodeElementIdentifier(stateKey);
			
			var attributeData:Object = JSON.decode(stateValue);
			
			return new MClassAttribute(new Identifier(attributeId), 
				WAOVariable.getFromDecodedObject(attributeData[VARIABLE]),
				EVisibility.getEVisibilityFromVal(attributeData[VISIBILITY]),
				attributeData[STATIC]);
		}
	}
}