package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.view.diagrammer.classDiagram.links.VAssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VDependencyLink;
	
	import flash.events.Event;

	public class LinkEvent extends Event
	{
		public static var EVENT_REMOVE_LINK:String = "removeLink";
		public static var EVENT_ADD_LINK:String = "addLink";
		public static var EVENT_EDIT_ASSOCIATION_LINK:String = "associationLink";
		public static var EVENT_EDIT_DEPENDENCY_LINK:String = "dependencyLink";
		
		private var link:VClassLink;
		private var associationLink:VAssociationLink;
		private var dependencyLink:VDependencyLink;
		
		public function LinkEvent(type:String, link:VClassLink=null, assoLink:VAssociationLink=null, depenLink:VDependencyLink=null)
		{ 
			try
			{
			super(type);
			if(link != null)
			{
				this.link = link;
			}
			else if(assoLink != null)
			{
				this.associationLink = assoLink;
			}	
			else if(depenLink != null)
			{
				this.dependencyLink = depenLink;
			}
			else
			{
				 throw new Error("LinkEvent() -> Missing Argument"); 
			}
			}catch(e:Error)
			{
				trace(e.getStackTrace() + "/n" + e.message);
			}	
			
		}
		
		public function getLink():VClassLink
		{
			return this.link;
		}
		
		public function getAssociationLink():VAssociationLink
		{
			return this.associationLink;
		}
		
		public function getDependencyLink():VDependencyLink
		{
			return this.dependencyLink;
		}
	}
}