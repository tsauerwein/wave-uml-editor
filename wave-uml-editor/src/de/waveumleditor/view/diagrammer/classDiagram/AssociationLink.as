package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Link;

	public class AssociationLink extends Link
	{
		
		public function AssociationLink()
		{
			super();
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new AssociationLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);				
		}
		
		
	}
}