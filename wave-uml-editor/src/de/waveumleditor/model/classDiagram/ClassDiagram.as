package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import mx.collections.ArrayList;
	
	public class ClassDiagram
	{
		private var nodes:ArrayList;
		private var links:ArrayList;
		
		public function ClassDiagram()
		{
			this.nodes = new ArrayList();
			this.links = new ArrayList();
		}

		public function addNode(node:ClassDiagramNode):void
		{
			this.nodes.addItem(node);
		}
		
		public function removeNode(node:ClassDiagramNode):void
		{
			this.nodes.removeItem(node);
			removeCorrespondingLinks(node);
		}
		
		public function getNodes():ArrayList
		{
			return this.nodes;
		}
		
		public function addLink(link:ClassDiagramLink):void
		{
			this.links.addItem(link);
		}
		
		public function removeLink(link:ClassDiagramLink):void
		{
			this.links.removeItem(link);
		}
		
		public function getLinks():ArrayList
		{
			return this.links;
		}
		
		private function removeCorrespondingLinks(node:ClassDiagramNode):void
		{
			var linksCopy:Array = links.toArray();
			
			for (var i:int = 0; i < linksCopy.length; i++)
			{
				var link:ClassDiagramLink  = linksCopy[i];
				
				if (link.getLinkFrom() == node || link.getLinkTo() == node) 
				{
					links.removeItem(link);		
				}		
				
			}
		}
		
		public function toString():String
		{	
			return this.nodes.toString();
		}
		
	}
}