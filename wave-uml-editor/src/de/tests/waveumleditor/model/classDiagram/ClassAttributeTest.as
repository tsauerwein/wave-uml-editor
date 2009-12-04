package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flexunit.framework.TestCase;
	
	public class ClassAttributeTest extends TestCase
	{
		public function ClassAttributeTest()
		{
		}

		public function testToString():void
		{
			var type:Type = new Type("test");
			var variable:Variable = new Variable("test", type);
			
			var classAttribute:ClassAttribute = new ClassAttribute(new Identifier("attr003"), variable, EVisibility.PRIVATE );
			trace(classAttribute.toString());
			assertEquals("- test:test", classAttribute.toString());
			
			classAttribute.setStatic(true);
			trace(classAttribute.toString());
			assertEquals("- test:test", classAttribute.toString());
			
		}
		
		
	}
}