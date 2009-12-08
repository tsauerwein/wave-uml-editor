package de.waveumleditor.controller
{
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassDiagramComponent;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethodsWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditSingleAttributeWindow;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	import de.waveumleditor.view.diagrammer.events.NodeAttributeEvent;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	
	import mx.collections.ArrayList;
	
	public class Controller
	{
		private var diagramView:ClassDiagramComponent;
		private var diagramModel:ClassDiagram;
		private var fascade:ModelFascade;
		
		public function Controller(diagramView:ClassDiagramComponent, diagramModel:ClassDiagram)
		{
			this.diagramView = diagramView;
			this.diagramModel = diagramModel;
			this.fascade = new ModelFascade(this.diagramModel);
			
			this.diagramView.addEventListener(NodeEvent.EVENT_ADD_NODE, handleAddNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_MOVE_NODE, handleMoveClassNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_REMOVE_NODE, handleRemoveNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_RENAME_NODE, handleRenameClassNode);
			
			this.diagramView.addEventListener(NodeEvent.EVENT_EDIT_NODE_ATTRIBUTES, handleEditNodeAttributes);
			this.diagramView.addEventListener(NodeEvent.EVENT_EDIT_NODE_METHODS, handleEditNodeMethods);
			
			this.diagramView.addEventListener(LinkEvent.EVENT_REMOVE_LINK, handleRemoveLink);
			this.diagramView.addEventListener(LinkEvent.EVENT_ADD_LINK, handleAddLink);
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
			
		private function handleAddNode(event:NodeEvent):void
		{
			this.fascade.addNode(event.getNode());
		}
		
		private function handleMoveClassNode(event:NodeEvent):void
		{
			trace("move " + event.getNode().x + " " + event.getNode().y);
			this.fascade.moveNode(event.getNode());
		}
		
		private function handleRemoveNode(event:NodeEvent):void
		{
			trace("remove " + event.getNode().x + " " + event.getNode().y);
			this.fascade.removeNode(event.getNode());
		}
		
		private function handleRenameClassNode(event:NodeEvent):void
		{
			trace("rename " + event.getNode().nodeName);
			this.fascade.renameNode(event.getNode());
		}
		
		
		private function handleRemoveLink(event:LinkEvent):void
		{
			trace("handleRemoveLink " + event.getLink().getIdentifier());
			this.fascade.removeLink(event.getLink());
		}
		
		private function handleAddLink(event:LinkEvent):void
		{
			trace("handleAddLink ");
			this.fascade.addLink(event.getLink());
		}
		
		
		private function handleEditNodeAttributes(event:NodeEvent):void
		{
			trace("handleEditNodeAttributes " + event.getNode().nodeName);
			//TODO 
			
			var editAttributes:EditAttributesWindow = new EditAttributesWindow();
			editAttributes.setController(this);
			editAttributes.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editAttributes.popUp(); 
		}
		
		private function handleShowSingleAttribute(event:NodeAttributeEvent):void
		{
			trace("handleShowSingleAttribute " + event.getNode().nodeName);
		
			var editAttributes:EditAttributesWindow = new EditAttributesWindow();
			var umlClass:UMLClass = diagramModel.getNode(event.getNode().getIdentifier()) as UMLClass;
			var attribute:ClassAttribute = umlClass.getAttribute(event.getAttributeId());
			
			var editSingleAttribute:EditSingleAttributeWindow = new EditSingleAttributeWindow();
          	editSingleAttribute.update(attribute);
         	
         	editSingleAttribute.popUp();			
		}
		
		public function handleAddAttribute(event:NodeAttributeEvent):void
		{
			this.fascade.addNodeAttribute(event.getClassNode(), event.getAttribute());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getNode().getIdentifier());
			event.getAttributeWindow().update(updatedClass);
		}
		
		public function handleEditAttribute(event:NodeAttributeEvent):void
		{
			this.fascade.editNodeAttribute(event.getClassNode(), event.getAttribute());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getNode().getIdentifier());
			event.getAttributeWindow().update(updatedClass);
		}
		
		public function handleRemoveAttribute(event:NodeAttributeEvent):void
		{
			this.fascade.removeNodeAttribute(event.getClassNode(), event.getAttributeId());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getNode().getIdentifier());
			event.getAttributeWindow().update(updatedClass);
		}
		
		
		private function handleEditNodeMethods(event:NodeEvent):void
		{
			trace("handleEditNodeMethods " + event.getNode().nodeName);
			//TODO 
			
			var editMethods:EditMethodsWindow = new EditMethodsWindow();
			editMethods.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editMethods.popUp();
		}
	}
}