package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.view.diagrammer.classDiagram.AssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.DependencyLink;
	
	import flash.events.Event;

	public class LinkEvent extends Event
	{
		public static var EVENT_REMOVE_LINK:String = "removeLink";
		public static var EVENT_ADD_LINK:String = "addLink";
		public static var EVENT_EDIT_ASSOCIATION_LINK:String = "associationLink";
		public static var EVENT_EDIT_DEPENDENCY_LINK:String = "dependencyLink";
		
		private var link:ClassLink;
		private var associationLink:AssociationLink;
		private var dependencyLink:DependencyLink;
		
		public function LinkEvent(type:String, link:ClassLink=null, assoLink:AssociationLink=null, depenLink:DependencyLink=null)
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
		
		public function getLink():ClassLink
		{
			return this.link;
		}
		
		public function getAssociationLink():AssociationLink
		{
			return this.associationLink;
		}
		
		public function getDependencyLink():DependencyLink
		{
			return this.dependencyLink;
		}
	}
}