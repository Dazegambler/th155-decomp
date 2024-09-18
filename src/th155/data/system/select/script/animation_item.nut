local priority = 50000;
local func_init = function ( _cursor, _motion, _dir )
{
	this.actor <- ::manbow.AnimationController2D();
	this.actor.Init(this.anime_set);
	this.actor.SetMotion(_motion, 0);
	this.actor.ConnectRenderSlot(::graphics.slot.ui, priority);
	this.actor.alpha = 0;
	this.mat <- ::manbow.Matrix();
	this.cursor <- _cursor;
	this.count <- 20;
	this.dir <- _dir;
	this.x <- 400 * this.dir;
};
local func_update = function ()
{
	if (this.cursor.active)
	{
		if (this.count > 0)
		{
			this.count--;
			this.x = this.count * this.count * this.dir;
			this.mat.SetTranslation(this.x, -10, 0);
			this.actor.SetWorldTransform(this.mat);
		}

		if (this.actor.alpha < 1)
		{
			this.actor.alpha += 0.05000000;
		}
	}
	else
	{
		if (this.count < 20)
		{
			this.count++;
			this.x = this.count * this.count * this.dir;
			this.mat.SetTranslation(this.x, -10, 0);
			this.actor.SetWorldTransform(this.mat);
		}

		if (this.actor.alpha > 0)
		{
			this.actor.alpha -= 0.05000000;
		}
	}
};

if (this.action == ::menu.character_select)
{
	local item = [
		"master",
		"slave",
		"spell",
		"color_master",
		"color_slave"
	];
	local item_id = [
		60,
		62,
		64,
		66,
		66
	];

	for( local i = 0; i < 2; i = ++i )
	{
		for( local j = 0; j < item.len(); j = ++j )
		{
			local v = {};
			v.anime_set <- this.anime_set;
			func_init.call(v, ::menu.character_select.t[i]["cursor_" + item[j]], item_id[j] + i, i == 0 ? -1 : 1);
			v.Update <- func_update;
			this.data.push(v);
		}
	}

	local v = {};
	v.anime_set <- this.anime_set;
	func_init.call(v, ::menu.character_select.cursor_stage, 68, -1);
	v.Update <- func_update;
	this.data.push(v);
	local v = {};
	v.anime_set <- this.anime_set;
	func_init.call(v, ::menu.character_select.cursor_bgm, 69, 1);
	v.Update <- func_update;
	this.data.push(v);
}
else if (this.action == ::menu.story_select)
{
	local v = {};
	v.anime_set <- this.anime_set;
	func_init.call(v, ::menu.story_select.cursor_story, 70, -1);
	v.Update <- func_update;
	this.data.push(v);
	local v = {};
	v.anime_set <- this.anime_set;
	func_init.call(v, ::menu.story_select.cursor_stage, 71, -1);
	v.Update <- func_update;
	this.data.push(v);
	local v = {};
	v.anime_set <- this.anime_set;
	func_init.call(v, ::menu.story_select.cursor_spell, 64, -1);
	v.Update <- func_update;
	this.data.push(v);
}
