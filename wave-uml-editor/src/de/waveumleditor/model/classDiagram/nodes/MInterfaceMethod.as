package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	
	public class MInterfaceMethod extends MClassMethod implements IClassElement
	{
		
		public function MInterfaceMethod(key:Identifier, name:String, returnType:MType)
		{
			super(key, name, EVisibility.PUBLIC, returnType, true);
		}
		
		public override function setVisibility(visibility:EVisibility):void
		{
			super.setVisibility(EVisibility.PUBLIC);
		}
		
		public override function setAbstract(abstract:Boolean):void
		{
			super.setAbstract(true);
		}
		
		public override function setStatic(is_static:Boolean):void
		{
			super.setStatic(false);
		}
	}
}