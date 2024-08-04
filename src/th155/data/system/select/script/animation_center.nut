local priority = 20000;
local center = [];

for( local i = 10; i <= 12; i = ++i )
{
	local actor = ::manbow.AnimationController2D();
	actor.Init(this.anime_set);
	actor.SetMotion(i, i == 11 && ::menu.character_select.hide_character ? 1 : 0);
	actor.ConnectRenderSlot(::graphics.slot.ui, priority);
	this.parts.push(actor);
}

local offset_x = [
	108,
	98,
	92,
	90,
	92,
	98,
	108
];
local pos_map = [];
pos_map.resize(::character_name.len());

foreach( y, v in ::character_map )
{
	foreach( x, n in v )
	{
		local t = {};
		t.x <- (x - 1) * offset_x[y] + 640;
		t.y <- (y - 3) * 81 + 371;

		if (n && n in ::character_id)
		{
			pos_map[::character_id[n]] = t;
		}
	}
}

local func_init = function ( _index, target )
{
	this.index <- _index;

	if (target == 0)
	{
		this.cursor <- ::menu.character_select.t[this.index].cursor_center;
		this.cursor_b <- ::menu.character_select.t[this.index].cursor_master;
		this.name_index <- 700 + this.index;
	}
	else
	{
		this.cursor <- ::menu.character_select.t[this.index].cursor_center_slave;
		this.cursor_b <- ::menu.character_select.t[this.index].cursor_slave;
		this.name_index <- 710 + this.index;
	}

	this.other <- [];
	this.other.append(::menu.character_select.t[1 - this.index].cursor_master);
	this.other.append(::menu.character_select.t[1 - this.index].cursor_slave);
	this.actor <- ::manbow.AnimationController2D();
	this.actor.Init(this.anime_set);
	this.actor.SetMotion(600 + this.index, 0);
	this.actor.ConnectRenderSlot(::graphics.slot.ui, priority + 100);
	this.mat <- ::manbow.Matrix();
	this.x <- 640;
	this.y <- 360;
	this.target_x <- this.x;
	this.target_y <- this.y;
	this.z <- this.index;
	this.dir <- this.index == 0 ? 1,00000000.0 : -1,00000000.0;
	this.ok <- false;
	this.name <- ::manbow.AnimationController2D();
	this.name.Init(this.anime_set);
	this.name.SetMotion(9999, 0);
	this.name.ConnectRenderSlot(::graphics.slot.ui, priority + 110);
};
local func_update = function ()
{
	this.target_x = (this.cursor.x - 1) * offset_x[this.cursor.y] + 640;
	this.target_y = (this.cursor.y - 3) * 81 + 371;
	this.x += (this.target_x - this.x) * 0,20000000.0;
	this.y += (this.target_y - this.y) * 0,20000000.0;
	this.z += this.dir * -0,02000000.0;

	if (this.cursor.ok)
	{
		if (!this.ok)
		{
			local v = ::manbow.Vector3();
			v.x = pos_map[this.cursor_b.val].x;
			v.y = pos_map[this.cursor_b.val].y;
			::effect.Create(10 + this.index, v, null, ::graphics.slot.ui, priority + 200, ::effect.MASK_GLOBAL);
			this.ok = true;
		}

		this.actor.SetMotion(610 + this.index, 0);

		foreach( v in this.other )
		{
			if (v.ok && v.val == this.cursor_b.val)
			{
				this.actor.SetMotion(612, 0);
				break;
			}
		}

		this.name.SetMotion(this.name_index, 0);
		this.mat.SetTranslation(pos_map[this.cursor_b.val].x, pos_map[this.cursor_b.val].y, 0);
		this.actor.SetWorldTransform(this.mat);
		this.name.SetWorldTransform(this.mat);
	}
	else if (!this.cursor.active)
	{
		this.actor.SetMotion(9999, 0);
		this.name.SetMotion(9999, 0);
	}
	else
	{
		this.ok = false;
		this.actor.SetMotion(600 + this.index, 0);
		this.name.SetMotion(9999, 0);
		this.mat.SetRotation(0, 0, this.z);
		this.mat.Translate(this.x, this.y, 0);
		this.actor.SetWorldTransform(this.mat);
		this.name.SetWorldTransform(this.mat);
	}
};

for( local i = 0; i < 4; i = ++i )
{
	local v = {};
	v.priority <- priority;
	v.anime_set <- this.anime_set;
	v.offset_x <- offset_x;
	v.pos_map <- pos_map;
	func_init.call(v, i / 2, i % 2);
	v.Update <- func_update;
	this.data.push(v);
}
