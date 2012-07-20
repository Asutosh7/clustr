package com.signalsondisplay.clustr
{
	/**
	 * ...
	 * @author dotminic
	 */
	internal class Grid
	{
		private var m_resx:uint;
		private var m_resy:uint;
		private var m_width:int;
		private var m_height:int;
		private var m_buckets:Vector.<GridCell>;
		
		public function Grid( width:int, height:int )
		{
			m_width = width;
			m_height = height;
			m_resx = m_resy = 32;
			m_buckets = new Vector.<GridCell>(m_resx * m_resy, true);
			for (var i:int = 0; i < m_resx * m_resy; i++)
				m_buckets[i] = new GridCell();
		}

		public function set resolution( r:uint ):void
		{
			var b:Boolean = r && !(r & (r - 1));
			if (!b)
				throw new Error("resolution must be a power of 2");
			m_resx = m_resy = r;
		}

		public function get cells():Vector.<GridCell>
		{
			return m_buckets;
		}

		public function addNodeToCell( node:ClusterNode, i:int, i:int ):void
		{
			m_buckets[i + m_resx * j].addNode(node);
		}
		
		public function addNode( node:ClusterNode ):void
		{
			/*
			var x:int = node.x / stage.stageWidth * m_resx;
			var y:int = node.y / stage.stageHeight * m_resy;
			*/
			
			var x:int = node.x / m_width * m_resx;
			var y:int = node.y / m_height * m_resy;

			if (!m_buckets[x + m_resx * y])
				m_buckets[x + m_resx * y] = new GridCell();
			m_buckets[x + m_resx * y].addNode(node);
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < m_buckets.length; i++)
				m_buckets[i].clear();
			m_buckets.length = 0;
		}
	}
}