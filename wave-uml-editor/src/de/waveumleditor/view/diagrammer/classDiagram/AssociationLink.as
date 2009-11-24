package de.waveumleditor.view.diagrammer.classDiagram
{

	public class AssociationLink extends ClassLink
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