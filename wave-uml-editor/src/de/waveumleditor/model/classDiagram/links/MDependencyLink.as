package de.waveumleditor.model.classDiagram.links
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	/**
	 * Dependency Link class
	 */
	public class MDependencyLink extends MClassLink
	{
				
		private var name:String;
		
		public static const TYPE:String = "D";
		
		public function MDependencyLink(key:Identifier, 
			linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode, name:String = "")
		{
			super(key, linkFrom, linkTo);
			this.name = name;
		}
		
		public override function canLink(linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode):Boolean 
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
		
		public function updateFrom(link:MDependencyLink):void
		{
			this.name = link.getName();
		}
		
		public function clone(id:Identifier):MDependencyLink
		{
			return new MDependencyLink(id, getLinkFrom(), getLinkTo(), name);
		}
		
		override public function getLinkType():String
		{
			return TYPE;
		}
	}
}