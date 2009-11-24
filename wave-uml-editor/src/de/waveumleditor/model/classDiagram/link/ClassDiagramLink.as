package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class ClassDiagramLink
	{
		private var linkFrom:ClassDiagramNode;
		private var linkTo:ClassDiagramNode;
				
		public function ClassDiagramLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
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
		
		public function toString():String
		{
			return "from: " + this.linkFrom + " to: " + this.linkTo;
		}

	}
}