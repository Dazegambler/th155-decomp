local priority = 10000;
local func_init = function ()
{
	this.action <- ::menu.story_select.weakref();
	local lang = ::config.lang == 1 ? "en_" : "";
	this.name_sprite <- {};
	this.title_sprite <- {};

	foreach( v in this.action.story_list )
	{
		if (v in this.name_sprite)
		{
			continue;
		}

		local t = ::manbow.Texture();

		if (t.Load("data/system/select/story_title/name_" + lang + v + ".png"))
		{
			local s = ::manbow.Sprite();
			s.Initialize(t, 0, 0, t.width, t.height);
			s.filter = 1;
			this.name_sprite[v] <- s;
		}

		local t = ::manbow.Texture();

		if (t.Load("data/system/select/story_title/title_" + lang + v + ".png"))
		{
			local s = ::manbow.Sprite();
			s.Initialize(t, 0, 0, t.width, t.height);
			s.x = 540 - t.width;
			s.y = 88;
			s.filter = 1;
			this.title_sprite[v] <- s;
		}
	}

	this.cursor_inst <- this.action.cursor_story;
	this.target_id <- this.cursor_inst.val;
	this.current_id <- -1;
	this.center <- 320;
	this.x <- 0;
	this.target_x <- 0;
	this.item <- [];

	foreach( i, v in this.action.story_list )
	{
		local t = {};
		t.y <- 0;
		t.target_y <- 0;
		t.obj <- [];

		if (v in this.name_sprite)
		{
			local s = this.name_sprite[v];
			local name = ::manbow.ObjectRenderer();
			name.Set(s);
			name.filter = 1;
			t.obj.push(name);
		}

		if (v in this.title_sprite)
		{
			local s = this.title_sprite[v];
			local title = ::manbow.ObjectRenderer();
			title.Set(s);
			title.x = s.x;
			title.y = s.y;
			title.filter = 1;
			t.obj.push(title);
		}

		if (this.action.difficulty == 4)
		{
			if (::savedata.story[v].ed & 16)
			{
				local s = ::manbow.AnimationController2D();
				s.Init(this.anime_set);
				s.SetMotion(500, 1);
				t.obj.push(s);
			}
			else if (::savedata.story[v].stage_overdrive < 0)
			{
				local s = ::manbow.AnimationController2D();
				s.Init(this.anime_set);
				s.SetMotion(500, 0);
				t.obj.push(s);
			}
		}
		else if (::savedata.story[v].ed)
		{
			local s = ::manbow.AnimationController2D();
			s.Init(this.anime_set);
			s.SetMotion(500, 1);
			t.obj.push(s);
		}
		else if (::savedata.story[v].stage < 0)
		{
			local s = ::manbow.AnimationController2D();
			s.Init(this.anime_set);
			s.SetMotion(500, 0);
			t.obj.push(s);
		}

		this.item.append(t);
	}

	this.SetTarget();

	foreach( i, v in this.item )
	{
		v.y = v.target_y;
	}

	if (this.action.story_list.len() > 1)
	{
		this.cursor_up <- ::manbow.AnimationController2D();
		this.cursor_up.Init(this.anime_set);
		this.cursor_up.SetMotion(410, 0);
		this.cursor_up.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
		this.cursor_down <- ::manbow.AnimationController2D();
		this.cursor_down.Init(this.anime_set);
		this.cursor_down.SetMotion(411, 0);
		this.cursor_down.ConnectRenderSlot(::graphics.slot.ui, priority + 1);
	}

	this.count <- 0;
};
local func_update = function ()
{
	this.count++;

	if (this.cursor_inst.diff)
	{
		this.count = 0;
		this.SetTarget();
	}

	local mat = ::manbow.Matrix();
	local offset = this.action.state == this.action.SelectStory ? 0 : -1000;
	this.x -= (this.x - (this.target_x + offset)) * 0.25000000;

	foreach( i, v in this.item )
	{
		v.y -= (v.y - v.target_y) * 0.25000000;
		mat.SetTranslation(this.x, v.y, 0);
		local c = 1.00000000 - this.abs(v.y - this.center) / 100.00000000;

		if (c < 0.33000001)
		{
			c = 0.33000001;
		}

		foreach( v2 in v.obj )
		{
			v2.SetWorldTransform(mat);
			v2.blue = v2.green = v2.red = c;
		}
	}

	if (this.action.story_list.len() > 1)
	{
		local a = this.abs(this.sin(this.count * 0.10000000) * 4);
		mat.SetTranslation(this.x + 250, this.center + 20 - a, 0);
		this.cursor_up.SetWorldTransform(mat);
		mat.SetTranslation(this.x + 250, this.center + 140 + a, 0);
		this.cursor_down.SetWorldTransform(mat);
	}
};
local func_set_target = function ()
{
	this.target_x = 40;

	foreach( i, v in this.item )
	{
		local diff = i - this.cursor_inst.val;
		v.target_y = diff * 128 + this.center;

		if (this.abs(diff) < 4)
		{
			foreach( v2 in v.obj )
			{
				v2.ConnectRenderSlot(::graphics.slot.ui, priority);
			}
		}
		else
		{
			v.y = v.target_y;

			foreach( v2 in v.obj )
			{
				v2.DisconnectRenderSlot();
			}
		}
	}
};
local v = {};
v.priority <- priority;
v.anime_set <- this.anime_set;
v.Update <- func_update;
v.SetTarget <- func_set_target;
func_init.call(v);
this.data.push(v);
