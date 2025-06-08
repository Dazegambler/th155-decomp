local priority = 30000;
local mat_init = ::manbow.Matrix();
mat_init.SetScaling(0, 0, 0);
local func_init = function ( i )
{
	this.index <- i;
	this.frame_parts <- [];
	this.stage <- ::manbow.AnimationController2D();
	this.stage.Init(this.anime_set);
	this.stage.SetMotion(5000 + i, i != 99 ? ::menu.character_select.stage_index[i] : 0);
	this.frame_parts.push(this.stage);
	this.target_rot <- 0;
	this.current_rot <- -3.14150000 / 2;
	this.active <- false;

	foreach( v in this.frame_parts )
	{
		v.SetWorldTransform(mat_init);
		v.Update();
	}
};
local func_update = function ()
{
	if (!this.visible)
	{
		return;
	}

	local mat = ::manbow.Matrix();
	this.current_rot += (this.target_rot - this.current_rot) * 0.25000000;
	local _x = this.cos(this.current_rot) * 160 - 150;
	local _y = this.sin(this.current_rot) * 160 + 360;
	mat.SetScaling(this.root.scale, this.root.scale, 1);
	mat.Rotate(0, 0, this.current_rot);
	mat.Translate(_x, _y, 0);
	this.stage.SetMotion(5000 + this.index, this.index != 99 ? ::menu.character_select.stage_index[this.index] : 0);

	foreach( v in this.frame_parts )
	{
		if (this.active)
		{
			if (v.red < 1)
			{
				v.red += 0.10000000;
			}
		}
		else if (v.red > 0.50000000)
		{
			v.red -= 0.10000000;
		}

		v.green = v.blue = v.red;
		v.SetWorldTransform(mat);
		v.Update();
	}
};
local func_set_target = function ( diff )
{
	this.active = diff == 0;

	if (this.abs(diff) > 4)
	{
		this.visible = false;

		foreach( v in this.frame_parts )
		{
			v.DisconnectRenderSlot();
		}

		return;
	}

	this.target_rot = 3.14159203 * (0.00000000 + -diff * 0.13000000);
	this.visible = true;

	foreach( v in this.frame_parts )
	{
		v.ConnectRenderSlot(::graphics.slot.ui, priority);
	}
};
local func_update_position = function ()
{
	this.count++;

	if (this.cursor_inst.active || this.cursor_inst.ok)
	{
		if (this.cursor_inst.diff)
		{
			this.count = 0;
		}

		if (!this.visible)
		{
			this.cursor_up.ConnectRenderSlot(this.graphics.slot.ui, priority + 1);
			this.cursor_down.ConnectRenderSlot(this.graphics.slot.ui, priority + 1);
			this.current = -1;
			this.visible = true;
		}

		if (this.scale > 1)
		{
			this.scale -= 0.20000000;

			if (this.scale < 1)
			{
				this.scale = 1;
			}
		}
		else if (this.scale < 1)
		{
			this.scale += 0.20000000;

			if (this.scale > 1)
			{
				this.scale = 1;
			}
		}

		if (this.fade_rect.alpha < 0.75000000)
		{
			this.fade_rect.alpha += 0.05000000;
		}
	}
	else
	{
		if (this.fade_rect.alpha > 0)
		{
			this.fade_rect.alpha -= 0.05000000;
		}

		this.scale -= 0.20000000;

		if (this.scale < 0)
		{
			this.scale = 0;

			if (this.visible)
			{
				this.cursor_up.DisconnectRenderSlot();
				this.cursor_down.DisconnectRenderSlot();

				foreach( v in this.obj )
				{
					foreach( v2 in v.frame_parts )
					{
						v2.DisconnectRenderSlot();
					}
				}

				this.visible = false;
			}

			return;
		}
	}

	if (this.current != this.cursor_inst.val)
	{
		this.current = this.cursor_inst.val;

		foreach( i, v in this.obj )
		{
			local diff = i - this.cursor_inst.val;

			if (diff < -this.size / 2)
			{
				diff = diff + this.size;
			}
			else if (diff > this.size / 2)
			{
				diff = diff - this.size;
			}

			v.SetTarget(diff);
		}
	}

	if (this.cursor_inst.active)
	{
		if (this.cursor_up.alpha < 1.00000000)
		{
			this.cursor_up.alpha += 0.10000000;
		}

		this.cursor_down.alpha = this.cursor_up.alpha;
	}
	else if (this.cursor_up.alpha > 0.00000000)
	{
		this.cursor_up.alpha -= 0.10000000;
		this.cursor_down.alpha = this.cursor_up.alpha;
	}
	else
	{
		return;
	}

	local mat = ::manbow.Matrix();
	local a = this.abs(this.sin(this.count * 0.10000000) * 6) + 100;
	mat.SetTranslation(500 * this.scale - 40, 360 - a, 0);
	this.cursor_up.SetWorldTransform(mat);
	mat.SetTranslation(500 * this.scale - 40, 360 + a, 0);
	this.cursor_down.SetWorldTransform(mat);

	foreach( v in this.obj )
	{
		v.Update();
	}
};
local root = {};
local obj = [];
local fade_rect = ::manbow.Rectangle();
fade_rect.SetPosition(-1, -1, this.graphics.width + 1, this.graphics.height + 1);
fade_rect.SetColor(1, 0, 0, 0);
fade_rect.visible = true;
fade_rect.ConnectRenderSlot(this.graphics.slot.ui, priority - 100);
local cursor_up = ::manbow.AnimationController2D();
cursor_up.Init(this.anime_set);
cursor_up.SetMotion(400, 0);
local cursor_down = ::manbow.AnimationController2D();
cursor_down.Init(this.anime_set);
cursor_down.SetMotion(401, 0);
root.cursor_inst <- ::menu.character_select.cursor_stage;
root.cursor <- ::menu.character_select.cursor_stage.val;
root.size <- ::menu.character_select.stage.len();
root.obj <- obj;
root.scale <- 0;
root.current <- -1;
root.count <- 0;
root.cursor_up <- cursor_up;
root.cursor_down <- cursor_down;
root.fade_rect <- fade_rect;
root.visible <- false;
root.Update <- func_update_position;
this.data.push(root);

for( local i = 0; i < ::menu.character_select.stage.len(); i = ++i )
{
	local v = {};
	v.root <- root.weakref();
	v.priority <- priority;
	v.anime_set <- this.anime_set;
	v.visible <- false;
	v.Update <- func_update;
	v.SetTarget <- func_set_target;
	func_init.call(v, ::menu.character_select.stage[i]);
	obj.push(v);
}
