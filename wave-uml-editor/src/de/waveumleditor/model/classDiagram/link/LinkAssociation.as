package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	
	public class LinkAssociation extends ClassDiagramLink
	{
		private var fromName:String;
		private var fromMultiplicity:String;
		private var toName:String;
		private var toMultiplicity:String;
		
		private var name:String;
		
		public function LinkAssociation(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(linkFrom, linkTo);
		}
		
		public override function canLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):Boolean 
		{	
			return true;
		}
		
		
		public function getFromName():String 
		{
			return this.fromName;
		}
		
		public function setFromName(fromName:String):void
		{
			this.fromName = fromName;
		}
		
		public function getFromMultiplicity():String 
		{
			return this.fromMultiplicity;
		}
		
		public function setFromMultiplicity(fromMultiplicity:String):void
		{
			this.fromMultiplicity = fromMultiplicity;
		}
		
		public function getToName():String 
		{
			return this.toName;
		}
		
		public function setToName(toName:String):void
		{
			this.toName = toName;
		}
		
		public function getToMultiplicity():String 
		{
			return this.toMultiplicity;
		}
		
		public function setToMultiplicity(toMultiplicity:String):void
		{
			this.toMultiplicity = toMultiplicity;
		}

		public function getName():String 
		{
			return this.name;
		}
		
		public function setName(fname:String):void
		{
			this.name = name;
		}
		
	}
}