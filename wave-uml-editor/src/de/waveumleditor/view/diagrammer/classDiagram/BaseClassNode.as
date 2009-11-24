package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import mx.containers.Grid;
	
	public class BaseClassNode extends BaseNode
	{
		protected var grids:Grid;
		
		public function BaseClassNode()
		{
			super();
		}
		
		
		override protected function createChildren():void {
			//this.nodeContextPanel = new NodeContextPanel;
			
			super.createChildren();
			this.addChild(this.grids);
		}

		override protected function createNodeContextPanel():void {
			this.nodeContextPanel = new ClassContextPanel();
			this.nodeContextPanel.addEventListener("linkNode", handleCustomLinkNode);	
	 
		}	
		
	}
}