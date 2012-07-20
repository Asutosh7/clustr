/**
 * TODO:
	 * enable grid resolution configuration
	 * allow used to set a specific color to each cluster
	 * allow step by step playback
	 * 
 */

package 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.*;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Timer;
	
	import com.signalsondisplay.clustr.ClustrAnalyser;
	
	/**
	 * ...
	 * @author dotminic
	 */
	public class Main extends Sprite 
	{
		private var m_clustr:ClustrAnalyser;
		private var m_view:View;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event = null ):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			m_view = new View();
			//addChild(m_view);
			

			m_clustr = new ClustrAnalyser(1280, 720);
		}
		
		private function runAnalysis( e:Event ):void
		{
			/*
			m_visualizer.mouseChildren = false;
			m_visualizer.mouseEnabled = false;
			m_algorithm.run(m_visualizer.grid.cells, 32, 32);
			m_visualizer.displayClusters(m_algorithm.clusters);
			*/
		}
		
		private function gridToggleHandler( e:ToggleEvent ):void
		{
			//m_visualizer.toggleGrid(e.visible);
		}
		
		private function overlayToggleHandler( e:ToggleEvent ):void
		{
			//m_visualizer.toggleOverlay(e.visible);
		}
		
		private function mouseClickHandler( e:MouseEvent ):void
		{
			//m_bitmapData.setPixel(e.stageX, e.stageY, 0xFFFFFF);
			//m_grid.addNode(new ClusterNode(e.stageX, e.stageY));
			
			
			m_clustr.addNode(0, 0);
		}
		
		private function clearNodesHandler( e:Event ):void
		{
			m_clustr.clearAllNodes();
		}
	
	}
}