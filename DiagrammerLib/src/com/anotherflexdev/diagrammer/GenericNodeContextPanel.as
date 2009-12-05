package com.anotherflexdev.diagrammer
{
	import mx.containers.Canvas;
	
	public class GenericNodeContextPanel extends Canvas {
		private var parentNode:BaseNode;
		
		public function GenericNodeContextPanel()
		{
			
		}
		
		public function setParentNode(parentNode:BaseNode):void
		{
			this.parentNode = parentNode;
		}
		
		public function getParentNode():BaseNode
		{
			return this.parentNode;
		}
	}
}