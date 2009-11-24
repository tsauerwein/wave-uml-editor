package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	import flexunit.framework.TestCase;
	
	public class ClassDiagramNodeTest extends TestCase
	{
		public function ClassDiagramNodeTest()
		{
		}
		
		public function testToString():void
		{
			var node:ClassDiagramNode = new ClassDiagramNode(new Position(0,0), "node1");
			
			assertEquals("node1", node.toString());
		}
	}
}