package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.GenericDiagramContextPanel;
	
	import de.waveumleditor.view.diagrammer.MoveNodeEvent;
	
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
			dispatchEvent(new MoveNodeEvent(MoveNodeEvent.EVENT_MOVE_NODE, 
				event.currentTarget as BaseClassDiagramNode));
		}
			
	}
}