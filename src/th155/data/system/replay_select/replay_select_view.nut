function Initialize( _action )
{
	this.action <- _action.weakref();
	this.cur_stack <- -1;
	this.pager <- this.UIPager();
	this.page <- [];
	this.pager_prev <- this.UIPager();
	this.page_prev <- [];
	local texture = ::manbow.Texture();
	texture.Load("data/system/replay_select/replay_object.png");
	this.title <- ::manbow.Sprite();
	this.title.Initialize(texture, 0, 0, 192, 64);
	this.title.x = ::menu.common.title_x - 192 / 2;
	this.title.y = ::menu.common.title_y;
	this.title.ConnectRenderSlot(::graphics.slot.overlay, 0);
	this.icon <- {};

	foreach( v, i in ::character_id_story )
	{
		local t = ::manbow.Sprite();
		local x = i % 8 * 32;
		local y = i / 8 * 32 + 64;
		t.Initialize(texture, x, y, 32, 32);
		this.icon[v] <- t;
	}

	this.system_icon <- [];

	for( local i = 0; i < 8; i = ++i )
	{
		local t = ::manbow.Sprite();
		local x = i % 8 * 32;
		t.Initialize(texture, x, 160, 32, 32);
		this.system_icon.push(t);
	}

	this.x <- 370;
	this.y <- ::menu.common.item_y;
	this.space <- 32;
	local _y = 620;
	this.filename_back <- ::manbow.Sprite();
	this.filename_back.Initialize(texture, 0, 192, 256, 32);
	this.filename_back.x = this.x;
	this.filename_back.y = _y;
	this.filename_back.filter = 1;
	this.filename_back.sx = 2;
	this.filename_back.sy = 2;
	this.filename_back.ConnectRenderSlot(::graphics.slot.overlay, 0);
	this.page_index <- ::font.CreateSystemString("page 1/1");
	this.page_index.x = 860;
	this.page_index.y = 530;
	this.page_index.ConnectRenderSlot(::graphics.slot.overlay, 0);
	this.filename <- ::font.CreateSystemString("");
	this.filename.x = this.x + 48;
	this.filename.y = _y;
	this.filename.ConnectRenderSlot(::graphics.slot.overlay, 0);
	this.dirname <- ::font.CreateSystemString("");
	this.dirname.x = this.x;
	this.dirname.y = _y - 32;
	this.dirname.ConnectRenderSlot(::graphics.slot.overlay, 0);
	this.diricon <- ::manbow.ObjectRenderer();
	this.diricon.Set(this.system_icon[0]);
	this.diricon.x = this.x - 32;
	this.diricon.y = _y - 32 + 8;
	this.diricon.ConnectRenderSlot(::graphics.slot.overlay, 0);
	function func_move()
	{
		this.mat.SetTranslation(this.x, 0, 0);

		foreach( v in this.item )
		{
			foreach( t in v.obj )
			{
				t.SetWorldTransform(this.mat);
			}
		}
	}

	function func_active()
	{
		foreach( v in this.item )
		{
			foreach( t in v.obj )
			{
				t.ConnectRenderSlot(::graphics.slot.overlay, 0);
			}
		}
	}

	function func_deactive()
	{
		foreach( v in this.item )
		{
			foreach( t in v.obj )
			{
				t.DisconnectRenderSlot();
			}
		}
	}

}

function Terminate()
{
	this.title = null;
	this.icon = null;
	this.system_icon = null;
	this.filename_back = null;
	this.filename = null;
	this.diricon = null;
	this.dirname = null;
	this.pager.Clear();
	this.page = null;
	this.page_index = null;
	this.pager_prev = null;
	this.page_prev = null;
}

function Update()
{
	if (this.action.cursor_page.diff > 0)
	{
		this.pager.Next();
	}
	else if (this.action.cursor_page.diff < 0)
	{
		this.pager.Prev();
	}

	local _y = this.y + this.action.cursor.val * this.space + 16;
	::menu.cursor.SetTarget(this.x - 20, _y, 0,69999999.0);

	if (this.action.current_file)
	{
		this.filename.Set(this.action.current_file.is_directory ? "..." : this.action.current_file.name);

		foreach( i, v in this.page[this.action.cursor_page.val].item )
		{
			foreach( obj in v.obj )
			{
				obj.red = obj.green = obj.blue = i == this.action.cursor.val ? 1,00000000.0 : 0,50000000.0;
			}
		}
	}

	this.dirname.Set(this.action.current_dir_name);
	this.page_index.Set("page " + (this.action.cursor_page.val + 1) + "/" + this.action.cursor_page.item_num);
	this.page_index.x = 900 - this.page_index.width;
}

function CreatePage( filelist )
{
	local dir;

	if (this.cur_stack == this.action.state_stack.len())
	{
		dir = 0;
		this.pager.Clear();
	}
	else
	{
		dir = this.cur_stack > this.action.state_stack.len() ? this.UIBase.RIGHT : this.UIBase.LEFT;
		this.pager.Deactivate(-dir);
		this.pager_prev = this.pager;
		this.page_prev = this.page;
		this.pager <- this.UIPager();
	}

	this.cur_stack = this.action.state_stack.len();
	local cur_page;
	local func_create_page = function ()
	{
		local v = {};
		v.item <- [];
		v.mat <- ::manbow.Matrix();
		v.x <- 0;
		v.visible <- false;
		local ui = this.UIBase();
		ui.target = v.weakref();
		ui.OnActive = this.func_active;
		ui.OnDeactive = this.func_deactive;
		ui.OnMove = this.func_move;
		this.pager.Append(ui);
		return v;
	};
	this.page = [];

	for( local i = 0; i < filelist.len(); i = ++i )
	{
		local page_index = i % this.action.page_size;

		if (page_index == 0)
		{
			local v = func_create_page();
			this.page.push(v);
			cur_page = v;
		}

		local obj = filelist[i];
		local view = {};
		view.page <- cur_page.weakref();
		view.y <- this.y + page_index * this.space;

		if (obj.is_directory)
		{
			this.CreateDir(view, obj);
		}
		else
		{
			this.CreateFile(view, obj);
		}

		obj.view <- view.weakref();
		cur_page.item.push(view);
	}

	if (this.page.len() == 0)
	{
		local t = {};
		t.y <- this.y;
		t.obj <- [];
		local text = ::font.CreateSystemString("ƒtƒ@ƒCƒ‹‚ª‚ ‚è‚\x2584‚\x2563‚ñ");
		text.x = this.x;
		text.y = this.y - 8;
		t.obj.push(text);
		local v = func_create_page();
		v.item.append(t);
		this.page.push(v);
		cur_page = v;
		this.page.push(text);
	}

	this.pager.Activate(this.action.cursor_page.val, dir);
}

function CreateDir( t, obj )
{
	t.obj <- [];
	local text = ::font.CreateSystemString(obj.name);
	text.x = this.x + 36;
	text.y = t.y - 8;
	text.red = text.green = text.blue = 0,50000000.0;
	t.obj.push(text);
	local icon = ::manbow.ObjectRenderer();
	icon.Set(this.system_icon[0]);
	icon.x = this.x;
	icon.y = t.y;
	t.obj.push(icon);

	foreach( obj in t.obj )
	{
		obj.red = obj.green = obj.blue = 0,50000000.0;
	}

	return t;
}

function CreateFile( t, obj )
{
	t.obj <- [];
	local text = ::font.CreateSystemString("“Çž’†...");
	text.x = this.x + 36;
	text.y = t.y - 8;
	text.red = text.green = text.blue = 0,50000000.0;
	t.obj.push(text);

	if (obj.loading > 0)
	{
		text.ConnectRenderSlot(::graphics.slot.overlay, 0);
	}
	else
	{
		this.SetFileHeader(t, obj.header);
	}

	return t;
}

function SetFileHeader( target, header )
{
	if (header == null)
	{
		target.obj[0].Set("Žg—p‚\x253c‚«‚\x2584‚\x2563‚ñ");

		if (target.page.visible)
		{
			foreach( v in target.obj )
			{
				v.SetWorldTransform(target.page.mat);
				v.ConnectRenderSlot(::graphics.slot.overlay, 0);
			}
		}

		return;
	}

	local str = "" + header.year;
	str = str + ((header.month < 10 ? "/0" : "/") + header.month);
	str = str + ((header.day < 10 ? "/0" : "/") + header.day);
	str = str + ((header.hour < 10 ? "  0" : "  ") + header.hour);
	str = str + ((header.min < 10 ? ":0" : ":") + header.min);
	local _icon;

	switch(header.game_mode)
	{
	case 10:
		target.obj[0].Set(str);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.system_icon[3]);
		_icon.x = this.x;
		_icon.y = target.y;
		target.obj.push(_icon);
		local _x = target.obj[0].x + 192 + 120;
		local _y = target.y;
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.scenario_name]);
		_icon.x = _x;
		_icon.y = _y;
		target.obj.push(_icon);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.slave_name]);
		_icon.x = _x + 32;
		_icon.y = _y;
		target.obj.push(_icon);
		break;

	case 0:
	case 1:
		str = str + "            vs          ";
		target.obj[0].Set(str);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.system_icon[1]);
		_icon.x = this.x;
		_icon.y = target.y;
		target.obj.push(_icon);
		local _x = target.obj[0].x + 192 + 120;
		local _y = target.y;
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.slave_name[0]]);
		_icon.x = _x;
		_icon.y = _y;
		target.obj.push(_icon);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.master_name[0]]);
		_icon.x = _x + 32;
		_icon.y = _y;
		target.obj.push(_icon);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.master_name[1]]);
		_icon.x = _x + 96 + 40;
		_icon.y = _y;
		_icon.sx = -1;
		target.obj.push(_icon);
		_icon = ::manbow.ObjectRenderer();
		_icon.Set(this.icon[header.slave_name[1]]);
		_icon.x = _x + 128 + 40;
		_icon.y = _y;
		_icon.sx = -1;
		target.obj.push(_icon);
		break;
	}

	if (target.page.visible)
	{
		foreach( v in target.obj )
		{
			v.SetWorldTransform(target.page.mat);
			v.ConnectRenderSlot(::graphics.slot.overlay, 0);
		}
	}

	foreach( obj in target.obj )
	{
		obj.red = obj.green = obj.blue = 0,50000000.0;
	}
}

