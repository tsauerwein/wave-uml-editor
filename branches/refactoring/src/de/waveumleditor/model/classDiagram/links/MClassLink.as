package de.waveumleditor.model.classDiagram.links
{
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	public class MClassLink implements IIdentifiable
	{
		private var linkFrom:MClassDiagramNode;
		private var linkTo:MClassDiagramNode;
		
		private var key:Identifier;
		
		public function MClassLink(key:Identifier, linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode)
		{
			this.key = key
			this.linkFrom = linkFrom;
			this.linkTo = linkTo;
		}
	
		public function setFromTo(linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode):void
		{
			this.linkFrom = linkFrom;
			this.linkTo = linkTo;
		}
	
		public function canLink(linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode):Boolean 
		{	
			//simulates abstract method
			throw new Error("should not be called");
		}
		
		public function getLinkFrom():MClassDiagramNode
		{
			return this.linkFrom;
		}
		
		public function getLinkTo():MClassDiagramNode
		{
			return this.linkTo;
		}
		
		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function toString():String
		{
			return "from: " + this.linkFrom + " to: " + this.linkTo;
		}
		
		public function getLinkType():String
		{
			throw new Error("must be overriden in child classes");
		}

	}
}