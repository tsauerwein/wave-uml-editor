package de.waveumleditor.view.diagrammer
{
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	
	import flash.events.Event;

	public class CreationEvent extends Event
	{
		public static var ADD_CLASS_NODE:String = "addClassNode";
		
		private var node:BaseClassDiagramNode;
		
		public function CreationEvent(type:String, node:BaseClassDiagramNode)
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