package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.wao.WAOPosition;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import mx.collections.IList;
	
	/**
	 * This class maps ClassDiagramNode objects into key-value-pairs, which are
	 * stored in the Wave state.
	 * 
	 * @see de.waveumleditor.model.classDiagram.ClassDiagramNode
	 */ 
	public class WAONode
	{
		private var wave:Wave;
		private var waoLink:WAOLink;
		
		public static const POSITION:String = "p";
		public static const NAME:String = "n";
		
		public function WAONode(wave:Wave, waoLink:WAOLink)
		{
			this.wave = wave;
			this.waoLink = waoLink;
		}
		
		public function createNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			delta.setValue(node.getIdentifier().getId(), node.getType());
			setName(delta, node);
			
			WAOPosition.store(delta, node.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + POSITION, node.getPosition());
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function setPosition(nodeId:Identifier, newPosition:Position):void
		{
			var delta:Delta = new Delta();
			
			WAOPosition.store(delta, nodeId.getId() + WAOKeyGenerator.IDS_SEPERATOR + POSITION, newPosition);
			
			trace(delta.toString());
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function renameNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			setName(delta, node);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function removeNode(node:ClassDiagramNode, connectedLinks:IList):void
		{
			var delta:Delta = new Delta();
			
			var key:String = node.getIdentifier().getId();
			delta.setValue(key, null);
			delta.setValue(key + WAOKeyGenerator.IDS_SEPERATOR + POSITION, null);
			delta.setValue(key + WAOKeyGenerator.IDS_SEPERATOR + NAME, null);
			
			removeConnectedLinks(connectedLinks, delta);
			
			if (node is UMLClass)
			{
				var classNode:UMLClass = node as UMLClass;
				
				removeAttributes(classNode, delta);
				removeClassConstructors(classNode, delta);
				removeClassMethods(classNode, delta);
			} 
			else if (node is Interface)
			{
				// todo
			}
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		private function removeAttributes(classNode:UMLClass, delta:Delta):void
		{
			var attributes:IList = classNode.getAttributes();
			
			for (var i:int = 0; i < attributes.length; i++)
			{
				var attribute:ClassAttribute = attributes.getItemAt(i) as ClassAttribute;
				removeClassAttribute(classNode.getIdentifier(), attribute.getIdentifier(), delta);
			}
		}
		
		private function removeClassConstructors(classNode:UMLClass, delta:Delta):void
		{
			var constructors:IList = classNode.getConstructors();
			
			for (var i:int = 0; i < constructors.length; i++)
			{
				var constructor:ClassConstructorMethod = constructors.getItemAt(i) as ClassConstructorMethod;
				removeClassConstructor(classNode.getIdentifier(), constructor.getIdentifier(), delta);
			}
		}
		
		private function removeClassMethods(classNode:UMLClass, delta:Delta):void
		{
			var methods:IList = classNode.getMethods();
			
			for (var i:int = 0; i < methods.length; i++)
			{
				var method:ClassMethod = methods.getItemAt(i) as ClassMethod;
				removeClassMethod(classNode.getIdentifier(), method.getIdentifier(), delta);
			}
		}
		
		private function removeConnectedLinks(connectedLinks:IList, delta:Delta):void
		{
			for (var i:int = 0; i < connectedLinks.length; i++)
			{
				var link:ClassDiagramLink = connectedLinks.getItemAt(0) as ClassDiagramLink;
				waoLink.removeLink(link, delta);
			}
		}
		
		public function updateClassAttribute(classId:Identifier, attribute:ClassAttribute):void
		{
			var delta:Delta = new Delta();
			
			WAOClassAttribute.store(delta, classId.getId(), attribute);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		/**
		 * Removes a attribute from the Wave state.
		 * 
		 * Note that the delta is only submitted, if no delta 
		 * was passed-in.
		 */ 
		public function removeClassAttribute(classId:Identifier, attributeId:Identifier, delta:Delta = null):void
		{
			var executeSubmit:Boolean = false;
			
			if (delta == null)
			{
				delta = new Delta();
				executeSubmit = true;
			}
			
			WAOClassAttribute.remove(delta, classId.getId(), attributeId.getId());
						
			if (executeSubmit)
			{
				// only submit if no delta was passed in
				wave.submitDelta(delta.getWaveDelta());
			}
		}
		
		public function updateClassConstructor(classId:Identifier, constructor:ClassConstructorMethod):void
		{
			var delta:Delta = new Delta();
		
			WAOClassConstructor.store(delta, classId.getId(), constructor);			
			
			wave.submitDelta(delta.getWaveDelta());
		}

		/**
		 * Removes a constructor from the Wave state.
		 * 
		 * Note that the delta is only submitted, if no delta 
		 * was passed-in.
		 */ 
		public function removeClassConstructor(classId:Identifier, constructorId:Identifier, delta:Delta = null):void
		{
			var executeSubmit:Boolean = false;
			
			if (delta == null)
			{
				delta = new Delta();
				executeSubmit = true;
			}
			
			WAOClassConstructor.remove(delta, classId.getId(), constructorId.getId());
			
			if (executeSubmit)
			{
				// only submit if no delta was passed in
				wave.submitDelta(delta.getWaveDelta());
			}
		}
		
		public function updateClassMethod(classId:Identifier, method:ClassMethod):void
		{
			var delta:Delta = new Delta();
		
			WAOClassMethod.store(delta, classId.getId(), method);	
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		/**
		 * Removes a method from the Wave state.
		 * 
		 * Note that the delta is only submitted, if no delta 
		 * was passed-in.
		 */ 
		public function removeClassMethod(classId:Identifier, methodId:Identifier, delta:Delta = null):void
		{
			var executeSubmit:Boolean = false;
			
			if (delta == null)
			{
				delta = new Delta();
				executeSubmit = true;
			}
			
			WAOClassMethod.remove(delta, classId.getId(), methodId.getId());
			
			if (executeSubmit)
			{
				// only submit if no delta was passed in
				wave.submitDelta(delta.getWaveDelta());
			}
		}
		
		private function setName(delta:Delta, node:ClassDiagramNode):void
		{
			delta.setValue(node.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + NAME, node.getName());
		}
		
		public static function getFromState(nodeId:String, state:WaveState):ClassDiagramNode
		{
			var type:String = state.getStringValue(nodeId);
			var pos:String = state.getStringValue(nodeId + WAOKeyGenerator.IDS_SEPERATOR + POSITION);
			var name:String = state.getStringValue(nodeId + WAOKeyGenerator.IDS_SEPERATOR + NAME, "");
			
			if (type == null || pos == null)
			{
				return null;
			}
			
			var node:ClassDiagramNode = null;
			if (type == UMLClass.TYPE)
			{
				node = new UMLClass(new Identifier(nodeId), 
					WAOPosition.getFromState(pos),
					name);
			}
			else if (type == Interface.TYPE) 
			{
				node = new Interface(new Identifier(nodeId), 
					WAOPosition.getFromState(pos),
					name);
			}
			
			return node;
		}
	}
}