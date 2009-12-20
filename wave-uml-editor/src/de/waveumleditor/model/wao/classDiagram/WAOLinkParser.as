package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class WAOLinkParser
	{
		private var linkId:String;		
		private var nodeKeys:IList = new ArrayList();
		
		public function WAOLinkParser(linkId:String)
		{
			this.linkId = linkId;
		}

		public function addKey(key:String):void
		{
			nodeKeys.addItem(key);
		}

		public function getLink(state:WaveState, diagram:ClassDiagram):ClassDiagramLink
		{
			return null;
		}
	}
}