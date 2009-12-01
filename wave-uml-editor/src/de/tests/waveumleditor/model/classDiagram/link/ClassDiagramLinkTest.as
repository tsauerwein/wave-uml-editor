package de.tests.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flexunit.framework.TestCase;
	
	public class ClassDiagramLinkTest extends TestCase
	{
		public function ClassDiagramLinkTest()
		{
		}
		
		public function testToString():void
		{
			var  link:ClassDiagramLink = new ClassDiagramLink(new Identifier("1234567"), new ClassDiagramNode(new Identifier("1234567"), new Position(0,0), "class1"), new ClassDiagramNode(new Identifier("1234567"), new Position(1,1), "class2"));
    		
    		assertEquals("from: class1 to: class2", link.toString());
		}

	}
}