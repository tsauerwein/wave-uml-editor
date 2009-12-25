package de.waveumleditor.view.diagrammer.classDiagram.nodes
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	
	import mx.containers.Grid;
	
	public class VClassDiagramNode extends BaseNode implements IIdentifiable
	{
		protected var grids:Grid;
		private var key:Identifier;
		
		public function VClassDiagramNode()
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
			this.nodeContextPanel = new VClassNodeContextPanel();
			this.nodeContextPanel.addEventListener("linkNode", handleCustomLinkNode);	 
		}	
		
		override public function editedName():void
		{
			parent.dispatchEvent(new NodeEvent(NodeEvent.EVENT_RENAME_NODE, this));
		}
		
		public function update(nodeData:MClassDiagramNode):void
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

	}
}