package
{
	import flash.events.Event;

	/**
	 * ...
	 * @author dotminic
	 */
	public class ResolutionEvent extends Event
	{
		public static const CHANGED:String = "resolutionChanged";
		
		private var m_resx:int;
		private var m_resy:int;
		
		public function ResolutionEvent( type:String, rx:int, ry:int )
		{
			super(type, true, false);
			m_resx = rx;
			m_resy = ry;
		}

		public function get resx():int
		{
			return m_resx;
		}

		public function get resy():int
		{
			return m_resy;
		}
	}
}