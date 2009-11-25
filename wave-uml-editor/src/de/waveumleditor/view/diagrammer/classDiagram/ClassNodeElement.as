package de.waveumleditor.view.diagrammer.classDiagram
{
	import de.waveumleditor.model.classDiagram.IClassElement;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Label;
	import mx.core.*;

	public class ClassNodeElement extends GridRow
	{
		
		public function ClassNodeElement(element:IClassElement)
		{
			super();
			var label:Label = new Label();
			var content:String = element.toString();
			label.text = content;

			/*
			if(element.isStatic())
			{
				var underlineFormat:TextFormat = new TextFormat();
	            underlineFormat.underline= true;
				label.setStyle("textFormat", underlineFormat);
				
			}
			if(element.isAbstract())
			{
				var italicFormat:TextFormat = new TextFormat();
	            italicFormat.italic = true;
				label.setStyle("textFormat", italicFormat);
			}
			*/
			if(element.isStatic())
			{
				content = "<u>"+content+"</u>";
			}
			
			if(element.isAbstract()){
				content= "<i>"+content+"</i>";
			}
			
			label.htmlText = content;
			
			
			var gridItem:GridItem = new GridItem();
			gridItem.setActualSize(100, 100);
			
			gridItem.addChild(label);
			this.addChild(gridItem);
		}
		
	}
}