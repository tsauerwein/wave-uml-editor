package de.tests.waveumleditor.model.classDiagram.links
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	
	import flexunit.framework.TestCase;
	
	public class ClassDiagramLinkTest extends TestCase
	{
		public function ClassDiagramLinkTest()
		{
		}
		
		public function testToString():void
		{
			var  link:MClassLink = new MClassLink(new Identifier("1234567"), new MClassDiagramNode(new Identifier("1234567"), new Position(0,0), "class1"), new MClassDiagramNode(new Identifier("1234567"), new Position(1,1), "class2"));
    		
    		assertEquals("from: class1 to: class2", link.toString());
		}

	}
}