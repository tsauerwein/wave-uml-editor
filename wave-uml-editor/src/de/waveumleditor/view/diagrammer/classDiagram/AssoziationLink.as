package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Link;

	public class AssoziationLink extends Link
	{
		
		public function AssoziationLink()
		{
			super();
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new AssoziationLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);				
		}
		
		
	}
}