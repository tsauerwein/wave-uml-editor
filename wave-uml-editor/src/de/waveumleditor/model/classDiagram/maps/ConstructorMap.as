package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	
	public class ConstructorMap extends AbstractMap
	{
		
		public function ConstructorMap()
		{
			super();
		}

		public function setValue(constructor:MClassConstructorMethod):void
		{
			super.delegate.setValue(constructor);
		}
		
		public function getValue(key:Identifier):MClassConstructorMethod
		{
			return super.delegate.getValue(key) as MClassConstructorMethod;
		}
	}
}