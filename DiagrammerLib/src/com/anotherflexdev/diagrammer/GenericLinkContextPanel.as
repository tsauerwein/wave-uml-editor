package com.anotherflexdev.diagrammer {
	import mx.containers.Canvas;

	public class GenericLinkContextPanel extends Canvas {
		
		[Bindable] public var linkName:String;
		[Bindable] public var linkMultiplicityFrom:String;
		[Bindable] public var linkMultiplicityTo:String;
		[Bindable] public var linkAttributeFrom:String;
		[Bindable] public var linkAttributeTo:String;
		[Bindable] public var linkNavigable:String;
	}
}