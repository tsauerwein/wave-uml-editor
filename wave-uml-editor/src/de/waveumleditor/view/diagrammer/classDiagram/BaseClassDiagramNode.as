package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	import mx.containers.Grid;
	
	public class BaseClassDiagramNode extends BaseNode
	{
		protected var grids:Grid;
		
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
	 
		}	
		
		public function update(nodeData:ClassDiagramNode):void
		{
				// update position
				this.x = nodeData.getPosition().getX();
				this.y = nodeData.getPosition().getY();
		}
		
	}
}