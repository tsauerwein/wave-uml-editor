package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flexunit.framework.TestCase;
	
	public class MClassAttributeTest extends TestCase
	{
		public function MClassAttributeTest()
		{
		}

		public function testToString():void
		{
			var type:MType = new MType("test");
			var variable:MVariable = new MVariable("test", type);
			
			var classAttribute:MClassAttribute = new MClassAttribute(new Identifier("attr003"), variable, EVisibility.PRIVATE );
			trace(classAttribute.toString());
			assertEquals("- test:test", classAttribute.toString());
			
			classAttribute.setStatic(true);
			trace(classAttribute.toString());
			assertEquals("- test:test", classAttribute.toString());
			
		}
		
		
	}
}