package de.tests.waveumleditor.controller
{
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.assertThat;
	
	public class ModelFascadeTest extends TestCase
	{
		public function testAddNode():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			
			var modelFascade:ModelFascade = new ModelFascade(diagram);
						
			var sizeBefore:int = diagram.getNodes().length;
			
			var viewNode:BaseClassDiagramNode = new ClassNode();
			modelFascade.addNode(viewNode);
						
			var id:Identifier = viewNode.getIdentifier();
			
			assertThat(id != null);
			assertEquals(sizeBefore + 1, diagram.getNodes().length);
			assertThat(diagram.getNode(id) != null);
		}
		
/* 		public function testAddNodeAttribute():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			var nodeId:Identifier = new Identifier("C1");
			var nodeModel:UMLClass = new UMLClass(nodeId, null, "");
			diagram.addNode(nodeModel);
			var modelFascade:ModelFascade = new ModelFascade(diagram);
			
			var newAttribute:ClassAttribute = new ClassAttribute(
				new Identifier("default"), 
				new Variable("test", Type.STRING, "asda"), 
				EVisibility.PUBLIC);
				
			var nodeView:ClassNode = new ClassNode();
			nodeView.setIdentifier(nodeId);
			
			modelFascade.addNodeAttribute(nodeModel.getIdentifier(), newAttribute);
			
			assertEquals(1, nodeModel.getAttributes().length);
			assertThat(null != (nodeModel.getAttributes().getItemAt(0) as ClassAttribute).getIdentifier())
			
		} */
		
		public function testEditNodeAttribute():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			var nodeId:Identifier = new Identifier("C1");
			var nodeModel:UMLClass = new UMLClass(nodeId, null, "");
			diagram.addNode(nodeModel);
			var modelFascade:ModelFascade = new ModelFascade(diagram);
			
			var attribute:ClassAttribute = new ClassAttribute(
				new Identifier("A1"), 
				new Variable("test", Type.STRING, "asda"), 
				EVisibility.PUBLIC);
			nodeModel.addAttribute(attribute);
				
			var nodeView:ClassNode = new ClassNode();
			nodeView.setIdentifier(nodeId);
			
			var attributeFromView:ClassAttribute = new ClassAttribute(
				new Identifier("A1"), 
				new Variable("test2", Type.STRING, "a"), 
				EVisibility.PRIVATE);
			
			modelFascade.editNodeAttribute(nodeModel.getIdentifier(), attributeFromView);
			
			assertEquals(attribute.getVisibility(), attributeFromView.getVisibility());
			assertEquals(attribute.isStatic(), attributeFromView.isStatic());
			
			assertEquals(	attribute.getVariable().getDefaultValue(), 
							attributeFromView.getVariable().getDefaultValue());			
			assertEquals(	attribute.getVariable().getName(), 
							attributeFromView.getVariable().getName());		
			assertEquals(	attribute.getVariable().getType().getName(), 
							attributeFromView.getVariable().getType().getName());
			
		}
		
		public function testRemoveNodeAttribute():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			var nodeId:Identifier = new Identifier("C1");
			var nodeModel:UMLClass = new UMLClass(nodeId, null, "");
			diagram.addNode(nodeModel);
			var modelFascade:ModelFascade = new ModelFascade(diagram);
			
			var attribute:ClassAttribute = new ClassAttribute(
				new Identifier("A1"), 
				new Variable("test", Type.STRING, "asda"), 
				EVisibility.PUBLIC);
			nodeModel.addAttribute(attribute);
				
			var nodeView:ClassNode = new ClassNode();
			nodeView.setIdentifier(nodeId);
			
			modelFascade.removeNodeAttribute(nodeModel.getIdentifier(), attribute.getIdentifier());
			
			assertEquals(0, nodeModel.getAttributes().length);
		}
	}
}