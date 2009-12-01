package de.waveumleditor.model
{
	public class Identifier
	{
		private var id:String;
		
		public function Identifier(id:String)
		{
			this.id = id;
		}
		
		public function getId():String
		{
			return this.id;
		}
	}
}