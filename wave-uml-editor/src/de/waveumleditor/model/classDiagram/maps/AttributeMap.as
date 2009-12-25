package de.waveumleditor.model.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	
	public class AttributeMap extends AbstractMap
	{
		
		public function AttributeMap()
		{
			super();
		}

		public function setValue(attribute:MClassAttribute):void
		{
			super.delegate.setValue(attribute);
		}
		
		public function getValue(key:Identifier):MClassAttribute
		{
			return super.delegate.getValue(key) as MClassAttribute;
		}
	}	
}