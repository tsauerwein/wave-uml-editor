package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.wao.WAOPosition;
	import de.waveumleditor.model.wao.wave.Delta;
	

	public class WAONode
	{
		private var wave:Wave;
		
		public static const POSITION:String = "p";
		public static const NAME:String = "n";
		
		public function WAONode(wave:Wave)
		{
			this.wave = wave;
		}
		
		public function createNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			delta.setValue(node.getIdentifier().getId(), node.getType());
			setName(delta, node);
			
			WAOPosition.store(delta, node.getIdentifier().getId() + Delta.IDS_SEPERATOR + POSITION, node.getPosition());
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function setPosition(nodeId:Identifier, newPosition:Position):void
		{
			var delta:Delta = new Delta();
			
			WAOPosition.store(delta, nodeId.getId() + Delta.IDS_SEPERATOR + POSITION, newPosition);
			
			trace(delta.toString());
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function renameNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			setName(delta, node);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function updateClassAttribute(classId:Identifier, attribute:ClassAttribute):void
		{
			var delta:Delta = new Delta();
			
			WAOClassAttribute.store(delta, classId.getId(), attribute);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function removeClassAttribute(classId:Identifier, attributeId:Identifier):void
		{
			var delta:Delta = new Delta();
			
			WAOClassAttribute.remove(delta, classId.getId(), attributeId.getId());
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function updateClassConstructor(classId:Identifier, constructor:ClassConstructorMethod):void
		{
			var delta:Delta = new Delta();
		
			WAOClassConstructor.store(delta, classId.getId(), constructor);			
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function removeClassConstructor(classId:Identifier, constructorId:Identifier):void
		{
			var delta:Delta = new Delta();
			
			WAOClassConstructor.remove(delta, classId.getId(), constructorId.getId());
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function updateClassMethod(classId:Identifier, method:ClassMethod):void
		{
			var delta:Delta = new Delta();
		
			WAOClassMethod.store(delta, classId.getId(), method);	
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function removeClassMethod(classId:Identifier, methodId:Identifier):void
		{
			var delta:Delta = new Delta();
			
			WAOClassMethod.remove(delta, classId.getId(), methodId.getId());
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		private function setName(delta:Delta, node:ClassDiagramNode):void
		{
			delta.setValue(node.getIdentifier().getId() + Delta.IDS_SEPERATOR + NAME, node.getName());
		}
	}
}