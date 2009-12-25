package de.tests.waveumleditor.view.diagrammer.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.VClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VDependencyLink;
	
	import flexunit.framework.TestCase;

	public class VClassDiagramTest extends TestCase
	{
		
		public function testUpdate():void
		{
			var classDiagram:MClassDiagram = new MClassDiagram();
			
			var modelNode1:MClassDiagramNode = new MClassNode(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "001"), 
				new Position(1,1));
			var modelNode2:MClassDiagramNode = new MClassNode(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "002"), 
				new Position(2,2));
			var modelNode3:MClassDiagramNode = new MClassNode(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "003"), 
				new Position(1,2));
			
			var modelLink1:MClassLink = new MDependencyLink(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "001"),
				modelNode1,
				modelNode2);
			var modelLink2:MClassLink = new MDependencyLink(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "002"),
				modelNode2,
				modelNode3);
			
			classDiagram.addNode(modelNode1);
			classDiagram.addNode(modelNode2);
			classDiagram.addNode(modelNode3);
			classDiagram.addLink(modelLink1);
			classDiagram.addLink(modelLink2);
			
			var viewDiagramm:VClassDiagram = new VClassDiagram();
			
			var viewNode1:VClassDiagramNode = new VClassNode();
			viewNode1.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "001"));
			var viewNode2:VClassDiagramNode = new VClassNode();
			viewNode2.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "002"));
			var viewNode3:VClassDiagramNode = new VClassNode();
			viewNode3.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "004"));
			
			var viewLink1:VClassLink = new VDependencyLink();
			viewLink1.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_LINK + "001"));
			viewLink1.fromNode = viewNode1;
			viewLink1.toNode = viewNode2;
			
			var viewLink2:VClassLink = new VDependencyLink();
			viewLink1.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_LINK + "003"));
			viewLink2.fromNode = viewNode1;
			viewLink2.toNode = viewNode3;
			
			viewDiagramm.addNode(viewNode1);
			viewDiagramm.addNode(viewNode2);
			viewDiagramm.addNode(viewNode3);
			viewDiagramm.addedLink(viewLink1);
			viewDiagramm.addedLink(viewLink2);
			
			viewDiagramm.update(classDiagram);
			
			assertTrue(viewDiagramm.getNode(new Identifier(WAOKeyGenerator.PREFIX_NODE + "004")) == null);
			assertTrue(viewDiagramm.getNode(new Identifier(WAOKeyGenerator.PREFIX_NODE + "003")) != null);
			assertTrue(viewDiagramm.getLink(new Identifier(WAOKeyGenerator.PREFIX_LINK + "003")) == null);
			assertTrue(viewDiagramm.getLink(new Identifier(WAOKeyGenerator.PREFIX_LINK + "002")) != null);
		}
		
		
	}
}