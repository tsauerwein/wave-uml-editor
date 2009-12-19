package de.tests.waveumleditor.model.wao
{
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.wao.WAOPosition;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class WAOPositionTest extends TestCase
	{
		public function testStore():void
		{
			var position:Position = new Position(1, 2);
			var delta:Delta = new Delta();
			var key:String = "key";
			
			WAOPosition.store(delta, key, position);
			
			assertEquals("key : {\"x\":1,\"y\":2} \n ", delta.toString());
		}
	}
}