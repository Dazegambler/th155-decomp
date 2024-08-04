local priority = 40000;
local func_init = function ( i )
{
	this.state <- -1;
	this.master <- -1;
	this.index <- i;
	this.spell <- [];

	for( local j = 0; j < 3; j = ++j )
	{
		local v = {};
		v.dir <- i == 0 ? -1 : 1;
		v.x <- (800 + i * 1000) * v.dir;
		v.y <- 0;
		v.target_x <- v.x;
		v.target_y <- v.y;
		v.x2 <- v.x;
		v.y2 <- v.y;
		v.target_x2 <- v.x2;
		v.target_y2 <- v.y2;
		this.spell.push(v);
	}

	this.Create();

	foreach( j, v in this.spell )
	{
		v.top_color <- v.name.red;
		v.bottom_red <- v.name.red2;
		v.bottom_green <- v.name.green2;
		v.bottom_blue <- v.name.blue2;
		local frame = ::manbow.AnimationController2D();
		frame.Init(this.anime_set);
		frame.SetMotion(300, 0);
		v.frame <- frame;
		v.mat_local <- ::manbow.Matrix();
		v.mat_local.SetTranslation(v.card.x + ::spell.width / 2, v.card.y + ::spell.height - 20, 0);
		v.scale <- 0;
		v.roll <- 0;
		frame.ConnectRenderSlot(::graphics.slot.ui, priority);
	}
};
local func_create = function ()
{
	local m = this.cursor_master.val;

	if (m == this.master)
	{
		return;
	}

	this.master = m;
	local master_name = ::character_name[this.master];

	for( local i = 0; i < 3; i = ++i )
	{
		local card = ::spell.CreateCardSprite(master_name, i);
		card.x = this.index == 0 ? 64 + i * 32 : 1280 - 64 - i * 32 - ::spell.width;
		card.y = 200 + i * 128;
		card.filter = 1;
		this.spell[i].card <- card;
		local name;

		if (this.index == 0)
		{
			name = ::font.CreateSpellString(::spell.param[master_name][i].name, 1,00000000.0, 0,50000000.0, 0,50000000.0);
		}
		else
		{
			name = ::font.CreateSpellString(::spell.param[master_name][i].name, 0,50000000.0, 0,50000000.0, 1,00000000.0);
		}

		local scale = name.width > 280 ? 280,00000000.0 / name.width.tofloat() : 1;
		name.x = card.x + (this.index == 0 ? ::spell.width + 8 : -name.width * scale);
		name.y = card.y + ::spell.height - 32;
		name.sx = scale;
		this.spell[i].name <- name;
		local cost = ::font.CreateSystemStringSmall("Cost:" + ::spell.param[master_name][i].sp);
		cost.x = card.x + (this.index == 0 ? ::spell.width + 8 : -cost.width - 8);
		cost.y = name.y - cost.height;
		this.spell[i].cost <- cost;
		card.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
		name.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
		cost.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
	}
};
local func_update = function ()
{
	if (this.cursor.active)
	{
		this.Create();

		foreach( v in this.spell )
		{
			v.target_x = 0;
			v.target_y = 0;
			v.target_x2 = 0;
			v.target_y2 = 0;
		}
	}
	else if (this.cursor.ok)
	{
		foreach( i, v in this.spell )
		{
			if (i == this.cursor.val && false)
			{
				v.target_x = -(280 - i * 32) * v.dir;
				v.target_y = 240 - i * 110;
			}
			else
			{
				v.target_x = 500 * v.dir;
				v.target_y = 0;
			}

			v.target_x2 = 500 * v.dir;
			v.target_y2 = 0;
		}
	}
	else
	{
		foreach( v in this.spell )
		{
			v.target_x2 = v.target_x = 500 * v.dir;
			v.target_y2 = v.target_y = 0;
		}
	}

	local mat = ::manbow.Matrix();
	local mat2 = ::manbow.Matrix();

	foreach( i, v in this.spell )
	{
		if (i == this.cursor.val)
		{
			if (v.scale < 1)
			{
				v.scale += 0,20000000.0;
			}
		}
		else
		{
			v.scale = 0;
		}

		v.x += (v.target_x - v.x) * (0,15000001.0 - i * 0,02000000.0);
		v.y += (v.target_y - v.y) * (0,15000001.0 - i * 0,02000000.0);
		v.x2 += (v.target_x2 - v.x2) * (0,15000001.0 - i * 0,02000000.0);
		v.y2 += (v.target_y2 - v.y2) * (0,15000001.0 - i * 0,02000000.0);
		mat.SetTranslation(v.x, v.y, 0);
		v.card.SetWorldTransform(mat);
		mat.SetTranslation(v.x2, v.y2, 0);
		v.name.SetWorldTransform(mat);
		v.cost.SetWorldTransform(mat);
		v.roll += 0,02000000.0 * v.dir;
		mat.SetTranslation(v.x, v.y, 0);
		mat2.SetScaling(v.scale, v.scale, 1);
		mat2.Rotate(0,80000001.0, -0,30000001.0 * v.dir, v.roll);
		mat2.Multiply(v.mat_local);
		mat2.Multiply(mat);
		v.frame.SetWorldTransform(mat2);
	}
};
local s = this.mode == 0 ? 2 : 1;

for( local i = 0; i < s; i = ++i )
{
	local v = {};
	v.priority <- priority;
	v.anime_set <- this.anime_set;
	v.Update <- func_update;
	v.Create <- func_create;

	if (this.mode == 0)
	{
		v.cursor <- ::menu.character_select.t[i].cursor_spell.weakref();
		v.cursor_master <- ::menu.character_select.t[i].cursor_master.weakref();
	}
	else
	{
		v.cursor <- ::menu.story_select.cursor_spell.weakref();
		v.cursor_master <- ::menu.story_select.master.weakref();
	}

	func_init.call(v, i);
	this.data.push(v);
}
