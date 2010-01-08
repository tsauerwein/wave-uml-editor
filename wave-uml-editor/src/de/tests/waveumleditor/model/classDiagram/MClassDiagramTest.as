package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.IList;
	
	import org.flexunit.assertThat;
	
	public class MClassDiagramTest extends TestCase
	{
		private var class1:MClassNode;
    	private var class2:MClassNode;
    	private var class3:MClassNode; 
    	
		public function MClassDiagramTest()
		{
		}

		public function testRemoveNode():void
		{
    		var  classDiagram:MClassDiagram = createClassDiagram();
    		
    		var removedLinks:IList = classDiagram.removeNode(class1);
    		
    		assertEquals(2, removedLinks.length);
    		assertEquals(1, classDiagram.getLinks().length);
    		assertEquals(2, classDiagram.getNodes().length);
			assertTrue(null == classDiagram.getNode(class1.getIdentifier()));
		}
		
		public function testGetNode():void
		{
			var  classDiagram:MClassDiagram = createClassDiagram();
			var node:MClassDiagramNode = classDiagram.getNode(new Identifier("1234567"));
			
			assertThat(node != null);
		}
		
		public function testRemoveNodeById():void
		{
			var  classDiagram:MClassDiagram = createClassDiagram();
			classDiagram.removeNodeById(new Identifier("1234567"));
			
			assertThat(null == classDiagram.getNode(new Identifier("1234567")));
			assertThat(null == classDiagram.getLink(new Identifier("12345675")));
			assertThat(null == classDiagram.getLink(new Identifier("12345677")));
			
			assertEquals(1, classDiagram.getLinks().length);
			assertEquals(2, classDiagram.getNodes().length);
		}
		
		private function createClassDiagram():MClassDiagram
		{
			var  classDiagram:MClassDiagram = new MClassDiagram();
    		
    		class1 = new MClassNode(new Identifier("1234567"), new Position(0,0), "class1");
    		class2 = new MClassNode(new Identifier("12345673"), new Position(0,0), "class2");
    		class3 = new MClassNode(new Identifier("12345674"), new Position(0,0), "class3");
    		
    		classDiagram.addNode(class1);
    		classDiagram.addNode(class2);
    		classDiagram.addNode(class3);
    		
    		classDiagram.addLink(new MAssociationLink(new Identifier("12345675"), class1, class2));
    		classDiagram.addLink(new MAssociationLink(new Identifier("12345676"), class2, class3));
    		classDiagram.addLink(new MAssociationLink(new Identifier("12345677"), class1, class3));
    		
    		return classDiagram;
		}
	}
}