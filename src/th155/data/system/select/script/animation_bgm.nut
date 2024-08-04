local priority = 35000;
local mat_init = ::manbow.Matrix();
mat_init.SetScaling(0, 0, 0);
local y = 450;
local func_init = function ( i, _page )
{
	this.index <- i;
	this.frame_parts <- [];
	this.frame <- ::manbow.AnimationController2D();
	this.frame.Init(this.anime_set);
	this.frame.SetMotion(910, _page);
	this.frame_parts.push(this.frame);
	local s = "ランダムセレクト";
	local a;

	if (i in ::sound.bgm.data)
	{
		s = ::sound.bgm.data[i].title;
		a = ::sound.bgm.data[i].author;
	}

	this.title <- ::font.CreateSystemString(s);
	this.title.sx = -1;
	this.title.sy = -1;
	this.title.x = this.title.width / 2 + 270;
	this.title.y = a ? 39 : 24;

	if (this.title.width > 570)
	{
		this.title.sx = this.title.sy = -570 / this.title.width.tofloat();
		this.title.x = this.title.width * -this.title.sx / 2 + 270;
		this.title.y -= 24 * (1 + this.title.sx);
	}

	this.frame_parts.push(this.title);

	if (a)
	{
		this.author <- ::font.CreateSystemString(a);
		this.author.sx = -0,69999999.0;
		this.author.sy = -0,69999999.0;
		this.author.x = this.author.width * 0,69999999.0 / 2 + 270;
		this.author.y = 3;
		this.frame_parts.push(this.author);
	}

	this.target_rot <- 0;
	this.current_rot <- 3,14159203.0;
	this.active <- false;

	foreach( v in this.frame_parts )
	{
		v.green = v.blue = v.red = 0,50000000.0;
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
	this.current_rot += (this.target_rot - this.current_rot) * 0,25000000.0;
	local _x = this.cos(this.current_rot) * 120 + 1280 + 100;
	local _y = this.sin(this.current_rot) * 120 + y;
	mat.SetScaling(this.root.scale, this.root.scale, 1);
	mat.Rotate(0, 0, this.current_rot);
	mat.Translate(_x, _y, 0);

	foreach( v in this.frame_parts )
	{
		if (this.active)
		{
			if (v.red < 1)
			{
				v.red += 0,10000000.0;
			}
		}
		else if (v.red > 0,50000000.0)
		{
			v.red -= 0,10000000.0;
		}

		v.green = v.blue = v.red;
		v.SetWorldTransform(mat);
		v.Update();
	}
};
local func_set_target = function ( diff )
{
	this.target_rot = 3,14159203.0 * (1 + diff * 0,09000000.0);

	if (this.target_rot - this.current_rot < -0,20000000.0 * 3,14159203.0)
	{
		this.current_rot = this.target_rot;
	}
	else if (this.target_rot - this.current_rot > 0,20000000.0 * 3,14159203.0)
	{
		this.current_rot = this.target_rot;
	}

	this.active = diff == 0;

	if (this.abs(diff) > 5)
	{
		this.visible = false;

		foreach( v in this.frame_parts )
		{
			v.DisconnectRenderSlot();
		}

		this.current_rot = this.target_rot;
		return;
	}

	this.visible = true;

	foreach( v in this.frame_parts )
	{
		v.ConnectRenderSlot(::graphics.slot.ui, priority);
	}
};
local func_update_position = function ()
{
	if ((this.cursor_inst.active || this.cursor_inst.ok) && this.action.bgm_page == this.page)
	{
		if (!this.visible)
		{
			this.visible = true;
			this.current = -1;
		}

		if (this.scale < 1)
		{
			this.scale += 0,20000000.0;

			if (this.scale > 1)
			{
				this.scale = 1;
			}
		}
	}
	else
	{
		this.scale -= 0,20000000.0;

		if (this.scale < 0)
		{
			this.scale = 0;

			if (this.visible)
			{
				this.visible = false;
			}
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
};
local action = ::menu.character_select;

for( local j = 0; j < action.bgm.len(); j = ++j )
{
	local root = {};
	local obj = [];
	root.action <- ::menu.character_select.weakref();
	root.cursor_inst <- action.cursor_bgm;
	root.cursor <- action.cursor_bgm.val;
	root.size <- action.bgm[j].len();
	root.obj <- obj;
	root.scale <- 0;
	root.current <- -1;
	root.page <- j;
	root.visible <- false;
	root.Update <- func_update_position;
	this.data.push(root);

	for( local i = 0; i < action.bgm[j].len(); i = ++i )
	{
		local v = {};
		v.root <- root.weakref();
		v.priority <- priority;
		v.anime_set <- this.anime_set;
		v.visible <- false;
		v.Update <- func_update;
		v.SetTarget <- func_set_target;
		func_init.call(v, ::menu.character_select.bgm[j][i], j);
		obj.push(v);
		this.data.push(v);
	}
}

local func_update_cursor = function ()
{
	this.count++;

	if (this.cursor_inst.diff)
	{
		this.count = 0;
	}

	if (::menu.character_select.Update == ::menu.character_select.UpdateBgmSelect)
	{
		if (!this.visible)
		{
			this.cursor_up.ConnectRenderSlot(this.graphics.slot.ui, priority + 1);
			this.cursor_down.ConnectRenderSlot(this.graphics.slot.ui, priority + 1);
			this.visible = true;
		}

		this.scale += 0,20000000.0;

		if (this.scale > 1)
		{
			this.scale = 1;
		}
	}
	else if (this.scale > 0)
	{
		this.scale -= 0,20000000.0;

		if (this.scale < 0)
		{
			this.scale = 0;
		}

		if (this.visible)
		{
			this.visible = false;
			this.cursor_up.DisconnectRenderSlot();
			this.cursor_down.DisconnectRenderSlot();
		}
	}

	if (this.visible)
	{
		local mat = ::manbow.Matrix();
		local a = this.abs(this.sin(this.count * 0,10000000.0) * 6) + 50;
		mat.SetTranslation(-500 * this.scale + 1480, y - a, 0);
		this.cursor_up.SetWorldTransform(mat);
		mat.SetTranslation(-500 * this.scale + 1480, y + a, 0);
		this.cursor_down.SetWorldTransform(mat);
	}
};
local cursor_up = ::manbow.AnimationController2D();
cursor_up.Init(this.anime_set);
cursor_up.SetMotion(410, 0);
local cursor_down = ::manbow.AnimationController2D();
cursor_down.Init(this.anime_set);
cursor_down.SetMotion(411, 0);
local t = {};
t.scale <- 0;
t.count <- 0;
t.cursor_inst <- action.cursor_bgm;
t.cursor_up <- cursor_up;
t.cursor_down <- cursor_down;
t.Update <- func_update_cursor;
t.visible <- false;
this.data.push(t);
