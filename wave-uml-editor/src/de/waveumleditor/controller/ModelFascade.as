package de.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.Wave;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	import de.waveumleditor.view.diagrammer.classDiagram.VClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	
	import mx.collections.IList;

	public class ModelFascade
	{
		private var diagram:MClassDiagram;
				
		private var waoNode:WAONode;
		private var waoLink:WAOLink;
		private var waoKey:WAOKeyGenerator;
		
	
		public function ModelFascade(diagram:MClassDiagram, wave:Wave)
		{
			this.diagram = diagram;
			
			this.waoLink = new WAOLink(wave);
			this.waoNode = new WAONode(wave, waoLink);
			this.waoKey = new WAOKeyGenerator(wave);
		}
		
		public function setDiagram(diagram:MClassDiagram):void
		{
			this.diagram = diagram;
		}
		
		public function addNode(node:VClassDiagramNode, diagramView:VClassDiagram):void
		{	
			var id:Identifier = waoKey.generateNodeIdentifier();
			node.setIdentifier(id);
			
			diagramView.saveNode(node);
			
			var modelNode:MClassDiagramNode = ModelFactory.nodeFromView(node);
			this.diagram.addNode(modelNode);
			
			waoNode.createNode(modelNode);
			node.update(modelNode);
		}
		
		public function moveNode(node:VClassDiagramNode):void
		{
			var id:Identifier = node.getIdentifier();
			var nodeModel:MClassDiagramNode = diagram.getNode(id);
			
			if (nodeModel != null)
			{
				var newPosition:Position = new Position(node.x, node.y);
				
				nodeModel.setPosition(newPosition);
				waoNode.setPosition(id, newPosition);
			}
		}
		
		/**
		 * Removes a node from the diagram.
		 */ 
		public function removeNode(node:VClassDiagramNode):void
		{
			var nodeModel:MClassDiagramNode = diagram.getNode(node.getIdentifier());
			
			var removedLinks:IList = diagram.removeNode(nodeModel);
			waoNode.removeNode(nodeModel, removedLinks);
		}
		
		public function renameNode(node:VClassDiagramNode):void
		{
			var modelNode:MClassDiagramNode = diagram.getNode(node.getIdentifier());
			modelNode.setName(node.nodeName);
			waoNode.renameNode(modelNode);
		}
		
		
		// Links 				
		public function addLink(link:VClassLink, diagramView:VClassDiagram):void
		{
			var id:Identifier = waoKey.generateLinkIdentifier();
			link.setIdentifier(id);
			
			diagramView.saveLink(link);
			
			var fromNode:MClassDiagramNode = this.diagram.getNode((link.fromNode as VClassDiagramNode).getIdentifier());
			var toNode:MClassDiagramNode = this.diagram.getNode((link.toNode as VClassDiagramNode).getIdentifier());
			
			var modelLink:MClassLink = ModelFactory.linkFromView(link, fromNode, toNode);
			this.diagram.addLink(modelLink);
			waoLink.createLink(modelLink);
		}
		
		public function editLink(link:MDependencyLink):void
		{
			diagram.editLink(link);
			waoLink.updateLink(link);
		}
		
		public function removeLink(link:VClassLink):void
		{
			var modelLink:MClassLink = diagram.getLink(link.getIdentifier());
			diagram.removeLinkById(link.getIdentifier());
			waoLink.removeLink(modelLink);
		}
		
		public function editNodeAttribute(nodeId:Identifier, attribute:MClassAttribute):void
		{
			var id:Identifier = null;
			
			if (attribute.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER.getId())
			{
				id = waoKey.generateAttributeIdentifier();
				diagram.addAttribute(nodeId, attribute, id);
			}
			else
			{
				id = attribute.getIdentifier();
				diagram.editAttribute(nodeId, attribute);
			}
			
			var node:MClassNode = diagram.getNode(nodeId) as MClassNode;
			var attribute:MClassAttribute = node.getAttribute(id);
			
			waoNode.updateClassAttribute(nodeId, attribute);
		}
		
		public function removeNodeAttribute(nodeId:Identifier, attributeId:Identifier):void
		{
			diagram.removeAttribute(nodeId, attributeId);
			waoNode.removeClassAttribute(nodeId, attributeId);
		}
		
		// Methods
	
		public function removeNodeMethod(nodeId:Identifier, methodId:Identifier):void
		{
			diagram.removeMethod(nodeId, methodId);
			waoNode.removeClassMethod(nodeId, methodId);
		}
		
		public function editNodeMethod(nodeId:Identifier, method:MClassConstructorMethod):void
		{
			if (method.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER.getId() ||
				method.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER.getId())
			{
				var id:Identifier;
				
				if(method is MClassMethod)
				{
					id = waoKey.generateMethodIdentifier();
					var newMethod:MClassMethod = diagram.addMethod(nodeId, method as MClassMethod, id);	
					waoNode.updateClassMethod(nodeId, newMethod);
				}
				else
				{
					id = waoKey.generateConstructorIdentifier();
					var newConstructor:MClassConstructorMethod = diagram.addConstructor(nodeId, method, id);
					waoNode.updateClassConstructor(nodeId, newConstructor);
				}
				
			}
			else
			{
				if(method is MClassMethod)
				{
					diagram.editMethod(nodeId, method as MClassMethod);
					waoNode.updateClassMethod(nodeId, method as MClassMethod);
				}
				else
				{
					diagram.editConstructor(nodeId, method);
					waoNode.updateClassConstructor(nodeId, method);
				}
				
			}
		}
		
		public function removeClassConstructor(classId:Identifier, constructorId:Identifier):void
		{
			diagram.removeConstructor(classId, constructorId);
			waoNode.removeClassConstructor(classId, constructorId);
		}
		
	}
}