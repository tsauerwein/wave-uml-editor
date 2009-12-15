package de.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.wao.WAOPosition;
	import de.waveumleditor.model.wao.wave.Delta;
	

	public class WAONode
	{
		public static const POSITION:String = "pos";
		public static const NAME:String = "name";
		
		public static function setPosition(nodeId:Identifier, newPosition:Position):void
		{
			var delta:Delta = new Delta();
			
			WAOPosition.store(delta, nodeId.getId() + Delta.IDS_SEPERATOR + POSITION, newPosition);
			
			trace(delta.toString());
			// wave.submit(delta);
		}
		
		public static function createNode(node:ClassDiagramNode):void
		{
			var delta:Delta = new Delta();
			
			delta.setValue(node.getIdentifier().getId(), node.getType());
			delta.setValue(node.getIdentifier().getId() + Delta.IDS_SEPERATOR + NAME, node.getName());
			WAOPosition.store(delta, node.getIdentifier().getId() + Delta.IDS_SEPERATOR + POSITION, node.getPosition());
		}
	}
}