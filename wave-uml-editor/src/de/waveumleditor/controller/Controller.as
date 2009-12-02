package de.waveumleditor.controller
{
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.view.diagrammer.CreationEvent;
	import de.waveumleditor.view.diagrammer.MoveNodeEvent;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassDiagramComponent;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import mx.collections.ArrayList;
	
	public class Controller
	{
		private var diagramView:ClassDiagramComponent;
		private var diagramModel:ClassDiagram;
		private var fascade:ControllerFascade;
		
		public function Controller(diagramView:ClassDiagramComponent, diagramModel:ClassDiagram)
		{
			this.diagramView = diagramView;
			this.diagramModel = diagramModel;
			this.fascade = new ControllerFascade(this.diagramModel);
			
			this.diagramView.addEventListener(CreationEvent.ADD_CLASS_NODE, handleAddClassNode );
			this.diagramView.addEventListener(MoveNodeEvent.EVENT_MOVE_NODE, handleMoveClassNode );
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
			 	diagramView.addNode(node);
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
		
		private function handleMoveClassNode(event:MoveNodeEvent):void
		{
			trace("move " + event.getNode().x + " " + event.getNode().y);
			this.fascade.moveNode(event.getNode());
		}
	}
}