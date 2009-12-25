package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.classDiagram.nodes.MType;
	
	import flexunit.framework.TestCase;
	
	public class MTypeTest extends TestCase
	{
		public function MTypeTest()
		{
		}
		
		public function testToString():void
		{
			var type:MType = MType.DOUBLE;
			
			assertEquals("double", type.toString());
			
			type = new MType("TollerTyp");
			assertEquals("TollerTyp", type.toString());
		}

	}
}