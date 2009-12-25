package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	import flexunit.framework.TestCase;
	
	public class MClassDiagramNodeTest extends TestCase
	{
		public function MClassDiagramNodeTest()
		{
		}
		
		public function testToString():void
		{
			var node:MClassDiagramNode = new MClassDiagramNode(new Identifier("1234567"), new Position(0,0), "node1");
			
			assertEquals("node1", node.toString());
		}
	}
}