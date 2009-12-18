package de.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassDiagramComponent;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.dialogues.EditAssociationLinkWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditDependencyLinkWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethodsWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditSingleAttributeWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditSingleMethodWindow;
	import de.waveumleditor.view.diagrammer.events.LinkEditEvent;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	import de.waveumleditor.view.diagrammer.events.NodeAttributeEvent;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	import de.waveumleditor.view.diagrammer.events.NodeMethodEvent;
	
	import mx.collections.ArrayList;
	
	public class Controller
	{
		private var diagramView:ClassDiagramComponent;
		private var diagramModel:ClassDiagram;
		private var fascade:ModelFascade;
		
		public function Controller(diagramView:ClassDiagramComponent, diagramModel:ClassDiagram)
		{
			this.diagramView = diagramView;
			this.diagramModel = diagramModel;
			this.fascade = new ModelFascade(this.diagramModel, new WaveSimulator()); // todo
			
			this.diagramView.addEventListener(NodeEvent.EVENT_ADD_NODE, handleAddNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_MOVE_NODE, handleMoveClassNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_REMOVE_NODE, handleRemoveNode);
			this.diagramView.addEventListener(NodeEvent.EVENT_RENAME_NODE, handleRenameClassNode);
			
			this.diagramView.addEventListener(NodeEvent.EVENT_EDIT_NODE_ATTRIBUTES, handleEditNodeAttributes);
			this.diagramView.addEventListener(NodeEvent.EVENT_EDIT_NODE_METHODS, handleShowMethodDialog);
			
			this.diagramView.addEventListener(LinkEvent.EVENT_REMOVE_LINK, handleRemoveLink);
			this.diagramView.addEventListener(LinkEvent.EVENT_ADD_LINK, handleAddLink);
			this.diagramView.addEventListener(LinkEvent.EVENT_EDIT_ASSOCIATION_LINK, handleShowAssociationLink);
			this.diagramView.addEventListener(LinkEvent.EVENT_EDIT_DEPENDENCY_LINK, handleShowDependencyLink);
		}
		
		/**
		 * Builds the view-diagram from the model-digram.
		 */ 
		public function createDiagram():void
		{
			// create view-nodes
			var nodes:ArrayList = new ArrayList();
			var nodeDatas:ArrayList = this.diagramModel.getNodes();
			 for(var i:int = 0; i < nodeDatas.length; i++)
			 {
			 	var nodeData:ClassDiagramNode = nodeDatas.getItemAt(i) as ClassDiagramNode;
			 	
			 	var node:BaseClassDiagramNode = ViewFactory.createNode(nodeData);
			 	node.update(nodeData);
			 	
			 	nodes.addItem(node);
			 	diagramView.addNode(node);
			 }
			 
			 // create view-links
			 for(i = 0; i < this.diagramModel.getLinks().length; i++)
			 {
			 	var linkData:ClassDiagramLink = this.diagramModel.getLinks().getItemAt(i) as ClassDiagramLink;
			 	var link:ClassLink = ViewFactory.createLink(linkData);
			 	link.update(linkData);
			 	
			 	// find matching view-node
			 	var fromIndex:int = nodeDatas.getItemIndex(linkData.getLinkFrom());
			 	var toIndex:int = nodeDatas.getItemIndex(linkData.getLinkTo());
			 	
			 	link.fromNode = nodes.getItemAt(fromIndex) as BaseClassDiagramNode;
			 	link.toNode = nodes.getItemAt(toIndex) as BaseClassDiagramNode;
			 	link.fromNode.addLeavingLink(link);
				link.toNode.addArrivingLink(link);
			 	
			 	diagramView.addClassLink(link);
			 }
			 
		}
		
		/**
		 * Handler which is called when a new node (class or 
		 * interface) is added to the diagram.
		 */ 	
		private function handleAddNode(event:NodeEvent):void
		{
			this.fascade.addNode(event.getNode());
			this.diagramView.saveNode(event.getNode());
		}
		
		/**
		 * Handler to store the new position of a node.
		 */ 
		private function handleMoveClassNode(event:NodeEvent):void
		{
			trace("move " + event.getNode().x + " " + event.getNode().y);
			this.fascade.moveNode(event.getNode());
		}
		
		/**
		 * Handler to remove a node from the diagram.
		 */ 
		private function handleRemoveNode(event:NodeEvent):void
		{
			trace("remove " + event.getNode().x + " " + event.getNode().y);
			this.fascade.removeNode(event.getNode());
			
		}
		
		/**
		 * Handler to store the name of a node.
		 */ 
		private function handleRenameClassNode(event:NodeEvent):void
		{
			trace("rename " + event.getNode().nodeName);
			this.fascade.renameNode(event.getNode());
		}
		
		/**
		 * Handler to remove a link.
		 */ 
		private function handleRemoveLink(event:LinkEvent):void
		{
			trace("handleRemoveLink " + event.getLink().getIdentifier());
			this.fascade.removeLink(event.getLink());
		}
		
		/**
		 * Handler which stores a new link in the model.
		 */ 
		private function handleAddLink(event:LinkEvent):void
		{
			trace("handleAddLink ");
			this.fascade.addLink(event.getLink());
			this.diagramView.saveLink(event.getLink());
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * node's context-panel. It opens the attribute-dialog
		 * of the node. 
		 */ 
		private function handleEditNodeAttributes(event:NodeEvent):void
		{
			trace("handleEditNodeAttributes " + event.getNode().nodeName);
			
			var editAttributes:EditAttributesWindow = new EditAttributesWindow();
			editAttributes.setController(this);
			editAttributes.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editAttributes.popUp(); 
		}
		
		/** 
		 * This handler is supposed to be called from the 
		 * attribute-dialog of a node. It opens the single-attribute-dialog
		 * for an attribute. 
		 */ 
		public function handleShowSingleAttribute(event:NodeAttributeEvent):void
		{
			trace("handleShowSingleAttribute " + event.getClassNode().getName());
		
			var umlClass:UMLClass = diagramModel.getNode(event.getClassNode().getIdentifier()) as UMLClass;
			
			var attribute:ClassAttribute = null;
			if (event.getAttributeId() == ModelFascade.DEFAULT_ATTRIBUTE_IDENTIFIER)
			{
				// in case the dialog is opened to add a new attribute, create a default attribute
				var defaultVariable:Variable = new Variable("", Type.STRING);
        		attribute = new ClassAttribute(ModelFascade.DEFAULT_ATTRIBUTE_IDENTIFIER, 
        			defaultVariable, 
        			EVisibility.PUBLIC, 
        			false);
			}
			else 
			{
				attribute = umlClass.getAttribute(event.getAttributeId());
			}
			
			var editSingleAttribute:EditSingleAttributeWindow = new EditSingleAttributeWindow();
			editSingleAttribute.setController(this);
			editSingleAttribute.setClassData(umlClass);
			editSingleAttribute.setEditAttributesWindow(event.getAttributeWindow() as EditAttributesWindow);
          	editSingleAttribute.update(attribute);
         	
         	editSingleAttribute.popUp();		
		}
		
		/**
		 * Handler to store the changes to an attribute.
		 * This method is also used to add a new attribute.
		 */
		public function handleEditAttribute(event:NodeAttributeEvent):void
		{
			this.fascade.editNodeAttribute(event.getClassNode().getIdentifier(), event.getAttribute());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getAttributeWindow().update(updatedClass);
			
			// also update the diagram in the view
			refreshNodeInView(updatedClass);
		}
		
		/**
		 * Handler to remove an attribute.
		 */ 
		public function handleRemoveAttribute(event:NodeAttributeEvent):void
		{
			trace(event.getClassNode().getIdentifier());
			trace(event.getAttributeId());
			this.fascade.removeNodeAttribute(event.getClassNode().getIdentifier(), event.getAttributeId());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getAttributeWindow().update(updatedClass);
			
			// also update the diagram in the view
			refreshNodeInView(updatedClass);
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * node's context-panel. It opens the method/constructor-dialog
		 * of the node. 
		 */ 
		private function handleShowMethodDialog(event:NodeEvent):void
		{
			trace("handleEditNodeMethods " + event.getNode().nodeName);
			//TODO 
			
			var editMethods:EditMethodsWindow = new EditMethodsWindow();
			editMethods.setController(this);
			editMethods.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editMethods.popUp();
		}
		
		/** 
		 * This handler is supposed to be called from the 
		 * method/constructor-dialog of a node. It opens the single-method-dialog
		 * for a method. 
		 */ 
		public function handleShowSingleMethod(event:NodeMethodEvent):void
		{
			trace("handleShowSingleMethod " + event.getClassNode().getName());
			
			var editMethod:EditMethodsWindow = new EditMethodsWindow();
			var umlClass:UMLClass = diagramModel.getNode(event.getClassNode().getIdentifier()) as UMLClass;
			
			var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
			editSingleMethod.setClassData(umlClass);
			editSingleMethod.setController(this);
			
			var method:ClassConstructorMethod = null;
			if (fascade.isMethod(event.getMethodId())) 
			{
				if (event.getMethodId() == ModelFascade.DEFAULT_METHOD_IDENTIFIER)
				{
					// in case the dialog is opened to add a new method, create a default method
					method = new ClassMethod(ModelFascade.DEFAULT_METHOD_IDENTIFIER, "defaultMethod", EVisibility.PUBLIC, new Type("void"));
					editSingleMethod.isConstructor = false;
				}
				else 
				{
					method = umlClass.getMethod(event.getMethodId());
				}
			}
			else 
			{
				if (event.getMethodId() == ModelFascade.DEFAULT_CONSTRUCTOR_IDENTIFIER)
				{
					// in case the dialog is opened to add a new method, create a default method
					method = new  ClassConstructorMethod(ModelFascade.DEFAULT_CONSTRUCTOR_IDENTIFIER, EVisibility.PUBLIC);			
					editSingleMethod.isConstructor = true;
				}
				else 
				{
					method = umlClass.getConstructor(event.getMethodId());
				}
				
			}
			editSingleMethod.setEditMethodsWindow(event.getMethodWindow() as EditMethodsWindow);
			editSingleMethod.update(method);
			editSingleMethod.popUp();	
			
		}
		
		/** 
		 * This handler is supposed to be called from the 
		 * method/constructor-dialog of a node. It opens the single-constructor-dialog
		 * for a constructor. 
		 */ 
		public function handleAddMethod(event:NodeMethodEvent):void
		{
			this.fascade.addNodeMethod(event.getClassNode().getIdentifier(), event.getMethod());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getMethodWindow().update(updatedClass);
		}
		
		/**
		 * Handler to store the changes to a method.
		 * This method is also used to add a new method.
		 */
		public function handleEditMethod(event:NodeMethodEvent):void
		{
			this.fascade.editNodeMethod(event.getClassNode().getIdentifier(), event.getMethod());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getMethodWindow().update(updatedClass);
		}
		
		/**
		 * Handler to remove a method.
		 */ 
		public function handleRemoveMethod(event:NodeMethodEvent):void
		{
			if (fascade.isMethod(event.getMethodId()))
			{
				this.fascade.removeNodeMethod(event.getClassNode().getIdentifier(), event.getMethodId());
			}
			else 
			{
				this.fascade.removeClassConstructor(event.getClassNode().getIdentifier(), event.getMethodId());
			}
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());	
			
			event.getMethodWindow().update(updatedClass);
			// also update the diagram in the view
			refreshNodeInView(updatedClass);
		}
		
		/**
		 * Handler to store the changes to a constructor.
		 * This method is also used to add a new constructor.
		 */		
		public function handleEditConstructor(event:NodeMethodEvent):void
		{
			this.fascade.editClassConstructor(event.getClassNode().getIdentifier(), event.getMethod());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getMethodWindow().update(updatedClass);
		}
		
		/**
		 * Handler to remove a constructor.
		 */ 
		public function handleRemoveConstructor(event:NodeMethodEvent):void
		{
			this.fascade.removeClassConstructor(event.getClassNode().getIdentifier(), event.getMethodId());
			
			var updatedClass:ClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getMethodWindow().update(updatedClass);
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * association-link's context-panel. It opens the dialog
		 * to edit the properties of the association-link. 
		 */ 
		public function handleShowAssociationLink(event:LinkEvent):void 
		{
			var link:LinkAssociation = diagramModel.getLink(event.getAssociationLink().getIdentifier()) as LinkAssociation;
			var linkCopy:LinkAssociation = link.clone(link.getIdentifier()) as LinkAssociation;
			var editLinksWindow:EditAssociationLinkWindow = new EditAssociationLinkWindow();
			editLinksWindow.setViewLink(event.getAssociationLink());
			editLinksWindow.update(linkCopy);
			editLinksWindow.setController(this);
			editLinksWindow.popUp();
		}
		
		/**
		 * Handler to store the changes to the properties of a link.
		 * This method is used for association links AND dependency links.
		 */ 
		public function handleSaveLink(event:LinkEditEvent):void 
		{
			this.fascade.editLink(event.getLink());
			
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * dependency-link's context-panel. It opens the dialog
		 * to edit the properties of the dependency-link. 
		 */ 
		public function handleShowDependencyLink(event:LinkEvent):void
		{
			var link:LinkDependency = diagramModel.getLink(event.getDependencyLink().getIdentifier()) as LinkDependency;
			var linkCopy:LinkDependency = link.clone(link.getIdentifier());
			
			var editLinksWindow:EditDependencyLinkWindow = new EditDependencyLinkWindow();
			editLinksWindow.setViewLink(event.getDependencyLink());
			editLinksWindow.update(linkCopy);
			editLinksWindow.setController(this);
			editLinksWindow.popUp();
		}
		
		private function refreshNodeInView(node:ClassDiagramNode):void
		{
			this.diagramView.getNode(node.getIdentifier()).update(node);
		}
	}
}