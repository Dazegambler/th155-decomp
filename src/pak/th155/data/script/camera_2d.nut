function UpdateDebugCamera( camera )
{
	local a_ = ::battle.team[0].current;

	if (a_.input.x > 0)
	{
		::camera.target_x += 2;
	}

	if (a_.input.x < 0)
	{
		::camera.target_x -= 2;
	}

	if (a_.input.y > 0)
	{
		::camera.target_y += 2;
	}

	if (a_.input.y < 0)
	{
		::camera.target_y -= 2;
	}

	if (a_.input.b0 > 0)
	{
		::camera.target_zoom += 0.01000000;
	}

	if (a_.input.b1 > 0)
	{
		::camera.target_zoom -= 0.01000000;

		if (::camera.target_zoom < 1.00000000)
		{
			::camera.target_zoom = 1.00000000;
		}
	}

	::camera.UpdateBattleCamera.call(this, camera);
}

function UpdateBattleCamera( camera )
{
	local sx = camera.target_x - this.x;
	local sy = camera.target_y - this.y;

	if (sx * sx + sy * sy < 1)
	{
		this.x = camera.target_x;
		this.y = camera.target_y;
	}
	else
	{
		this.x += (camera.target_x - this.x) * 0.20000000;
		this.y += (camera.target_y - this.y) * 0.20000000;
	}

	this.offset_x = camera.offset_x;
	this.offset_y = camera.offset_y;
	this.left = this.x - this.cx / camera.zoom;
	this.top = this.y - this.cy / camera.zoom;

	if (this.left < camera.left)
	{
		this.left = camera.left;
	}

	if (this.top < camera.top)
	{
		this.top = camera.top;
	}

	this.right = this.left + camera.width / camera.zoom;
	this.bottom = this.top + camera.height / camera.zoom;

	if (this.right > camera.right)
	{
		local c = this.right - camera.right;
		this.right = camera.right;
		this.left -= c;
	}

	if (this.bottom > camera.bottom)
	{
		local c = this.bottom - camera.bottom;
		this.bottom = camera.bottom;
		this.top -= c;
	}
}

function UpdaetEventCamera( camera )
{
	camera.zoom = 2.00000000;
	this.x = (camera.left + camera.right) * 0.50000000;
	this.y = (camera.top + camera.bottom) * 0.50000000;
	this.left = this.x - 640;
	this.right = this.x + 640;
	this.top = this.y - 360;
	this.bottom = this.y + 360;
}

