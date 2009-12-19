package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkDependency extends ClassDiagramLink
	{
				
		private var name:String;
		
		public static const TYPE:String = "A";
		
		public function LinkDependency(key:Identifier, 
			linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode, name:String = "")
		{
			super(key, linkFrom, linkTo);
			this.name = name;
		}
		
		public override function canLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):Boolean 
		{	
			return true;
		}	

		public function getName():String 
		{
			return this.name;
		}
		
		public function setName(name:String):void
		{
			this.name = name;
		}	
		
		public function updateFrom(link:LinkDependency):void
		{
			this.name = link.getName();
		}
		
		public function clone(id:Identifier):LinkDependency
		{
			return new LinkDependency(id, getLinkFrom(), getLinkTo(), name);
		}
		
		override public function getLinkType():String
		{
			return TYPE;
		}
	}
}