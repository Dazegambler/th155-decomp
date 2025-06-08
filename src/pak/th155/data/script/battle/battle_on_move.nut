function OnMove()
{
	if (this.slow_count & 1)
	{
		return;
	}

	if (this.time_stop_count)
	{
		return;
	}

	local p0 = this.team[0].current;
	local p1 = this.team[1].current;

	foreach( val, b in this.team )
	{
		local a = b.current;

		if (a && this.team[1 - val].time_stop_count == 0)
		{
			if (a.hitStopTime + a.damageStopTime == 0)
			{
				if (a.vf.x)
				{
					if (this.abs(a.vf.x) > 1.00000000)
					{
						a.vf.x -= a.vf.x > 0.00000000 ? 1.00000000 : -1.00000000;
					}
					else
					{
						a.vf.x = 0.00000000;
					}
				}

				if (a.vfBaria.x)
				{
					if (this.abs(a.vfBaria.x) > 1.00000000)
					{
						a.vfBaria.x -= a.vfBaria.x > 0.00000000 ? 1.00000000 : -1.00000000;
					}
					else
					{
						a.vfBaria.x = 0.00000000;
					}
				}

				a.SetSpeed_XY(null, null);
			}
			else if (a.hitStopTime)
			{
				a.vy = 0;
				a.vx = 0;
			}
			else
			{
				a.SetSpeed_XY(null, null);
			}
		}
		else
		{
			a.vy = 0;
			a.vx = 0;
		}
	}

	local corner0 = p0.IsWall(p0.vx);
	local corner1 = p1.IsWall(p1.vx);

	if (this.corner_right_actor == 0 && corner0 != 1)
	{
		this.corner_right_actor = -1;
	}
	else if (this.corner_right_actor == 1 && corner1 != 1)
	{
		this.corner_right_actor = -1;
	}

	if (this.corner_left_actor == 0 && corner0 != -1)
	{
		this.corner_left_actor = -1;
	}
	else if (this.corner_left_actor == 1 && corner1 != -1)
	{
		this.corner_left_actor = -1;
	}

	if (!p0.freeMap)
	{
		if (p0.y + p0.vy >= this.corner_bottom)
		{
			p0.vy = this.corner_bottom - p0.y;
		}

		if (p0.x + p0.vx <= this.corner_left)
		{
			p0.vx = this.corner_left - p0.x;

			if (this.corner_left_actor == -1)
			{
				this.corner_left_actor = 0;
			}
		}
		else if (p0.x + p0.vx >= this.corner_right)
		{
			p0.vx = this.corner_right - p0.x;

			if (this.corner_right_actor == -1)
			{
				this.corner_right_actor = 0;
			}
		}
	}

	if (!p1.freeMap)
	{
		if (p1.y + p1.vy >= this.corner_bottom)
		{
			p1.vy = this.corner_bottom - p1.y;
		}

		if (p1.x + p1.vx >= this.corner_right)
		{
			p1.vx = this.corner_right - p1.x;

			if (this.corner_right_actor == -1)
			{
				this.corner_right_actor = 1;
			}
		}
		else if (p1.x + p1.vx <= this.corner_left)
		{
			p1.vx = this.corner_left - p1.x;

			if (this.corner_left_actor == -1)
			{
				this.corner_left_actor = 1;
			}
		}
	}

	local left0 = p0.left + p0.vx;
	local right1 = p1.right + p1.vx;

	if (left0 > right1)
	{
		return;
	}

	local left1 = p1.left + p1.vx;
	local right0 = p0.right + p0.vx;

	if (right0 < left1)
	{
		return;
	}

	local top0 = p0.top + p0.vy;
	local bottom1 = p1.bottom + p1.vy;

	if (top0 > bottom1)
	{
		return;
	}

	local top1 = p1.top + p1.vy;
	local bottom0 = p0.bottom + p0.vy;

	if (bottom0 < top1)
	{
		return;
	}

	if (p0.left == p0.right || p1.left == p1.right || p0.collisionFree || p1.collisionFree)
	{
		return;
	}

	local x0 = p0.x + p0.vx;
	local x1 = p1.x + p1.vx;

	if (corner0 == 1 && this.corner_right_actor == 0)
	{
		p1.vx = p0.left - p1.right;
	}
	else if (corner1 == 1 && this.corner_right_actor == 1)
	{
		p0.vx = p1.left - p0.right;
	}
	else if (corner1 == -1 && this.corner_left_actor == 1)
	{
		p0.vx = p1.right - p0.left;
	}
	else if (corner0 == -1 && this.corner_left_actor == 0)
	{
		p1.vx = p0.right - p1.left;
	}
	else if (x0 > x1)
	{
		local dx = (right1 - left0) / 2.00000000;
		p0.vx += dx;
		p1.vx -= dx;

		if (p0.IsWall(p0.vx) == 1)
		{
			local t = p0.x + p0.vx - this.corner_right;
			p0.vx -= t;
			p1.vx -= t;
		}
		else if (p1.IsWall(p1.vx) == -1)
		{
			local t = p1.x + p1.vx - this.corner_left;
			p0.vx -= t;
			p1.vx -= t;
		}
	}
	else
	{
		local dx = (right0 - left1) / 2.00000000;
		p0.vx -= dx;
		p1.vx += dx;

		if (p1.IsWall(p1.vx) == 1)
		{
			local t = p1.x + p1.vx - this.corner_right;
			p0.vx -= t;
			p1.vx -= t;
		}
		else if (p0.IsWall(p0.vx) == -1)
		{
			local t = p0.x + p0.vx - this.corner_left;
			p0.vx -= t;
			p1.vx -= t;
		}
	}

	p0.Warp(p0.x + p0.vx, p0.y + p0.vy);
	p0.vx = 0;
	p0.vy = 0;
	p1.Warp(p1.x + p1.vx, p1.y + p1.vy);
	p1.vx = 0;
	p1.vy = 0;
}

