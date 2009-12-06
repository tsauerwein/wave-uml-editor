package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	
	public class MethodMap extends AbstractMap
	{
		
		public function MethodMap()
		{
			super();
		}

		public function setValue(method:ClassMethod):void
		{
			super.delegate.setValue(method);
		}
		
		public function getValue(key:Identifier):ClassMethod
		{
			return super.delegate.getValue(key) as ClassMethod;
		}
	}
}