package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	
	public class ConstructorMap extends AbstractMap
	{
		
		public function ConstructorMap()
		{
			super();
		}

		public function setValue(constructor:ClassConstructorMethod):void
		{
			super.delegate.setValue(constructor);
		}
		
		public function getValue(key:Identifier):ClassConstructorMethod
		{
			return super.delegate.getValue(key) as ClassConstructorMethod;
		}
	}
}