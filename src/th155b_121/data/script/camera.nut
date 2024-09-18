this.width <- 1280;
this.height <- 720;
this.center_x <- this.width / 2;
this.center_y <- this.height / 2;
this.left <- 0;
this.top <- 0;
this.right <- this.width;
this.bottom <- this.height;
this.offset_x <- 0;
this.offset_y <- 0;
this.shake_count <- 0;
this.shake_radius <- 0;
this.target_object <- [];
this.target_x <- 0;
this.target_y <- 0;
this.target_zoom <- 2.00000000;
this.zoom <- this.target_zoom;
this.auto_target <- true;
this.auto_zoom_limit <- 2.00000000;
this.lock <- false;
this.camera2d <- null;
this.camera3d <- null;
this.func_update_2d <- null;
this.func_update_3d <- null;
::manbow.CompileFile("data/script/camera_2d.nut", this);
::manbow.CompileFile("data/script/camera_3d.nut", this);
function Initialize()
{
	this.camera2d = ::manbow.Camera2D();
	this.camera3d = ::manbow.Camera3D();
	this.camera2d.width = this.width;
	this.camera2d.height = this.height;
	this.camera2d.depth = 32768.00000000;
	this.camera2d.x = this.target_x = 0;
	this.camera2d.y = this.target_y = 0;
	this.camera2d.cx = this.center_x;
	this.camera2d.cy = this.center_y;
	this.camera3d.width = this.width;
	this.camera3d.height = this.height;
	this.camera2d.render_target_width = this.width;
	this.camera2d.render_target_height = this.height;
	this.camera3d.render_target_width = this.width;
	this.camera3d.render_target_height = this.height;
	this.camera3d.ConnectRenderSlot(::graphics.slot.background3d_0, -1);
	this.camera3d.ConnectRenderSlot(::graphics.slot.background3d_1, -1);
	this.camera3d.ConnectRenderSlot(::graphics.slot.background3d_2, -1);
	this.camera2d.ConnectRenderSlot(::graphics.slot.actor, -1);
	this.camera2d.ConnectRenderSlot(::graphics.slot.background2d_0, -1);
	this.camera2d.ConnectRenderSlot(::graphics.slot.background2d_1, -1);
	this.shake_count = 0;
	this.shake_radius = 0;
	this.offset_x = 0;
	this.offset_y = 0;
	this.target_object.resize(0);
	this.auto_target = true;
	this.lock = false;
	this.SetMode_Battle();
	this.func_update_3d = this.UpdateCamera3D;
	::manbow.effect.ConnectCamera(this.camera2d);
}

function Clear()
{
	this.shake_count = 0;
	this.shake_radius = 0;
	this.offset_x = 0;
	this.offset_y = 0;
	this.target_object.resize(0);
	this.auto_zoom_limit = 2.00000000;
	this.auto_target = true;
	this.lock = false;
}

function Reset()
{
	this.UpdateTarget();
	this.zoom = this.target_zoom;
	this.camera2d.x = this.target_x;
	this.camera2d.y = this.target_y;

	if (this.func_update_2d)
	{
		this.func_update_2d.call(this.camera2d, this);
	}

	if (this.func_update_3d)
	{
		this.func_update_3d.call(this.camera3d, this);
	}

	this.camera2d.UpdateViewProjectionMatrix();
	this.camera3d.UpdateViewProjectionMatrix();
}

function Update()
{
	this.UpdateTarget();

	if (this.func_update_2d)
	{
		this.func_update_2d.call(this.camera2d, this);
	}

	if (this.func_update_3d)
	{
		this.func_update_3d.call(this.camera3d, this);
	}

	this.camera2d.UpdateViewProjectionMatrix();
	this.camera3d.UpdateViewProjectionMatrix();
}

function SetTarget( _x, _y, _zoom, immediate )
{
	if (this.lock)
	{
		return;
	}

	this.auto_target = false;

	if (_x != null)
	{
		this.target_x = _x;
	}

	if (_y != null)
	{
		this.target_y = _y;
	}

	this.target_zoom = _zoom;

	if (immediate)
	{
		if (this.camera2d)
		{
			this.camera2d.x = this.target_x;
			this.camera2d.y = this.target_y;
		}

		this.zoom = this.target_zoom;
	}
}

function ResetTarget()
{
	if (this.lock)
	{
		return;
	}

	this.auto_target = true;
}

function ForceTarget()
{
	this.UpdateTarget();
	this.zoom = this.target_zoom;
	this.camera2d.x = this.target_x;
	this.camera2d.y = this.target_y;

	if (this.func_update_2d)
	{
		this.func_update_2d.call(this.camera2d, this);
	}

	if (this.func_update_3d)
	{
		this.func_update_3d.call(this.camera3d, this);
	}

	this.camera2d.UpdateViewProjectionMatrix();
	this.camera3d.UpdateViewProjectionMatrix();
}

function SetMode_Battle()
{
	this.auto_target = true;
	this.ResetTarget();
	this.func_update_2d = this.UpdateBattleCamera;
	this.func_update_2d.call(this.camera2d, this);
}

function SetMode_Debug()
{
	this.ResetTarget();
	this.auto_target = false;
	this.target_x = 640;
	this.target_y = 360;
	this.zoom = 1.00000000;
	this.func_update_2d = this.UpdateDebugCamera;
	this.func_update_2d.call(this.camera2d, this);
}

function SetMode_BattleBegin()
{
}

function SetMode_Talk()
{
	this.func_update_2d = this.UpdateEventCamera;
	this.func_update_2d.call(this.camera2d, this);
}

function SetVibration( power )
{
	this.shake_radius = power;
}

function Shake( power )
{
	if (this.shake_radius > power)
	{
		return;
	}

	this.shake_radius = power;
}

function AddTarget( obj )
{
	this.target_object.append(obj.weakref());
}

function RemoveTarget( obj )
{
	for( local i = 0; i < this.target_object.len(); i++ )
	{
		if (this.target_object[i] == obj)
		{
			this.target_object.remove(i);
			return;
		}
	}
}

function UpdateTarget()
{
	if (this.auto_target && this.target_object.len() > 0)
	{
		local _min_x = this.target_object[0].x;
		local _max_x = _min_x;
		local _min_y = this.target_object[0].y;
		local _max_y = _min_y;
		local _num = 0;

		for( local i = 1; i < this.target_object.len(); i++ )
		{
			local target = this.target_object[i];

			if (target)
			{
				if (this.target_object[i].autoCamera == false)
				{
					target = this.target_object[i].cameraPos;
				}

				if (_min_x > target.x)
				{
					_min_x = target.x;
				}
				else if (_max_x < target.x)
				{
					_max_x = target.x;
				}

				if (_min_y > target.y)
				{
					_min_y = target.y;
				}
				else if (_max_y < target.y)
				{
					_max_y = target.y;
				}

				_num++;
			}
		}

		this.target_x = (_min_x + _max_x) * 0.50000000;
		this.target_y = -20 + (_min_y + _max_y) * 0.50000000;
		local distX = _max_x - _min_x + 280.00000000 - 180.00000000 * (2.00000000 - this.zoom) * (2.00000000 - this.zoom);
		local _zoomRateX = 2.00000000 - (distX - 640.00000000) / 640.00000000;
		local distY = _max_y - _min_y + 160.00000000 - 80.00000000 * (2.00000000 - this.zoom);
		local _zoomRateY = 2.00000000 - (distY - 360.00000000) / 360.00000000;
		this.target_zoom = _zoomRateX < _zoomRateY ? _zoomRateX : _zoomRateY;

		if (this.target_zoom > this.auto_zoom_limit)
		{
			this.target_zoom = this.auto_zoom_limit;
		}
		else if (this.target_zoom < 1.00000000)
		{
			this.target_zoom = 1.00000000;
		}

		local cx = this.center_x / this.target_zoom;
		local cy = this.center_y / this.target_zoom;

		if (this.target_x < this.left + cx)
		{
			this.target_x = this.left + cx;
		}
		else if (this.target_x > this.right - cx)
		{
			this.target_x = this.right - cx;
		}

		if (this.target_y < this.top + cy)
		{
			this.target_y = this.top + cy;
		}
		else if (this.target_y > this.bottom - cy)
		{
			this.target_y = this.bottom - cy;
		}
	}

	if (this.zoom != this.target_zoom)
	{
		this.zoom += (this.target_zoom - this.zoom) * 0.20000000;

		if ((this.zoom - this.target_zoom) * (this.zoom - this.target_zoom) <= 0.01000000)
		{
			this.zoom = this.target_zoom;
		}
	}

	if (this.shake_radius > 1.00000000)
	{
		this.shake_radius *= 0.94999999;

		if (this.shake_radius <= 1.00000000)
		{
			this.offset_x = 0;
			this.offset_y = 0;
		}
		else
		{
			this.offset_x = this.cos(1.44700003 * this.shake_count) * this.shake_radius * this.zoom;
			this.offset_y = this.sin(1.86500001 * this.shake_count) * this.shake_radius * this.zoom;
			this.shake_count++;
		}
	}
}

