package de.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveMode;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.tests.TestUtil;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MInterface;
	import de.waveumleditor.model.classDiagram.nodes.MInterfaceMethod;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.wao.classDiagram.WAODiagram;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.classDiagram.VClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditAssociationLinkWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditDependencyLinkWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethods;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethodsWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditSingleAttributeWindow;
	import de.waveumleditor.view.diagrammer.dialogues.EditSingleMethodWindow;
	import de.waveumleditor.view.diagrammer.events.LinkEditEvent;
	import de.waveumleditor.view.diagrammer.events.LinkEvent;
	import de.waveumleditor.view.diagrammer.events.NodeAttributeEvent;
	import de.waveumleditor.view.diagrammer.events.NodeEvent;
	import de.waveumleditor.view.diagrammer.events.NodeMethodEvent;
	
	public class Controller
	{
		private var diagramView:VClassDiagram;
		private var diagramModel:MClassDiagram;
		
		private var fascade:ModelFascade;
		
		private var wave:Wave;
		
		private var editMethodsWindow:EditMethodsWindow = null;
		private var editAttributesWindow:EditAttributesWindow = null;
		
		public function Controller(diagramView:VClassDiagram, diagramModel:MClassDiagram)
		{
			this.diagramView = diagramView;
			this.diagramModel = diagramModel;
			
			this.wave = new WaveSimulator(); // todo
			//this.wave = new Wave();
			
			this.fascade = new ModelFascade(this.diagramModel, this.wave);
			
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
		
		public function setUpCallbacks():void
		{
			wave.setStateCallback(stateCallback);
			wave.setModeCallback(modeCallback);
		}
		
		/**
		 * This method is called when the gadget's state object changes.
		 */ 
		private function stateCallback(args:Object):void 
		{
			trace("stateCallback start");
			
			var state:WaveState = wave.getState();
			diagramModel = WAODiagram.getFromState(state);
			fascade.setDiagram(diagramModel);
			diagramView.update(diagramModel);
			
			this.updateOpenEditorWindow();
	
			TestUtil.printTrace(state);
			trace("stateCallback end");
		}
		
		
		/**
		 * This method is called when the gadget's mode changes.
		 */ 
		private function modeCallback(mode:Object):void
		{
			trace("modeCallback start");
						
			if (mode == WaveMode.EDIT)
			{
				trace("Mode: edit");
				diagramView.setViewModeToEdit();
			}
			else
			{
				trace("Mode: read-only");
				diagramView.setViewModeToObserve();
			}
			
			trace("modeCallback end");
		}
		
		/**
		 * Updates the content of (open) editor windows 
		 */
		private function updateOpenEditorWindow():void
		{
			var node:MClassDiagramNode = null;
			if ( this.editMethodsWindow != null )
			{
				node = editMethodsWindow.getClassData();
				editMethodsWindow.update(diagramModel.getNode(node.getIdentifier()));
				
				if (editMethodsWindow.editMethodsWindow.parent == null )
				{
					editMethodsWindow = null;
				}
			}
			
			if ( this.editAttributesWindow != null )
			{
				node = editAttributesWindow.getClassData();
				editAttributesWindow.update(diagramModel.getNode(node.getIdentifier()));
				
				if (editAttributesWindow.editAttributesWindow.parent == null )
				{
					editAttributesWindow = null;
				}
			}
		}
				
		/**
		 * Handler which is called when a new node (class or 
		 * interface) is added to the diagram.
		 */ 	
		private function handleAddNode(event:NodeEvent):void
		{
			this.fascade.addNode(event.getNode(), this.diagramView);
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
			this.fascade.addLink(event.getLink(), this.diagramView);
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * node's context-panel. It opens the attribute-dialog
		 * of the node. 
		 */ 
		private function handleEditNodeAttributes(event:NodeEvent):void
		{
			trace("handleEditNodeAttributes " + event.getNode().nodeName);
			
			editAttributesWindow = new EditAttributesWindow();
			editAttributesWindow.setController(this);
			editAttributesWindow.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editAttributesWindow.popUp(); 
		}
		
		/** 
		 * This handler is supposed to be called from the 
		 * attribute-dialog of a node. It opens the single-attribute-dialog
		 * for an attribute. 
		 */ 
		public function handleShowSingleAttribute(event:NodeAttributeEvent):void
		{
			trace("handleShowSingleAttribute " + event.getClassNode().getName());
		
			var umlClass:MClassNode = diagramModel.getNode(event.getClassNode().getIdentifier()) as MClassNode;
			
			var attribute:MClassAttribute = null;
			if (event.getAttributeId() == WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER)
			{
				// in case the dialog is opened to add a new attribute, create a default attribute
				var defaultVariable:MVariable = new MVariable("", MType.STRING);
        		attribute = new MClassAttribute(WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER, 
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
			
			var updatedClass:MClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
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
			
			var updatedClass:MClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
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
			editMethodsWindow = new EditMethodsWindow();
			
			editMethodsWindow.setController(this);
			editMethodsWindow.update(diagramModel.getNode(event.getNode().getIdentifier()));
			editMethodsWindow.popUp();
		}
		
		/** 
		 * This handler is supposed to be called from the 
		 * method/constructor-dialog of a node. It opens the single-method-dialog
		 * for a method. 
		 */ 
		public function handleShowSingleMethod(event:NodeMethodEvent):void
		{
			trace("handleShowSingleMethod " + event.getClassNode().getName());
			
			//var editMethod:EditMethodsWindow = new EditMethodsWindow();
			var classDiagramNode:MClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			
			var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
			editSingleMethod.setClassData(classDiagramNode);
			editSingleMethod.setController(this);
			
			var method:MClassConstructorMethod = null;
			if (WAOKeyGenerator.isMethod(event.getMethodId())) 
			{
				//TODO: Unterscheidung zw. InterfaceMethod und ClassMethod
				if (event.getMethodId() == WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER)
				{
					if (event.getClassNode() is MInterface)
					{
						method = new MInterfaceMethod(WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER, "defaultMethod", new MType("void"));
					}
					else
					{
						// in case the dialog is opened to add a new method, create a default method
						method = new MClassMethod(WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER, "defaultMethod", EVisibility.PUBLIC, new MType("void"));
					}
					
					editSingleMethod.isConstructor = false;
				}
				else 
				{
					method = classDiagramNode.getMethod(event.getMethodId());
					editSingleMethod.isConstructor = false;
				}
			}
			else 
			{
				if (event.getMethodId() == WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER)
				{
					// in case the dialog is opened to add a new method, create a default method
					method = new  MClassConstructorMethod(WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER, EVisibility.PUBLIC);			
					editSingleMethod.isConstructor = true;
				}
				else 
				{
					method = (classDiagramNode as MClassNode).getConstructor(event.getMethodId());
					editSingleMethod.isConstructor = true;
				}
				
			}
			editSingleMethod.setEditMethodsWindow(event.getMethodWindow() as EditMethodsWindow);
			editSingleMethod.update(method);
			editSingleMethod.popUp();	
		}
		
		/**
		 * Handler to store the changes to a method.
		 * This method is also used to add a new method.
		 */
		public function handleEditMethod(event:NodeMethodEvent):void
		{
			this.fascade.editNodeMethod(event.getClassNode().getIdentifier(), event.getMethod());
			
			var updatedClass:MClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());
			event.getMethodWindow().update(updatedClass);

			// also update the diagram in the view
			refreshNodeInView(updatedClass);
		}
		
		/**
		 * Handler to remove a method.
		 */ 
		public function handleRemoveMethod(event:NodeMethodEvent):void
		{
			if (WAOKeyGenerator.isMethod(event.getMethodId()))
			{
				this.fascade.removeNodeMethod(event.getClassNode().getIdentifier(), event.getMethodId());
			}
			else 
			{
				this.fascade.removeClassConstructor(event.getClassNode().getIdentifier(), event.getMethodId());
			}
			
			var updatedClass:MClassDiagramNode = diagramModel.getNode(event.getClassNode().getIdentifier());	
			
			event.getMethodWindow().update(updatedClass);
			// also update the diagram in the view
			refreshNodeInView(updatedClass);
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * association-link's context-panel. It opens the dialog
		 * to edit the properties of the association-link. 
		 */ 
		public function handleShowAssociationLink(event:LinkEvent):void 
		{
			var link:MAssociationLink = diagramModel.getLink(event.getAssociationLink().getIdentifier()) as MAssociationLink;
			var linkCopy:MAssociationLink = link.clone(link.getIdentifier()) as MAssociationLink;
			
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
			refreshLinkInView(event.getLink());
			
		}
		
		/**
		 * This handler is supposed to be called from a 
		 * dependency-link's context-panel. It opens the dialog
		 * to edit the properties of the dependency-link. 
		 */ 
		public function handleShowDependencyLink(event:LinkEvent):void
		{
			var link:MDependencyLink = diagramModel.getLink(event.getDependencyLink().getIdentifier()) as MDependencyLink;
			var linkCopy:MDependencyLink = link.clone(link.getIdentifier());
			
			var editLinksWindow:EditDependencyLinkWindow = new EditDependencyLinkWindow();
			editLinksWindow.setViewLink(event.getDependencyLink());
			editLinksWindow.update(linkCopy);
			editLinksWindow.setController(this);
			editLinksWindow.popUp();
		}
		
		private function refreshNodeInView(nodeModel:MClassDiagramNode):void
		{
			var nodeView:VClassDiagramNode = this.diagramView.getNode(nodeModel.getIdentifier());
			
			if (nodeView != null && nodeModel != null)
			{
				nodeView.update(nodeModel);
			}
		}
		
		private function refreshLinkInView(link:MDependencyLink):void
		{
			var linkView:VClassLink = this.diagramView.getLink(link.getIdentifier());
			var linkModel:MClassLink = this.diagramModel.getLink(link.getIdentifier());
			
			if (linkView != null && linkModel != null)
			{
				linkView.update(linkModel);
			}
		}
	}
}