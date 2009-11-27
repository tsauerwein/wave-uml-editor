package com.anotherflexdev.diagrammer
{
	import mx.containers.Canvas;
	
	public class GenericDiagramContextPanel extends Canvas
	{
		private var parentDiagram:Diagram;
		
		public function GenericDiagramContextPanel()
		{
			
		}
		
		public function setParentPanel(parentDiagram:Diagram):void
		{
			this.parentDiagram = parentDiagram;
		}
		
		public function getParentPanel():Diagram
		{
			return this.parentDiagram;
		}

	}
}