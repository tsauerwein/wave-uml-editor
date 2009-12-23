package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.GenericDiagramContextPanel;
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.controller.ViewFactory;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.view.diagrammer.classDiagram.maps.LinkMap;
	import de.waveumleditor.view.diagrammer.classDiagram.maps.NodeMap;
	import de.waveumleditor.view.diagrammer.dialogues.ObserveMode;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	
	import flash.utils.Dictionary;
	
	import mx.collections.IList;
	import mx.events.DragEvent;
	import mx.managers.PopUpManager;
	
	public class ClassDiagramComponent extends Diagram
	{
		private var nodes:NodeMap;
		private var links:LinkMap;
		private var lockLayer:ObserveMode;
		
		public function ClassDiagramComponent()
		{
			nodes = new NodeMap();
			links = new LinkMap();
		}

		public function setViewModeToEdit():void
		{
			PopUpManager.removePopUp(lockLayer);
		}
		
		public function setViewModeToObserve():void
		{
            lockLayer = PopUpManager.createPopUp(this, ObserveMode, true) as ObserveMode;  
            this.lockLayer.classDiagramComponent = this;   
		}
		
		override protected function createContextPanel():GenericDiagramContextPanel 
		{
			return new ClassDiagramContextPanel();
		}
		
		/**
		 * Adds a node to the diagram.
		 * 
		 * If the passend-in node has an valid identifier, the node
		 * can be accessed by getNode(id) using the identifier.
		 * If the node has no valid identifier saveNode(..) must be
		 * called afterwards.
		 */ 
		public function addNode(node:BaseClassDiagramNode):void 
		{
			addChild(node);
			node.addEventListener(DragEvent.DRAG_COMPLETE, moveNode);
			
			if (node.getIdentifier() != null)
			{
				saveNode(node);
			}
		}
		
		/**
		 * Adds a link to the diagram.
		 * 
		 * If the passend-in link has an valid identifier, the node
		 * can be accessed by getLink(id) using the identifier.
		 * If the link has no valid identifier saveLink(..) must be
		 * called afterwards.
		 */ 
		public function addClassLink(link:ClassLink):void
		{
			addChild(link);
			
			if (link.getIdentifier() != null)
			{
				saveLink(link);
			}
		}
		
		/**
		 * Event-handler-method which is called uppon DRAG_COMPLETE events, 
		 * when a node of the diagram moved.
		 */ 
		private function moveNode(event:DragEvent):void
		{
			dispatchEvent(new NodeEvent(NodeEvent.EVENT_MOVE_NODE, 
				event.currentTarget as BaseClassDiagramNode));
		}
		
		override public function removeNode(node:BaseNode):void
		{
			super.removeNode(node);
			dispatchEvent(new NodeEvent(NodeEvent.EVENT_REMOVE_NODE, 
				node as BaseClassDiagramNode)); 
				
			if (node is BaseClassDiagramNode)
			{
				var classNode:BaseClassDiagramNode = node as BaseClassDiagramNode;
				
				if (classNode.getIdentifier() != null)
				{
					nodes.removeValue(classNode.getIdentifier());
				}
			}
		}
		
		override public function removeLink(link:Link):void
		{
			super.removeLink(link);
			dispatchEvent(new LinkEvent(LinkEvent.EVENT_REMOVE_LINK, 
				link as ClassLink));
				
			if (link is ClassLink)
			{
				var classLink:ClassLink = link as ClassLink;
				
				if (classLink.getIdentifier() != null)
				{
					links.removeValue(classLink.getIdentifier());
				}
			}
		}
		
		override public function addedLink(link:Link):void
		{
			dispatchEvent(new LinkEvent(LinkEvent.EVENT_ADD_LINK, 
				link as ClassLink));
		}
		
		/**
		 * After a node was saved with saveNode(..), it can be 
		 * accessed by getNode(id) using the node's identifier.
		 */ 
		public function saveNode(node:BaseClassDiagramNode):void
		{
			nodes.setValue(node);
		}
		
		public function getNode(id:Identifier):BaseClassDiagramNode
		{
			return nodes.getValue(id);
		}
		
		
		/**
		 * After a node was saved with saveLink(..), it can be 
		 * accessed by getLink(id) using the link's identifier.
		 */ 
		public function saveLink(link:ClassLink):void
		{
			links.setValue(link);
		}
		
		public function getLink(id:Identifier):ClassLink
		{
			return links.getValue(id);
		}
		
		public function update(classDiagram:ClassDiagram):void
		{
			var modelNodes:IList = classDiagram.getNodes();
			var modelLinks:IList = classDiagram.getLinks();
			
			var viewNodes:Dictionary = this.nodes.getAsDictionary();
			var viewLinks:Dictionary = this.links.getAsDictionary();

			// update nodes
			for(var i:int = 0; i < modelNodes.length; i++)
			{
				var modelNode:ClassDiagramNode = modelNodes.getItemAt(i) as ClassDiagramNode;
				
				var viewNode:BaseClassDiagramNode = this.getNode(modelNode.getIdentifier());
				if (viewNode == null)
				{
					// if node was not yet in view, create new node
					viewNode = ViewFactory.createNode(modelNode);
					this.addNode(viewNode);
				}
				else
				{
					// if node was alread in view, mark as updated
					viewNodes[modelNode.getIdentifier().getId()] = null;
				}
				
				viewNode.update(modelNode);
			}
			
			// update links
			for(i = 0; i < modelLinks.length; i++)
			{
				var modelLink:ClassDiagramLink = modelLinks.getItemAt(i) as ClassDiagramLink;
				
				var viewLink:ClassLink = this.getLink(modelLink.getIdentifier());
				if (viewLink == null)
				{
					// if link was not yet in view, create new link
					viewLink = ViewFactory.createLink(modelLink);
					this.addClassLink(viewLink);
				}
				else
				{
					// if link was alread in view, mark as updated
					viewLinks[modelLink.getIdentifier().getId()] = null;
				}
				
				// find matching view-node
				viewLink.fromNode = getNode(modelLink.getLinkFrom().getIdentifier());
				viewLink.toNode = getNode(modelLink.getLinkTo().getIdentifier());
				viewLink.fromNode.addLeavingLink(viewLink);
				viewLink.toNode.addArrivingLink(viewLink);
				
				viewLink.update(modelLink);
			}
			
			// remove all nodes/link in view that are not anymore in model
			removeNodes(viewNodes);
			removeLinks(viewLinks);
		}
		
		private function removeNodes(nodesToRemove:Dictionary):void
		{
			for (var key:Object in nodesToRemove)
			{
				if (key != null && nodesToRemove[key] != null) 
				{
					var id:Identifier = new Identifier(key as String);
					var node:BaseClassDiagramNode = getNode(id);
					super.removeNode(node);
					nodes.removeValue(id);
				}
			}
		}
		
		private function removeLinks(linksToRemove:Dictionary):void
		{
			for (var key:Object in linksToRemove)
			{
				if (key != null && linksToRemove[key] != null) 
				{
					var id:Identifier = new Identifier(key as String);
					var link:ClassLink = getLink(id);
					super.removeLink(link);
					links.removeValue(link.getIdentifier());
				}
			}
		}
	}
}