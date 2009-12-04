package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	
	public class ClassDiagram
	{
		private var nodes:Dictionary;
		private var links:Dictionary;
		
		public function ClassDiagram()
		{
			this.nodes = new Dictionary();
			this.links = new Dictionary();
		}

		public function addNode(node:ClassDiagramNode):void
		{
			this.nodes[node.getKey()] = node;
		}
		
		public function removeNodeById(id:Identifier):void
		{
			removeNode(this.nodes[id]);
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
			this.links[link.getKey()] = link;
		}
		
		public function removeLink(link:ClassDiagramLink):void
		{
			removeLinkById(link.getKey());
		}
		
		public function removeLinkById(id:Identifier):void
		{
			this.links[id] = null;
		}
		
		public function getLinks():ArrayList
		{
			var linkList:ArrayList = new ArrayList();
			
			for (var key:Object in links)
			{
				if (key != null && links[key] != null) 
				{
					linkList.addItem(links[key]);
				}
			}
			
			return linkList;
		}
		
		private function removeCorrespondingLinks(node:ClassDiagramNode):void
		{
			for (var key:Object in links)
			{
				if (key != null && links[key] != null) 
				{
					var link:ClassDiagramLink  = links[key];
					
					if (link.getLinkFrom() == node || link.getLinkTo() == node) 
					{
						removeLink(link);		
					}	
				}
			}
		}

		
	}
}