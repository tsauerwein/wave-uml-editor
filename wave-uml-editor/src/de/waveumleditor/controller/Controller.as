package de.waveumleditor.controller
{
	import com.anotherflexdev.diagrammer.Diagram;
	
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import mx.collections.ArrayList;
	
	public class Controller
	{
		private var diagram:Diagram;
		
		public function Controller(diagram:Diagram)
		{
			this.diagram = diagram;
		}
		
		public function createDiagram(diagramData:ClassDiagram):void
		{
			var nodes:ArrayList = new ArrayList();
			var nodeDatas:ArrayList = diagramData.getNodes();
			 for(var i:int = 0; i < nodeDatas.length; i++)
			 {
			 	var nodeData:ClassDiagramNode = nodeDatas.getItemAt(i) as ClassDiagramNode;
			 	
			 	var node:BaseClassDiagramNode = ViewFactory.createNode(nodeData);
			 	node.update(nodeData);
			 	
			 	nodes.addItem(node);
			 	diagram.addChild(node);
			 }
			 
			 for(i = 0; i < diagramData.getLinks().length; i++)
			 {
			 	var linkData:ClassDiagramLink = diagramData.getLinks().getItemAt(i) as ClassDiagramLink;
			 	var link:ClassLink = ViewFactory.createLink(linkData);
			 	link.update(linkData);
			 	
			 	var fromIndex:int = nodeDatas.getItemIndex(linkData.getLinkFrom());
			 	var toIndex:int = nodeDatas.getItemIndex(linkData.getLinkTo());
			 	
			 	link.fromNode = nodes.getItemAt(fromIndex) as BaseClassDiagramNode;
			 	link.toNode = nodes.getItemAt(toIndex) as BaseClassDiagramNode;
			 	link.fromNode.addLeavingLink(link);
				link.toNode.addArrivingLink(link);
			 	
			 	diagram.addChild(link);
			 }
			 
			 
		}
		
	}
}