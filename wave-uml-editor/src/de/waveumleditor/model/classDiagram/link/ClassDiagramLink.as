package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class ClassDiagramLink
	{
		private var linkFrom:ClassDiagramNode;
		private var linkTo:ClassDiagramNode;
		
		private var key:Identifier;
		
		public function ClassDiagramLink(key:Identifier, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			this.key = key
			this.linkFrom = linkFrom;
			this.linkTo = linkTo;
		}
	
		public function canLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):Boolean 
		{	
			//simulates abstract method
			throw new Error("should not be called");
		}
		
		public function getLinkFrom():ClassDiagramNode
		{
			return this.linkFrom;
		}
		
		public function getLinkTo():ClassDiagramNode
		{
			return this.linkTo;
		}
		
		public function getKey():Identifier
		{
			return this.key;
		}
		
		public function toString():String
		{
			return "from: " + this.linkFrom + " to: " + this.linkTo;
		}

	}
}