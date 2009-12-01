package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkAssociationDirected extends LinkAssociation
	{
		private var toNavigable:Boolean = false;
		private var fromNavigable:Boolean = false;
		
		public function LinkAssociationDirected(key:Identifier, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(key, linkFrom, linkTo);
		}
		
		public function getToNavigable():Boolean
		{
			return this.toNavigable;
		} 
		
		public function setToNavigable(toNavigable:Boolean):void
		{
			this.toNavigable = toNavigable;
		} 

		public function getFromNavigable():Boolean
		{
			return this.fromNavigable;
		} 
		
		public function setFromNavigable(fromNavigable:Boolean):void
		{
			this.fromNavigable = fromNavigable;
		} 
	}
}