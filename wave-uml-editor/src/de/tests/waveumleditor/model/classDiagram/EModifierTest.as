package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.EModifier;
	
	import flexunit.framework.TestCase;
	
	public class EModifierTest extends TestCase
	{
		public function EModifierTest()
		{
		}
		
		public function testToString():void
		{
			var modifier:EModifier = EModifier.FINAL;
			
			trace(modifier.toString());
			
			assertEquals("final", modifier.toString());
		}
		
	}
}