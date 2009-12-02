package de.waveumleditor.view.diagrammer
{
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	
	import mx.events.DragEvent;

	public class MoveNodeEvent extends DragEvent
	{
		public static var EVENT_MOVE_NODE:String = "eventMoveNode";
		
		private var node:BaseClassDiagramNode;
		
		public function MoveNodeEvent(type:String, node:BaseClassDiagramNode)
		{
			super(type);
			this.node = node;
		}
		
		public function getNode():BaseClassDiagramNode
		{
			return this.node;
		}
	}
}