package de.waveumleditor.model
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	
	/**
	 * Type-safe map to store implementations of IIdentifiable which
	 * internally uses a Dictionary.
	 * 
	 * @see de.waveumleditor.model.IIdentifiable
	 */ 
	public class Map
	{
		private var delegate:Dictionary;
		
		public function Map()
		{
			delegate = new Dictionary();
		}
		
		public function setValue(value:IIdentifiable):void
		{
			if (value.getIdentifier() == null) 
			{
				throw new Error("The identifier must not be null");
			}
			
			delegate[value.getIdentifier().getId()] = value;
		}
		
		public function getValue(key:Identifier):IIdentifiable
		{
			return delegate[key.getId()];
		}

		public function removeValue(key:Identifier):void
		{
			delegate[key.getId()] = null;
		}
		
		public function getAsList():ArrayList
		{
			var list:ArrayList = new ArrayList();
			
			for (var key:Object in delegate)
			{
				if (key != null && delegate[key] != null) 
				{
					list.addItem(delegate[key]);
				}
			}
			
			return list;
		}
		
		public function getAsDictionary():Dictionary
		{
			var keys:Dictionary = new Dictionary();
			
			for (var key:Object in delegate)
			{
				if (key != null && delegate[key] != null) 
				{
					keys[key] = delegate[key];
				}
			}
			
			return keys;
		}
	}
}