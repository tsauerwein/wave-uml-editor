package de.tests.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.classDiagram.VClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.assertThat;
	
	public class ModelFascadeTest extends TestCase
	{
		public function testAddNode():void
		{
			var diagram:MClassDiagram = new MClassDiagram();
			var diagramView:VClassDiagram = new VClassDiagram();
			
			var modelFascade:ModelFascade = new ModelFascade(diagram, new WaveSimulator());
						
			var sizeBefore:int = diagram.getNodes().length;
			
			var viewNode:VClassDiagramNode = new VClassNode();
			modelFascade.addNode(viewNode, diagramView);
						
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
			var diagram:MClassDiagram = new MClassDiagram();
			var nodeId:Identifier = new Identifier("C1");
			var nodeModel:MClassNode = new MClassNode(nodeId, null, "");
			diagram.addNode(nodeModel);
			var modelFascade:ModelFascade = new ModelFascade(diagram, new WaveSimulator());
			
			var attribute:MClassAttribute = new MClassAttribute(
				new Identifier("A1"), 
				new MVariable("test", MType.STRING, "asda"), 
				EVisibility.PUBLIC);
			nodeModel.addAttribute(attribute);
				
			var nodeView:VClassNode = new VClassNode();
			nodeView.setIdentifier(nodeId);
			
			var attributeFromView:MClassAttribute = new MClassAttribute(
				new Identifier("A1"), 
				new MVariable("test2", MType.STRING, "a"), 
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
			var diagram:MClassDiagram = new MClassDiagram();
			var nodeId:Identifier = new Identifier("C1");
			var nodeModel:MClassNode = new MClassNode(nodeId, null, "");
			diagram.addNode(nodeModel);
			var modelFascade:ModelFascade = new ModelFascade(diagram, new WaveSimulator());
			
			var attribute:MClassAttribute = new MClassAttribute(
				new Identifier("A1"), 
				new MVariable("test", MType.STRING, "asda"), 
				EVisibility.PUBLIC);
			nodeModel.addAttribute(attribute);
				
			var nodeView:VClassNode = new VClassNode();
			nodeView.setIdentifier(nodeId);
			
			modelFascade.removeNodeAttribute(nodeModel.getIdentifier(), attribute.getIdentifier());
			
			assertEquals(0, nodeModel.getAttributes().length);
		}
		
		public function testGetNodeElementIdentifier():void
		{
			var nodeId:String = "C-01";
			var attributeId:String = "A-01";
			
			var key:String = nodeId + WAOKeyGenerator.IDS_SEPERATOR + attributeId;
			
			assertEquals(attributeId, WAOKeyGenerator.getNodeElementIdentifier(key));
		}
	}
}