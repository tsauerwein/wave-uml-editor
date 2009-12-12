package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.classDiagram.link.LinkDependency;

	public class LinkEditEvent
	{
		private var link:LinkDependency;
		
		public function LinkEditEvent(link:LinkDependency)
		{
			this.link = link;
		}
		
		public function getLink():LinkDependency
		{
			return link;
		}
	}
}