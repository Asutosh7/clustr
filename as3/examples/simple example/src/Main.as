/**
 * TODO:
	 * total number of nodes
	 * total number of populated cells
	 * enable grid resolution configuration
	 * allow used to set a specific color to each cluster
	 * allow step by step playback
	 * 
 */

package 
{
	import com.signalsondisplay.clustr.Cluster;
	import flash.events.*;
	import events.*;
	import flash.display.Sprite;
	
	import com.signalsondisplay.clustr.ClustrAnalyser;
	
	/**
	 * ...
	 * @author dotminic
	 */
	public class Main extends Sprite 
	{
		private var m_clustr:ClustrAnalyser;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event = null ):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			view.setController(this);
			m_clustr = new ClustrAnalyser(1280, 720);
		}
		
		public function runAnalysis( rx:int, ry:int ):Vector.<Cluster>
		{
			m_clustr.run(rx, ry);
			return m_clustr.clusters;
		}
		
		public function addNodeToGrid( x:Number, y:Number ):void
		{
			m_clustr.addNode(x, y);
		}

		public function clearNodesHandler():void
		{
			m_clustr.clearAllNodes();
		}	
	}
}