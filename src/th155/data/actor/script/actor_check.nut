function IsWall( vx_ )
{
	local X_ = this.x + vx_;

	if (X_ <= ::battle.corner_left)
	{
		return -1;
	}
	else if (X_ >= ::battle.corner_right)
	{
		return 1;
	}

	return 0;
}

function IsGround( vy_ )
{
	local Y_ = this.y;

	if (Y_ >= ::battle.corner_bottom)
	{
		return 1;
	}

	return 0;
}

function IsScreen( r_ )
{
	if (this.x <= ::battle.scroll_left - r_ || this.x >= ::battle.scroll_right + r_ || this.y <= ::battle.scroll_top - r_ || this.y >= ::battle.scroll_bottom + r_)
	{
		return true;
	}

	return false;
}

function IsCamera( r_ )
{
	if (this.x <= ::camera.camera2d.left - r_ || this.x >= ::camera.camera2d.right + r_ || this.y <= ::camera.camera2d.top - r_ || this.y >= ::camera.camera2d.bottom + r_)
	{
		return true;
	}

	return false;
}

function GetTargetDist( target_ )
{
	if (target_)
	{
		local t = target_;

		if (t.isActive)
		{
			local d = (t.x - this.x) * (t.x - this.x) + (t.y - this.y) * (t.y - this.y);
			return d;
		}
		else
		{
			return false;
		}
	}
	else
	{
		return false;
	}
}

