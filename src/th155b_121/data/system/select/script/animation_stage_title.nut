local priority = 70000;
local func_init = function ()
{
	this.action <- ::menu.story_select.weakref();
	this.cursor_target <- this.action.cursor_story;
	this.cursor_inst <- this.action.cursor_stage;
	this.target_id <- this.cursor_inst.val;
	this.current_id <- -1;
	this.item <- null;
	this.base_x <- 120;
	this.base_y <- 400;
	this.space <- 80;
	this.stage_num <- [];

	for( local i = 0; i < 6; i = ++i )
	{
		local s = ::font.CreateSystemString("STAGE" + (i + 1));
		s.x = 200;
		s.y = 0;
		this.stage_num.append(s);
	}
};
local func_update = function ()
{
	if (this.cursor_target.ok && this.current_id != this.cursor_target.val)
	{
		this.current_id = this.cursor_target.val;
		this.Create();
	}

	if (this.item == null)
	{
		return;
	}

	this.SetTarget();
	local mat = ::manbow.Matrix();

	foreach( v in this.item )
	{
		v.x -= (v.x - v.target_x) * 0.25000000;
		v.y -= (v.y - v.target_y) * 0.25000000;
		mat.SetTranslation(v.x, v.y, 0);

		foreach( w in v.obj )
		{
			w.SetWorldTransform(mat);
		}
	}
};
local func_set_target = function ()
{
	local x = this.action.state == this.action.SelectStage ? this.base_x : -1000;

	foreach( i, v in this.item )
	{
		local color = i == this.cursor_inst.val ? 1.00000000 : 0.50000000;
		v.target_x = x;

		foreach( w in v.obj )
		{
			w.blue = w.green = w.red = color;
		}
	}
};
local func_create_resource = function ()
{
	local t = ::manbow.Texture();
	local name = ::character_name[this.action.master.val];
	this.item = null;
	local lang = ::config.lang == 1 ? "en_" : "";

	if (!t.Load("data/system/select/story_title/stage_" + lang + name + ".png"))
	{
		return;
	}

	this.item = [];

	for( local i = 0; i < this.cursor_inst.item_num; i = ++i )
	{
		local v = {};
		v.x <- -1000;
		v.y <- (i - this.cursor_inst.item_num / 2.00000000) * this.space + this.base_y;
		v.target_x <- v.x;
		v.target_y <- v.y;
		local s = ::manbow.Sprite();
		s.Initialize(t, 0, i * 64, t.width, 64);
		s.y = 24;
		s.filter = 1;
		v.obj <- [];
		v.obj.append(s);
		v.obj.append(this.stage_num[i]);

		foreach( w in v.obj )
		{
			w.ConnectRenderSlot(::graphics.slot.ui, priority);
		}

		this.item.append(v);
	}

	this.SetTarget();
};
local v = {};
v.priority <- priority;
v.Update <- func_update;
v.SetTarget <- func_set_target;
v.Create <- func_create_resource;
func_init.call(v);
this.data.push(v);
