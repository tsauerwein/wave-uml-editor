package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;

	/**
	 * This class is responsible for restoring a link from
	 * the wave state. 
	 *
	 * @see de.waveumleditor.model.wao.classDiagram.WAODiagram
	 */  
	public class WAOLinkParser
	{
		private var linkId:String;		
		
		public function WAOLinkParser(linkId:String)
		{
			this.linkId = linkId;
		}

		public function getLink(state:WaveState, diagram:ClassDiagram):ClassDiagramLink
		{
			return WAOLink.getFromState(linkId, state, diagram);
		}
	}
}