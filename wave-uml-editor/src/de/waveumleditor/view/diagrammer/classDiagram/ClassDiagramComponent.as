package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.GenericDiagramContextPanel;
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.view.diagrammer.classDiagram.maps.LinkMap;
	import de.waveumleditor.view.diagrammer.classDiagram.maps.NodeMap;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	
	import mx.events.DragEvent;
	
	public class ClassDiagramComponent extends Diagram
	{
		private var nodes:NodeMap;
		private var links:LinkMap;
		
		public function ClassDiagramComponent()
		{
			nodes = new NodeMap();
			links = new LinkMap();
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
	}
}