package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.ConstantAttribute;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flexunit.framework.TestCase;
	
	public class ConstantAttributeTest extends TestCase
	{
		public function ConstantAttributeTest()
		{
		}
		
		public function testToString():void
		{
			var constantAttribute:ConstantAttribute = new ConstantAttribute(new Variable("test", Type.INT));
			
			assertEquals("+ test:int", constantAttribute.toString());
		}

	}
}