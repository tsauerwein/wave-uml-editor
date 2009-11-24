package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.Type;
	
	import flexunit.framework.TestCase;
	
	public class TypeTest extends TestCase
	{
		public function TypeTest()
		{
		}
		
		public function testToString():void
		{
			var type:Type = Type.DOUBLE;
			
			assertEquals("double", type.toString());
			
			type = new Type("TollerTyp");
			assertEquals("TollerTyp", type.toString());
		}

	}
}