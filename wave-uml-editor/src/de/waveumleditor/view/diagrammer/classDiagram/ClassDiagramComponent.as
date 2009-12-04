package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.GenericDiagramContextPanel;
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	
	import mx.events.DragEvent;
	
	public class ClassDiagramComponent extends Diagram
	{
		
		public function ClassDiagramComponent()
		{
		}

		
		override protected function createContextPanel():GenericDiagramContextPanel 
		{
			return new ClassDiagramContextPanel();
		}
		
		public function addNode(node:BaseClassDiagramNode):void 
		{
			addChild(node);
			node.addEventListener(DragEvent.DRAG_COMPLETE, moveNode);
		}
		
		private function moveNode(event:DragEvent):void
		{
			dispatchEvent(new NodeEvent(NodeEvent.EVENT_MOVE_NODE, 
				event.currentTarget as BaseClassDiagramNode));
		}
		
		override public function removeLink(link:Link):void
		{
			super.removeLink(link);
			dispatchEvent(new LinkEvent(LinkEvent.EVENT_REMOVE_LINK, 
				link as ClassLink));
		}
		
		override public function removeNode(node:BaseNode):void
		{
			super.removeNode(node);
			dispatchEvent(new NodeEvent(NodeEvent.EVENT_REMOVE_NODE, 
				node as BaseClassDiagramNode)); 
		}
		
		override public function addedLink(link:Link):void
		{
			dispatchEvent(new LinkEvent(LinkEvent.EVENT_ADD_LINK, 
				link as ClassLink));
		}
			
	}
}