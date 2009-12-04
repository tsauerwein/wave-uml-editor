package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	
	import flash.events.Event;
	
	import mx.containers.Grid;
	
	public class BaseClassDiagramNode extends BaseNode
	{
		protected var grids:Grid;
		private var key:Identifier;
		
		public function BaseClassDiagramNode()
		{
			super();
		}
		
		
		override protected function createChildren():void 
		{
			//this.nodeContextPanel = new NodeContextPanel;
			
			super.createChildren();
			this.addChild(this.grids);
		}

		override protected function createNodeContextPanel():void 
		{
			this.nodeContextPanel = new ClassContextPanel();
			this.nodeContextPanel.addEventListener("linkNode", handleCustomLinkNode);
			this.nodeContextPanel.addEventListener("editAttributes", handleEditAttributes);	
	 
		}	
		
		override public function editedName():void
		{
			parent.dispatchEvent(new NodeEvent(NodeEvent.EVENT_RENAME_NODE, this));
		}
		
		public function update(nodeData:ClassDiagramNode):void
		{
				// update position
				this.x = nodeData.getPosition().getX();
				this.y = nodeData.getPosition().getY();
		}
		
		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function setIdentifier(key:Identifier):void
		{
			this.key = key;
		}
		
		private function handleEditAttributes(event:Event):void
		{
			trace("handleEditAttri");
			
		}
	}
}