package de.waveumleditor.model.wao.classDiagram
{
	import com.adobe.serialization.json.JSON;
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.EAssociationType;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.classDiagram.links.MImplementsLink;
	import de.waveumleditor.model.classDiagram.links.MInheritanceLink;
	import de.waveumleditor.model.wao.wave.Delta;
	
	/**
	 * This class maps ClassDiagramLink objects into key-value-pairs, which are
	 * stored in the Wave state.
	 * 
	 * @see de.waveumleditor.model.classDiagram.links.ClassDiagramLink
	 */ 
	public class WAOLink
	{
		private var wave:Wave;
		
		public static const FROMTO:String = "ft";
		public static const FROM:String = "f";
		public static const TO:String = "t";
		
		public static const SETTINGS:String = "s";
		
		public static const DEP_NAME:String = "n";
		
		public static const ASS_TYPE:String = "asst";
		public static const ASS_TO_NAME:String = "tn";
		public static const ASS_FROM_NAME:String = "fn";
		public static const ASS_TO_MULTIPLICITY:String = "tm";
		public static const ASS_FROM_MULTIPLICITY:String = "fm";
		public static const ASS_TO_NAVIGABLE:String = "tnav";
		public static const ASS_FROM_NAVIGABLE:String = "fnav";
				
		public function WAOLink(wave:Wave)
		{
			this.wave = wave;
		}
		
		public function createLink(link:MClassLink):void
		{
			var delta:Delta = new Delta();
			
			delta.setValue(link.getIdentifier().getId(), link.getLinkType());
			setFromTo(delta, link);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		public function updateLink(link:MDependencyLink):void
		{
			var delta:Delta = new Delta();
			
			var settingsData:Object = getEncodableSettingsObject(link);			
			var json:String = JSON.encode(settingsData);
			
			var key:String = link.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + SETTINGS;
			delta.setValue(key, json);
			
			trace(json);
			
			wave.submitDelta(delta.getWaveDelta());
		}
		
		/**
		 * Removes a link from the Wave state.
		 * 
		 * Note that the delta is only submitted, if no delta 
		 * was passed-in.
		 */ 
		public function removeLink(link:MClassLink, delta:Delta = null):void
		{
			var executeSubmit:Boolean = false;
			
			if (delta == null)
			{
				delta = new Delta();
				executeSubmit = true;
			}
			
			delta.setValue(link.getIdentifier().getId(), null);
			delta.setValue(link.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + FROMTO, null);	
			
			if (link is MDependencyLink)
			{
				delta.setValue(link.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + SETTINGS, null);	
			}
			
			if (executeSubmit)
			{
				// only submit if no delta was passed in
				wave.submitDelta(delta.getWaveDelta());
			}
		}
		
		private function getEncodableSettingsObject(link:MDependencyLink):Object
		{
			// build a plain object that can be encoded as JSON
			var settingsData:Object = new Object();
			
			settingsData[DEP_NAME] = link.getName();
			
			if (link is MAssociationLink)
			{
				var association:MAssociationLink = link as MAssociationLink;
				
				settingsData[ASS_TYPE] = association.getType().getValue();
				
				settingsData[ASS_FROM_NAME] = association.getFromName();
				settingsData[ASS_TO_NAME] = association.getToName();
				
				settingsData[ASS_FROM_MULTIPLICITY] = association.getFromMultiplicity();
				settingsData[ASS_TO_MULTIPLICITY] = association.getToMultiplicity();
				
				settingsData[ASS_FROM_NAVIGABLE] = association.getFromNavigable();
				settingsData[ASS_TO_NAVIGABLE] = association.getToNavigable();
			}
			
			return settingsData;
		}
	
		
		private function setFromTo(delta:Delta, link:MClassLink):void
		{
			var fromToData:Object = new Object();
			
			fromToData[FROM] = link.getLinkFrom().getIdentifier().getId();
			fromToData[TO] = link.getLinkTo().getIdentifier().getId();
			
			var json:String = JSON.encode(fromToData);
			
			trace(json);
			
			delta.setValue(link.getIdentifier().getId() + WAOKeyGenerator.IDS_SEPERATOR + FROMTO, json);	
		}
		
		public static function getFromState(linkId:String, 
			state:WaveState, diagram:MClassDiagram):MClassLink
		{
			var type:String = state.getStringValue(linkId);
			var fromTo:String = state.getStringValue(linkId + WAOKeyGenerator.IDS_SEPERATOR + FROMTO);
			
			if (type == null || fromTo == null)
			{
				return null;
			}
						
			var link:MClassLink = null;
			var id:Identifier = new Identifier(linkId);
			switch (type)
			{
				case MImplementsLink.TYPE:
					link = new MImplementsLink(id, null, null);
					break;
				
				case MInheritanceLink.TYPE:
					link = new MInheritanceLink(id, null, null);
					break;
					
				case MAssociationLink.TYPE:
					link = new MAssociationLink(id, null, null);
					getLinkSettings(state, linkId, link as MAssociationLink);
					break;
					
				case MDependencyLink.TYPE:
					link = new MDependencyLink(id, null, null);
					getLinkSettings(state, linkId, link as MDependencyLink);
					break;
				default:
					return null;
			}
			
			return getFromTo(fromTo, link, diagram);
		}
		
		private static function getFromTo(fromToValue:String, link:MClassLink,
			diagram:MClassDiagram):MClassLink
		{
			var fromToData:Object = JSON.decode(fromToValue);
			
			var nodeFrom:MClassDiagramNode = diagram.getNode(new Identifier(fromToData[FROM]));	
			var nodeTo:MClassDiagramNode = diagram.getNode(new Identifier(fromToData[TO]));
			
			if (nodeFrom == null || nodeTo == null)
			{
				return null;
			}
			else 
			{
				link.setFromTo(nodeFrom, nodeTo);
				
				return link;
			}
		} 
		
		private static function getLinkSettings(state:WaveState, linkId:String, link:MDependencyLink):void
		{
			var settingsValue:String = state.getStringValue(linkId + WAOKeyGenerator.IDS_SEPERATOR + SETTINGS);
			
			if (settingsValue == null || settingsValue == "")
			{
				return;
			}
			
			var settingsData:Object = JSON.decode(settingsValue);
			
			link.setName(settingsData[DEP_NAME]);
			
			if (link is MAssociationLink)
			{
				var association:MAssociationLink = link as MAssociationLink;
				
				association.setType(EAssociationType.getFromValue(settingsData[ASS_TYPE]));
				
				association.setFromName(settingsData[ASS_FROM_NAME]);
				association.setToName(settingsData[ASS_TO_NAME]);
				
				association.setFromMultiplicity(settingsData[ASS_FROM_MULTIPLICITY]);
			 	association.setToMultiplicity(settingsData[ASS_TO_MULTIPLICITY]);
				
				association.setFromNavigable(settingsData[ASS_FROM_NAVIGABLE]);
				association.setToNavigable(settingsData[ASS_TO_NAVIGABLE]);
			}
		}
	}
}