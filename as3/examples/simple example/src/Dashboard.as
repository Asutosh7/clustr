package  
{
	import flash.display.Sprite;
	import com.bit101.components.PushButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * "run button"
	 * "view/hide" buttons for the grid and step by step visualizer
	 * options to allow resolution changes
	 * total nodes
	 * total clusters
	 * x/y mouse coords
	 */

	/**
	 * ...
	 * @author dotminic
	 */
	public class Dashboard extends Sprite
	{
		private static const WIDTH:int = 1280;
		private static const HEIGHT:int = 48;
		
		private var m_runButton:PushButton;
		private var m_gridToggle:PushButton;
		private var m_overlayToggle:PushButton;
		private var m_clearButton:PushButton;
		private var m_gridVisible:Boolean;
		private var m_overlayVisible:Boolean;
		
		public function Dashboard() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			graphics.beginFill(0x333333);
			graphics.drawRect(0, 0, WIDTH, HEIGHT);
			graphics.endFill();
			
			m_runButton = new PushButton(this, 0, 0, "run", runBtnHandler);
			//m_runButton.mouseEnabled = false;
			//m_runButton.enabled = false;
			
			m_gridToggle = new PushButton(this, m_runButton.width + 20, 0, "hide grid", gridToggleHandler);
			m_gridVisible = true;
			
			m_overlayToggle = new PushButton(this, m_gridToggle.x + m_gridToggle.width + 20, 0, "hide overlay", overlayToggleHandler);
			m_overlayVisible = true;
			
			m_clearButton = new PushButton(this, m_overlayToggle.x + m_overlayToggle.width + 20, 0, "clear nodes", clearNodesHandler);
		}
		
		private function runBtnHandler( e:MouseEvent ):void
		{
			trace("private function runBtnHandler( e:MouseEvent ):void");
			dispatchEvent(new Event(Event.SELECT));
		}
		
		private function gridToggleHandler( e:MouseEvent ):void
		{
			m_gridVisible = !m_gridVisible;
			dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE, m_gridVisible));
		}
		
		private function overlayToggleHandler( e:MouseEvent ):void
		{
			m_overlayVisible = !m_overlayVisible;
			dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE, m_overlayVisible));
		}
		
		private function clearNodesHandler( e:MouseEvent ):void
		{
			dispatchEvent(new Event(Event.CLEAR));
		}
	}
}