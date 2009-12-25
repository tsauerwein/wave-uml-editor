package de.waveumleditor.model.classDiagram.links
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MInterface;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	
	public class MInheritanceLink extends MClassLink
	{
		public static const TYPE:String = "IN";
		
		public function MInheritanceLink(key:Identifier, linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode)
		{
			super(key, linkFrom, linkTo);
		}

		public override function canLink(linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode):Boolean 
		{	
			if (linkFrom is MClassNode && linkTo is MClassNode) return true;
			if (linkFrom is MInterface && linkTo is MInterface) return true;
			
			return false;
		}
		
		override public function getLinkType():String
		{
			return TYPE;
		}
		
	}
}