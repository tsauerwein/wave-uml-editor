package de.tests.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.tests.TestUtil;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;
	
	public class WAOLinkTest extends TestCase
	{
		public function testCreateLink():void
		{
			var wave:Wave = new WaveSimulator();
			var waoLink:WAOLink = new WAOLink(wave);
			
			var nodeFrom:UMLClass = new UMLClass(new Identifier("cfrom"), null);
			var nodeTo:UMLClass = new UMLClass(new Identifier("cto"), null);
			
			var link:ClassDiagramLink = new LinkDependency(new Identifier("lid"), nodeFrom, nodeTo);
						
			waoLink.createLink(link);
			
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(link.getIdentifier().getId()), link.getLinkType());
			
			var fromto:String = newState.getStringValue(link.getIdentifier().getId() + Delta.IDS_SEPERATOR + WAOLink.FROMTO);
			assertNotNull(fromto);
			assertTrue(TestUtil.contains(fromto, "\"" + WAOLink.FROM + "\":\"cfrom\""));
			assertTrue(TestUtil.contains(fromto, "\"" + WAOLink.TO + "\":\"cto\""));
		}
		
		public function testUpdateLink():void
		{
			var wave:Wave = new WaveSimulator();
			var waoLink:WAOLink = new WAOLink(wave);
						
			var link:LinkAssociation = new LinkAssociation(new Identifier("lid"), null, null);
			
			link.setName("name");
			link.setFromName("fname");
			link.setToName("tname");
			link.setFromMultiplicity("fmult");
			link.setToMultiplicity("tmult");
			link.setToNavigable(true);
			link.setFromNavigable(false);
			
			waoLink.updateLink(link);
			
			var newState:WaveState = wave.getState();
			
			var key:String = "lid" + Delta.IDS_SEPERATOR + WAOLink.SETTINGS;
			var value:String = newState.getStringValue(key);
			
			assertNotNull(value);	
			
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.DEP_NAME + "\":\"" + link.getName() + "\""));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_FROM_NAME + "\":\"" + link.getFromName() + "\""));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_TO_NAME + "\":\"" + link.getToName() + "\""));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_FROM_MULTIPLICITY + "\":\"" + link.getFromMultiplicity() + "\""));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_TO_MULTIPLICITY + "\":\"" + link.getToMultiplicity() + "\""));	
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_FROM_NAVIGABLE + "\":" + link.getFromNavigable()));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_TO_NAVIGABLE + "\":" + link.getToNavigable()));
			assertTrue(TestUtil.contains(value, "\"" + WAOLink.ASS_TYPE + "\":" + link.getType().getValue()));
		}
	}
}