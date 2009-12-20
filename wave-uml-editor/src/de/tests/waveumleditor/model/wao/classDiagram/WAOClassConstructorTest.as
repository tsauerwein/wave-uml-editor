package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassConstructor;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;
	
	
	public class WAOClassConstructorTest extends TestCase
	{
		public function testStore():void
		{
			var delta:Delta = new Delta();
			
			var c:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("coId"), EVisibility.PUBLIC);
			
			c.addVariable(new Variable("a", Type.STRING));
			c.addVariable(new Variable("b", Type.INT, "0"));
			
			WAOClassConstructor.store(delta, "classId", c);
		
			assertNotNull(delta.getWaveDelta()["classId" + Delta.IDS_SEPERATOR + "coId"]);
		}
		
		public function testGetEncodableObject():void
		{
			var c:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("coId"), EVisibility.PUBLIC);
			
			c.addVariable(new Variable("a", Type.STRING));
			c.addVariable(new Variable("b", Type.INT, "0"));
			
			var obj:Object = WAOClassConstructor.getEncodableObject(c);
			
			assertEquals(c.getVisibility().getValue(), obj[WAOClassConstructor.VISIBILITY]);
			
			assertTrue(obj[WAOClassConstructor.PARAMETERS] is Array);
			
			var params:Array = obj[WAOClassConstructor.PARAMETERS] as Array;
			assertEquals(2, params.length);
		}
		
		public function testGetFromState():void
		{
			var constrId:String = "CO-constr";
			var classId:String = "C-classId";
			
			var c:ClassConstructorMethod = new ClassConstructorMethod(new Identifier(constrId), EVisibility.PUBLIC);
			c.addVariable(new Variable("a", Type.STRING));
			c.addVariable(new Variable("b", Type.INT, "0"));
			
			var delta:Delta = new Delta();
			WAOClassConstructor.store(delta, classId, c);
			
			var key:String = classId + Delta.IDS_SEPERATOR + constrId;
			var json:String = delta.getWaveDelta()[key];
			
			var restoredConstr:ClassConstructorMethod = WAOClassConstructor.getFromState(key, json, null);
			
			assertEquals(c.getIdentifier().getId(), restoredConstr.getIdentifier().getId());
			assertEquals(c.getVisibility().getValue(), restoredConstr.getVisibility().getValue());
			assertEquals(c.getVariables().length, restoredConstr.getVariables().length);
		}
	}
}