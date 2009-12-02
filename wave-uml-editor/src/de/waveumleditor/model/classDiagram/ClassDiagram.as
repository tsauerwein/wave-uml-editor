package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	
	public class ClassDiagram
	{
		private var nodes:Dictionary;
		private var links:ArrayList;
		
		public function ClassDiagram()
		{
			this.nodes = new Dictionary();
			this.links = new ArrayList();
		}

		public function addNode(node:ClassDiagramNode):void
		{
			this.nodes[node.getKey()] = node;
		}
		
		public function removeNode(node:ClassDiagramNode):void
		{
			this.nodes[node.getKey()] = null;
			removeCorrespondingLinks(node);
		}
		
		public function getNode(id:Identifier):ClassDiagramNode
		{
			return this.nodes[id];
		}
		
		public function getNodes():ArrayList
		{
			var nodeList:ArrayList = new ArrayList();
			
			for (var key:Object in nodes)
			{
				if (key != null && nodes[key] != null) 
				{
					nodeList.addItem(nodes[key]);
				}
			}
			
			return nodeList;
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

		
	}
}