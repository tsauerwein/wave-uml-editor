package de.waveumleditor.model.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	
	public class AttributeMap extends AbstractMap
	{
		
		public function AttributeMap()
		{
			super();
		}

		public function setValue(attribute:ClassAttribute):void
		{
			super.delegate.setValue(attribute);
		}
		
		public function getValue(key:Identifier):ClassAttribute
		{
			return super.delegate.getValue(key) as ClassAttribute;
		}
	}	
}