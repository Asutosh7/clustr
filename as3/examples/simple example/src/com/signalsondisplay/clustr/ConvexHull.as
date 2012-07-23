package com.signalsondisplay.clustr
{
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dotminic
	 */
	public class ConvexHull
	{
		private const TWO_PI:Number = 6.28318531;
		
		private var m_vertices:Vector.<ClusterNode>;
		private var m_result:Vector.<ClusterNode>;
		private var m_angleOffset:Number;
		private var m_initialPoint:ClusterNode;
		private var m_currentPoint:ClusterNode;

		public function ConvexHull()
		{
			m_initialPoint = new ClusterNode();
			m_currentPoint = new ClusterNode();
			m_result = new Vector.<ClusterNode>();
		}

		public function compute( vertices:Vector.<ClusterNode> ):Vector.<ClusterNode>
		{
			var target:ClusterNode = null;
			var angle:Number;
			var prevAngle:Number;
			var index:int;

			m_vertices = vertices;
			findInitialPoint();
			m_currentPoint = m_initialPoint;
			while (target != m_initialPoint)
			{
				prevAngle = Number.MAX_VALUE;
				index = 0;
				for (var i:int = 0; i < m_vertices.length; i++)
				{
					var p:ClusterNode = m_vertices[i];
					if ( p == m_currentPoint ) continue;
					var dx:Number = p.x - m_currentPoint.x;
					var dy:Number = p.y - m_currentPoint.y;
					angle = Math.atan2( dy, dx );
					angle -= m_angleOffset;
					if (angle < 0) angle *= -1;
					else angle = TWO_PI - angle;
					if (angle < 0) angle = TWO_PI + angle;
					if (angle <= prevAngle)
					{
						prevAngle = angle;
						target = p;
						index = i;
					}
				}
				m_result.push(target);
				m_currentPoint = target;
				m_angleOffset -= prevAngle;
				m_vertices.splice(index, 1);
			}
			return m_result;
		}

		private function findInitialPoint():void
		{
			var index:int = 0;

			m_result.length = 0;
			m_angleOffset = 0;
			m_initialPoint.x = m_initialPoint.y = 0;
			for (var i:int = 0; i < m_vertices.length; i++)
			{
				var p:ClusterNode = m_vertices[i];
				if (p.x > m_initialPoint.x)
				{
					m_initialPoint = p;
					index = i;
				}
			}
			if (index)
			{
				var tmp:ClusterNode = m_vertices[index];
				m_vertices[index] = m_vertices[0];
				m_vertices[0] = tmp;
			}
			m_result.push(m_initialPoint);
		}
	}
}