package diagrammer
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.NodeContextPanel;
	
	public class BaseClassNode extends BaseNode
	{
		public function BaseClassNode()
		{
			super();
		}
		
		
		override protected function createChildren():void {
			//this.nodeContextPanel = new NodeContextPanel;
			
			super.createChildren();
		}

		
	}
}