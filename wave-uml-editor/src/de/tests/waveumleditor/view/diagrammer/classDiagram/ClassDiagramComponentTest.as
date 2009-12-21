package de.tests.waveumleditor.view.diagrammer.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassDiagramComponent;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.DependencyLink;
	
	import flexunit.framework.TestCase;

	public class ClassDiagramComponentTest extends TestCase
	{
		
		public function testUpdate():void
		{
			var classDiagram:ClassDiagram = new ClassDiagram();
			
			var modelNode1:ClassDiagramNode = new UMLClass(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "001"), 
				new Position(1,1));
			var modelNode2:ClassDiagramNode = new UMLClass(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "002"), 
				new Position(2,2));
			var modelNode3:ClassDiagramNode = new UMLClass(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "003"), 
				new Position(1,2));
			
			var modelLink1:ClassDiagramLink = new LinkDependency(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "001"),
				modelNode1,
				modelNode2);
			var modelLink2:ClassDiagramLink = new LinkDependency(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "002"),
				modelNode2,
				modelNode3);
			
			classDiagram.addNode(modelNode1);
			classDiagram.addNode(modelNode2);
			classDiagram.addNode(modelNode3);
			classDiagram.addLink(modelLink1);
			classDiagram.addLink(modelLink2);
			
			var viewDiagramm:ClassDiagramComponent = new ClassDiagramComponent();
			
			var viewNode1:BaseClassDiagramNode = new ClassNode();
			viewNode1.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "001"));
			var viewNode2:BaseClassDiagramNode = new ClassNode();
			viewNode2.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "002"));
			var viewNode3:BaseClassDiagramNode = new ClassNode();
			viewNode3.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_NODE + "004"));
			
			var viewLink1:ClassLink = new DependencyLink();
			viewLink1.setIdentifier(new Identifier(WAOKeyGenerator.PREFIX_LINK + "001"));
			viewLink1.fromNode = viewNode1;
			viewLink1.toNode = viewNode2;
			
			var viewLink2:ClassLink = new DependencyLink();
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