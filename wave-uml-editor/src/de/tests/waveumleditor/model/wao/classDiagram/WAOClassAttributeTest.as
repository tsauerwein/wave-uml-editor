package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.tests.TestUtil;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassAttribute;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class WAOClassAttributeTest extends TestCase
	{
		public function testStore():void
		{
			var delta:Delta = new Delta();
			
			var attribute:MClassAttribute = new MClassAttribute(new Identifier("attrId"), new MVariable("a", MType.INT), EVisibility.PUBLIC);
			
			WAOClassAttribute.store(delta, "classId", attribute);
			
			assertNotNull(delta.getWaveDelta()["classId_attrId"]);
			
			var json:String = delta.getWaveDelta()["classId_attrId"];
			assertTrue(TestUtil.contains(json, "\"" + WAOClassAttribute.VISIBILITY + "\":0"));
			assertTrue(TestUtil.contains(json, "\"" + WAOClassAttribute.STATIC + "\":false"));
			assertTrue(TestUtil.contains(json, "\"" + WAOClassAttribute.VARIABLE + "\":{"));
		}
		
		public function testGetFromState():void
		{
			var delta:Delta = new Delta();
			
			var attributeId:String = "A-attrId";
			var classId:String = "C-classId";
			
			var attribute:MClassAttribute = new MClassAttribute(new Identifier(attributeId), new MVariable("a", MType.INT), EVisibility.PUBLIC);
			
			WAOClassAttribute.store(delta, classId, attribute);
			
			var key:String = classId + WAOKeyGenerator.IDS_SEPERATOR + attributeId;
			var json:String = delta.getWaveDelta()[key];
			
			var restoredAttribute:MClassAttribute = WAOClassAttribute.getFromState(key, json);
			
			assertEquals(attribute.getIdentifier().getId(), restoredAttribute.getIdentifier().getId());
			assertEquals(attribute.getVisibility().getValue(), restoredAttribute.getVisibility().getValue());
			assertEquals(attribute.isStatic(), restoredAttribute.isStatic());
			assertEquals(attribute.getVariable().getName(), restoredAttribute.getVariable().getName());
		}
	}
}