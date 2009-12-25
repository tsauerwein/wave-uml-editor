package de.waveumleditor.view.diagrammer.classDiagram
{
	import mx.controls.Label;
	import de.waveumleditor.model.classDiagram.nodes.IClassElement;
	
	public class Formatter
	{
		public function Formatter()
		{
			
		}

		public static function formatLabelOfClassElement(element:IClassElement, label:Label):void
		{
			
			var content:String = element.toString();
			label.text=content;
	
			if(element.isStatic())
			{
				label.setStyle("textDecoration","underline");
			}
			if(element.isAbstract())
			{
				label.setStyle("fontStyle","italic");
			}

		}
	}
}