package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import flash.events.Event;

	public class LinkEvent extends Event
	{
		public static var EVENT_REMOVE_LINK:String = "removeLink";
		public static var EVENT_ADD_LINK:String = "addLink";
		
		private var link:ClassLink;
		
		public function LinkEvent(type:String, link:ClassLink)
		{
			super(type);
			this.link = link;
		}
		
		public function getLink():ClassLink
		{
			return this.link;
		}
	}
}