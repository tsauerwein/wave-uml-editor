package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	
	public class MethodMap extends AbstractMap
	{
		
		public function MethodMap()
		{
			super();
		}

		public function setValue(method:MClassMethod):void
		{
			super.delegate.setValue(method);
		}
		
		public function getValue(key:Identifier):MClassMethod
		{
			return super.delegate.getValue(key) as MClassMethod;
		}
	}
}