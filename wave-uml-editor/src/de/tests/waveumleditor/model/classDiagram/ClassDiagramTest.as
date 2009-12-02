package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.LinkAssociationDirected;
	
	import flexunit.framework.TestCase;
	
	public class ClassDiagramTest extends TestCase
	{
		private var class1:UMLClass;
    	private var class2:UMLClass;
    	private var class3:UMLClass; 
    	
		public function ClassDiagramTest()
		{
		}

		public function testRemoveNode():void
		{
    		var  classDiagram:ClassDiagram = createClassDiagram();
    		
    		classDiagram.removeNode(class1);
    		
    		assertEquals(1, classDiagram.getLinks().length);
    		assertEquals(2, classDiagram.getNodes().length);
		}
		
		private function createClassDiagram():ClassDiagram
		{
			var  classDiagram:ClassDiagram = new ClassDiagram();
    		
    		class1 = new UMLClass(new Identifier("1234567"), new Position(0,0), "class1");
    		class2 = new UMLClass(new Identifier("12345673"), new Position(0,0), "class2");
    		class3 = new UMLClass(new Identifier("12345674"), new Position(0,0), "class3");
    		
    		classDiagram.addNode(class1);
    		classDiagram.addNode(class2);
    		classDiagram.addNode(class3);
    		
    		classDiagram.addLink(new LinkAssociationDirected(new Identifier("12345675"), class1, class2));
    		classDiagram.addLink(new LinkAssociationDirected(new Identifier("12345676"), class2, class3));
    		classDiagram.addLink(new LinkAssociationDirected(new Identifier("12345677"), class1, class3));
    		
    		return classDiagram;
		}
	}
}