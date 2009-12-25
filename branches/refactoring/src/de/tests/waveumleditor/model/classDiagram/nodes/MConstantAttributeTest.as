package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MConstantAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flexunit.framework.TestCase;
	
	public class MConstantAttributeTest extends TestCase
	{
		public function MConstantAttributeTest()
		{
		}
		
		public function testToString():void
		{
			var constantAttribute:MConstantAttribute = new MConstantAttribute(new Identifier("attr005"), new MVariable("test", MType.INT));
			
			assertEquals("+ test:int", constantAttribute.toString());
		}

	}
}