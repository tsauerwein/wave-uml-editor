package de.waveumleditor.model.classDiagram.links
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	
	public class MAssociationLink extends MDependencyLink
	{
		private var toName:String = "";
		private var fromName:String = "";
		
		private var toMultiplicity:String = "";
		private var fromMultiplicity:String = "";
		
		private var toNavigable:Boolean = false;
		private var fromNavigable:Boolean = false;
		
		private var type:EAssociationType = EAssociationType.ASSOCIATION;
		
		public static const TYPE:String = "A";
		
		public function MAssociationLink(key:Identifier, 
			linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode, name:String = "")
		{
			super(key, linkFrom, linkTo, name);
		}

		public function getType():EAssociationType
		{
			return this.type;
		} 
		
		public function setType(type:EAssociationType):void
		{
			this.type = type;
		} 
		
		public function getFromName():String 
		{
			return this.fromName;
		}
		
		public function setFromName(fromName:String):void
		{
			this.fromName = fromName;
		}
		
		public function getFromMultiplicity():String 
		{
			return this.fromMultiplicity;
		}
		
		public function setFromMultiplicity(fromMultiplicity:String):void
		{
			this.fromMultiplicity = fromMultiplicity;
		}
		
		public function getToName():String 
		{
			return this.toName;
		}
		
		public function setToName(toName:String):void
		{
			this.toName = toName;
		}
		
		public function getToMultiplicity():String 
		{
			return this.toMultiplicity;
		}
		
		public function setToMultiplicity(toMultiplicity:String):void
		{
			this.toMultiplicity = toMultiplicity;
		}
		
		public function getToNavigable():Boolean
		{
			return this.toNavigable;
		} 
		
		public function setToNavigable(toNavigable:Boolean):void
		{
			this.toNavigable = toNavigable;
		} 

		public function getFromNavigable():Boolean
		{
			return this.fromNavigable;
		} 
		
		public function setFromNavigable(fromNavigable:Boolean):void
		{
			this.fromNavigable = fromNavigable;
		} 
		
		override public function updateFrom(link:MDependencyLink):void
		{
			super.updateFrom(link);
			
			if (!(link is MAssociationLink)) 
			{
				throw new Error("link is not type of LinkAssociation");
			}
			
			var linkAssocation:MAssociationLink = link as MAssociationLink;
			
			toName = linkAssocation.getToName();
			fromName = linkAssocation.getFromName();
			
			toMultiplicity = linkAssocation.getToMultiplicity();
			fromMultiplicity = linkAssocation.getFromMultiplicity();
			
			toNavigable = linkAssocation.getToNavigable();
			fromNavigable = linkAssocation.getFromNavigable();
			
			type = linkAssocation.getType();
		}
		
		override public function clone(id:Identifier):MDependencyLink
		{
			var copy:MAssociationLink = new MAssociationLink(id, getLinkFrom(), getLinkTo(), getName());
			copy.updateFrom(this);
			
			return copy;
		}
		
		override public function getLinkType():String
		{
			return TYPE;
		}
	}
}