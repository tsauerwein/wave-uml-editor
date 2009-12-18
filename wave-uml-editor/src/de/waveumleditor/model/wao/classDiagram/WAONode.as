package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.wao.WAOPosition;
	import de.waveumleditor.model.wao.wave.Delta;
	

	public class WAONode
	{
		private var wave:Wave;
		
		public static const POSITION:String = "pos";
		public static const NAME:String = "name";
		
		public function WAONode(wave:Wave)
		{
			this.wave = wave;
		}
		
		public function setPosition(nodeId:Identifier, newPosition:Position):void
		{
			var delta:Delta = new Delta();
			
			WAOPosition.store(delta, nodeId.getId() + Delta.IDS_SEPERATOR + POSITION, newPosition);
			
			trace(delta.toString());
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function createNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			delta.setValue(node.getIdentifier().getId(), node.getType());
			setName(delta, node);
			
			WAOPosition.store(delta, node.getIdentifier().getId() + Delta.IDS_SEPERATOR + POSITION, node.getPosition());
			
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
			
			
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		private function setName(delta:Delta, node:ClassDiagramNode):void
		{
			delta.setValue(node.getIdentifier().getId() + Delta.IDS_SEPERATOR + NAME, node.getName());
		}
	}
}