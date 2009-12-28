package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.classDiagram.maps.LinkMap;
	import de.waveumleditor.model.classDiagram.maps.NodeMap;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	
	/**
	 * Holds a list of all nodes and links that belong 
	 * to a digram
	 */ 
	public class MClassDiagram
	{

		private var nodes:NodeMap;
		private var links:LinkMap;
		
		public function MClassDiagram()
		{
			this.nodes = new NodeMap();
			this.links = new LinkMap();
		}

		public function addNode(node:MClassDiagramNode):void
		{
			this.nodes.setValue(node);
		}
		
		/**
		 * Removes a node from the diagram by its id.
		 * 
		 * @return A list of links that were connected to this node.
		 */ 
		public function removeNodeById(id:Identifier):IList
		{
			return removeNode(getNode(id));
		}
		
		/**
		 * Removes a node from the diagram.
		 * 
		 * @return A list of links that were connected to this node.
		 */ 
		public function removeNode(node:MClassDiagramNode):IList
		{
			this.nodes.removeValue(node.getIdentifier());
			return removeCorrespondingLinks(node);
		}
		
		public function getNode(id:Identifier):MClassDiagramNode
		{
			return this.nodes.getValue(id);
		}
		
		public function getNodes():ArrayList
		{
			return this.nodes.getAsList();
		}
		
		public function addLink(link:MClassLink):void
		{
			this.links.setValue(link);
		}
		
		public function removeLink(link:MClassLink):void
		{
			removeLinkById(link.getIdentifier());
		}
		
		public function removeLinkById(id:Identifier):void
		{
			this.links.removeValue(id);
		}
		
		public function getLink(id:Identifier):MClassLink
		{
			return this.links.getValue(id);
		}
		
		public function getLinks():ArrayList
		{
			return this.links.getAsList();
		}
		
		/**
		 * Removes all links from the diagram that are connected 
		 * with the passed-in node.
		 * 
		 * @return A list of links that were removed.
		 */ 
		private function removeCorrespondingLinks(node:MClassDiagramNode):IList
		{
			var linkList:ArrayList = getLinks();
			
			var removedLinks:ArrayList = new ArrayList();
			for (var i:int = 0; i < linkList.length; i++)
			{
				var link:MClassLink = linkList.getItemAt(i) as MClassLink;
				
				if (link.getLinkFrom() == node || link.getLinkTo() == node) 
				{
					removedLinks.addItem(link);	
					removeLink(link);		
				}	
			}
			
			return removedLinks;
		}
		
		public function addAttribute(classId:Identifier, newAttribute:MClassAttribute, 
			attributeId:Identifier):void
		{
			// build a copy of the attribute
			var attribute:MClassAttribute = newAttribute.clone(attributeId);
				
			var umlClass:MClassNode = getNode(classId) as MClassNode;
			umlClass.addAttribute(attribute);
		}
		
		public function editAttribute(classId:Identifier, newAttribute:MClassAttribute):void
		{
			var umlClass:MClassNode = getNode(classId) as MClassNode;
			
			var attribute:MClassAttribute = umlClass.getAttribute(newAttribute.getIdentifier());
			attribute.updateFrom(newAttribute);
		}
		
		public function removeAttribute(classId:Identifier, attributeId:Identifier):void
		{
			var umlClass:MClassNode = getNode(classId) as MClassNode;
			
			umlClass.removeAttributeById(attributeId);
		}
		
		//Methods
		public function addMethod(classId:Identifier, newMethod:MClassMethod, methodId:Identifier):MClassMethod
		{
				var method:MClassMethod = newMethod.clone(methodId) as MClassMethod;
				
				/* var umlClass:UMLClass = getNode(classId) as UMLClass;
				
				umlClass.addMethod(method); */
				var classDiagramNode:MClassDiagramNode = getNode(classId);
				
				classDiagramNode.addMethod(method);
				
				return method;
		}
		
		public function editMethod(classId:Identifier, newMethod:MClassMethod):void
		{
			/* var umlClass:UMLClass = getNode(classId) as UMLClass; */
			var classDiagramNode:MClassDiagramNode = getNode(classId);
			
			var method:MClassMethod = classDiagramNode.getMethod(newMethod.getIdentifier());
			method.updateFrom(newMethod);
		}
		
		public function removeMethod(classId:Identifier, methodId:Identifier):void
		{
			var classDiagramNode:MClassDiagramNode = getNode(classId);
			
			classDiagramNode.removeMethodById(methodId);
		}
		
		// Constructors
		public function addConstructor(classId:Identifier, 
			newConstructor:MClassConstructorMethod, 
			constructorId:Identifier):MClassConstructorMethod
		{
				var constructor:MClassConstructorMethod = newConstructor.clone(constructorId);
				
				var umlClass:MClassNode = getNode(classId) as MClassNode;
				
				umlClass.addConstructor(constructor);
				
				return constructor;
		}
		
		public function editConstructor(classId:Identifier, newConstructor:MClassConstructorMethod):void
		{
			var umlClass:MClassNode = getNode(classId) as MClassNode;
			
			var constructor:MClassConstructorMethod = umlClass.getConstructor(newConstructor.getIdentifier());
			constructor.updateFrom(newConstructor);
		}
		
		public function removeConstructor(classId:Identifier, constructorId:Identifier):void
		{
			var umlClass:MClassNode = getNode(classId) as MClassNode;
			
			umlClass.removeConstructorById(constructorId);
		}
		
		public function editLink(newLink:MDependencyLink):void
		{
			var link:MDependencyLink = getLink(newLink.getIdentifier()) as MDependencyLink;
			
			link.updateFrom(newLink);
		}
	}
}