package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	
	import flexunit.framework.TestCase;
	
	public class MClassNodeTest extends TestCase
	{
		public function MClassNodeTest()
		{
		}
		
		public function testToString():void
		{
			var umlclass:MClassNode = new MClassNode(new Identifier("1234567"), new Position(0,0), "TestClass");
			
			assertEquals("TestClass", umlclass.toString());
		}
	}
}