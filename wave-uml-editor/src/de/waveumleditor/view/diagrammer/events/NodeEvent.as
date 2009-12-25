package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	
	import flash.events.Event;

	public class NodeEvent extends Event
	{
		public static var EVENT_MOVE_NODE:String = "eventMoveNode";
		public static var EVENT_REMOVE_NODE:String = "eventRemoveNode";
		public static var EVENT_ADD_NODE:String = "eventAddNode";
		public static var EVENT_RENAME_NODE:String = "eventRenameNode";
		
		public static var EVENT_EDIT_NODE_ATTRIBUTES:String = "eventEditNodeAttributes";
		public static var EVENT_EDIT_NODE_METHODS:String = "eventEditNodeMethods";
		
		private var node:VClassDiagramNode;
		
		public function NodeEvent(type:String, node:VClassDiagramNode)
		{
			super(type);
			this.node = node;
		}
		
		public function getNode():VClassDiagramNode
		{
			return this.node;
		}
	}
}