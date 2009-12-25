package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;

	public class LinkEditEvent
	{
		private var link:MDependencyLink;
		
		public function LinkEditEvent(link:MDependencyLink)
		{
			this.link = link;
		}
		
		public function getLink():MDependencyLink
		{
			return link;
		}
	}
}