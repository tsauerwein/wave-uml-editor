package de.waveumleditor.controller
{
	import com.anotherflexdev.diagrammer.Diagram;
	
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.view.diagrammer.CreationEvent;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import mx.collections.ArrayList;
	
	public class Controller
	{
		private var diagramView:Diagram;
		private var diagramModel:ClassDiagram;
		private var fascade:ControllerFascade;
		
		public function Controller(diagramView:Diagram, diagramModel:ClassDiagram)
		{
			this.diagramView = diagramView;
			this.diagramModel = diagramModel;
			this.fascade = new ControllerFascade(this.diagramModel);
			this.diagramView.addEventListener(CreationEvent.ADD_CLASS_NODE, handleAddClassNode );
		}
		
		public function createDiagram():void
		{
			var nodes:ArrayList = new ArrayList();
			var nodeDatas:ArrayList = this.diagramModel.getNodes();
			 for(var i:int = 0; i < nodeDatas.length; i++)
			 {
			 	var nodeData:ClassDiagramNode = nodeDatas.getItemAt(i) as ClassDiagramNode;
			 	
			 	var node:BaseClassDiagramNode = ViewFactory.createNode(nodeData);
			 	node.update(nodeData);
			 	
			 	nodes.addItem(node);
			 	diagramView.addChild(node);
			 }
			 
			 for(i = 0; i < this.diagramModel.getLinks().length; i++)
			 {
			 	var linkData:ClassDiagramLink = this.diagramModel.getLinks().getItemAt(i) as ClassDiagramLink;
			 	var link:ClassLink = ViewFactory.createLink(linkData);
			 	link.update(linkData);
			 	
			 	var fromIndex:int = nodeDatas.getItemIndex(linkData.getLinkFrom());
			 	var toIndex:int = nodeDatas.getItemIndex(linkData.getLinkTo());
			 	
			 	link.fromNode = nodes.getItemAt(fromIndex) as BaseClassDiagramNode;
			 	link.toNode = nodes.getItemAt(toIndex) as BaseClassDiagramNode;
			 	link.fromNode.addLeavingLink(link);
				link.toNode.addArrivingLink(link);
			 	
			 	diagramView.addChild(link);
			 }
			 
		}
			
		private function handleAddClassNode(event:CreationEvent):void
		{
			this.fascade.addClassNode(event.getNode());
		}
		
	}
}