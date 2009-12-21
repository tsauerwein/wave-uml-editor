package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.tests.TestUtil;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassAttribute;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class WAOClassAttributeTest extends TestCase
	{
		public function testStore():void
		{
			var delta:Delta = new Delta();
			
			var attribute:ClassAttribute = new ClassAttribute(new Identifier("attrId"), new Variable("a", Type.INT), EVisibility.PUBLIC);
			
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
			
			var attribute:ClassAttribute = new ClassAttribute(new Identifier(attributeId), new Variable("a", Type.INT), EVisibility.PUBLIC);
			
			WAOClassAttribute.store(delta, classId, attribute);
			
			var key:String = classId + WAOKeyGenerator.IDS_SEPERATOR + attributeId;
			var json:String = delta.getWaveDelta()[key];
			
			var restoredAttribute:ClassAttribute = WAOClassAttribute.getFromState(key, json);
			
			assertEquals(attribute.getIdentifier().getId(), restoredAttribute.getIdentifier().getId());
			assertEquals(attribute.getVisibility().getValue(), restoredAttribute.getVisibility().getValue());
			assertEquals(attribute.isStatic(), restoredAttribute.isStatic());
			assertEquals(attribute.getVariable().getName(), restoredAttribute.getVariable().getName());
		}
	}
}