package de.waveumleditor.model.classDiagram.link
{
	/**
	 * Enumeration for association type. 
	 * Possible values are:
	 * 	- ASSOCIATION
	 * 	- AGGREGATION
	 *  - COMPOSITION
	 * 
	 * The constructor should not be called!
	 */ 
	public class EAssociationType
	{
		private var value:int;
				
		public static const ASSOCIATION:EAssociationType = new EAssociationType(0);
		public static const AGGREGATION:EAssociationType = new EAssociationType(1);
		public static const COMPOSITION:EAssociationType = new EAssociationType(2);
		
		/**
		 * Do not call!
		*/
		public function EAssociationType(value:int)
		{
			this.value = value;
		}
		
		public function getValue():int
		{
			return this.value;
		}
		
		public static function getFromValue(value:int):EAssociationType
		{
			switch(value)
			{
				case AGGREGATION.value:
					return AGGREGATION;
				case COMPOSITION.value:
					return COMPOSITION;
				default:
					return ASSOCIATION;
			}
		}
	}
}