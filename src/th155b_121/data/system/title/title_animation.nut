this.anime_set <- ::actor.LoadAnimationData("data/system/title/title.pat");
function Initialize()
{
	this.action <- ::menu.title.weakref();
	local actor;
	this.item <- [];
	this.update_message <- [];
	this.item.push(::graphics.CreateSprite("data/system/title/title_back.png"));
	local temp = this.item[0];
	this.item.push(::graphics.CreateSprite("data/system/title/title_logo_2.png"));
	actor = ::graphics.CreateSprite("data/system/title/title_object_1.png");
	actor.filter = 1;
	actor.blend = 2;
	actor.ox = ::graphics.width / 2;
	actor.oy = ::graphics.height / 2;
	this.item.push(actor);
	local version = ::font.CreateSystemString(::GetVersionString());
	local s = 0,66600001.0;
	version.sx = version.sy = s;
	version.x = ::graphics.width - 16 - version.width * s;
	version.y = ::graphics.height - 48 * s - version.height * s;
	this.item.push(version);
	this.new_version <- false;
	local texture_item = ::manbow.Texture();
	texture_item.Load("data/system/title/title_text.png");
	local res = this.anime_set.copyright;
	actor = ::manbow.Sprite();
	actor.Initialize(texture_item, res.left, res.top, res.width, res.height);
	actor.x = ::graphics.width - res.width - 16;
	actor.y = ::graphics.height - res.height - 8;
	this.item.push(actor);
	function TaskUpdateIn()
	{
		if (this.count > 0)
		{
			this.count--;
			this.obj.x = this.ox - this.count * this.count;
			this.obj.alpha = 1,00000000.0 - this.count / 10,00000000.0;
		}
		else
		{
			this.obj.alpha = 1;
			this.obj.x = this.ox;
			::loop.DeleteTask(this);
		}
	}

	function TaskUpdateOut()
	{
		if (this.count < 10)
		{
			this.count++;
			this.obj.x = this.ox - this.count * this.count;
			this.obj.alpha = 1,00000000.0 - this.count / 10,00000000.0;
		}
		else
		{
			this.obj.alpha = 0;
			::loop.DeleteTask(this);
		}
	}

	this.main <- [];

	foreach( v in this.action.item )
	{
		local t = {};
		local res = this.anime_set[v];
		local sprite = ::manbow.Sprite();
		sprite.Initialize(texture_item, res.left, res.top, res.width, res.height);
		sprite.ox = res.width / 2;
		sprite.oy = res.height / 2;
		t.obj <- sprite;
		this.main.append(t);
		this.item.push(sprite);
	}

	foreach( i, v in this.main )
	{
		v.ox <- i * 2 + 96;
		v.oy <- i * 44 + 660 - this.main.len() * 44;
		v.sy <- i * 64;
		v.obj.x = -1000;
		v.obj.y = v.oy;
		v.alpha <- 0;
		v.count <- 10 + i * 3;
		v.Update <- this.TaskUpdateIn;
		::loop.AddTask(v);
	}

	this.difficulty <- [];
	local _item = [
		"easy",
		"normal",
		"hard",
		"lunatic",
		"overdrive"
	];

	for( local i = 0; i < _item.len(); i = ++i )
	{
		local v = {};
		local res = this.anime_set[_item[i]];
		v.ox <- 96 + i * 2;
		v.oy <- 400 + i * 44;
		v.sy <- 256 - i * 64;
		local sprite = ::manbow.Sprite();
		sprite.Initialize(texture_item, res.left, res.top, res.width, res.height);
		sprite.x = -1000;
		sprite.y = v.oy;
		sprite.ox = res.width / 2;
		sprite.oy = res.height / 2;
		sprite.alpha = 0;
		v.obj <- sprite;
		v.count <- 10 + i * 3;
		v.Update <- this.TaskUpdateIn;
		this.difficulty.push(v);
		this.item.push(sprite);
	}

	this.scale_task <- {};
	this.scale_task.v <- this.weakref();
	this.scale_task.Update <- function ()
	{
		if (this.v == null)
		{
			::loop.DeleteTask(this);
			return;
		}

		this.v.sx -= 0,04000000.0;

		if (this.v.sx <= 1)
		{
			this.v.sx = 1;
			::loop.DeleteTask(this);
		}
	};
	this.sx <- 1,00000000.0;
	this.count <- 0;
	this.state <- 0;

	foreach( v in this.item )
	{
		v.ConnectRenderSlot(::graphics.slot.ui, 0);
	}

	temp.ConnectRenderSlot(::graphics.slot.ui, -1);

	if (::savedata.IsTitleChange())
	{
		local v = ::manbow.Vector3();
		v.x = 480;
		v.y = 360;
		v.z = 0;
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
		v.x = 640;
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
		::effect.Create(21, v, null, ::graphics.slot.ui, -1, ::effect.MASK_GLOBAL);
	}

	foreach( v in this.main )
	{
		v.obj.ConnectRenderSlot(::graphics.slot.ui, 10);
	}

	foreach( v in this.difficulty )
	{
		v.obj.ConnectRenderSlot(::graphics.slot.ui, 10);
	}
}

function Terminate()
{
	this.difficulty = null;
	this.main = null;
	this.item = null;
	this.update_message = null;
}

function Suspend()
{
}

function Resume()
{
	if (this.update_message.len())
	{
		this.update_message[0].Set(::menu.common.GetMessageText("new_version"));
		this.update_message[0].x = ::graphics.width - this.update_message[0].width - 16;
		this.update_message[1].Set(::menu.common.GetMessageText("need_to_update"));
		this.update_message[1].x = ::graphics.width - this.update_message[1].width - 16;
	}
}

function Update()
{
	if (this.action.cursor.diff || this.action.cursor_difficulty.diff)
	{
		this.sx = 1,14999998.0;
		::loop.AddTask(this.scale_task);
	}

	if (this.action.new_version && !this.new_version)
	{
		this.new_version = true;
		local t = ::font.CreateSystemStringSmall(::menu.common.GetMessageText("new_version"));
		t.x = ::graphics.width - t.width - 16;
		t.y = ::graphics.height - t.height - 32 - 20 * 2;
		t.blue = 0,50000000.0;
		t.ConnectRenderSlot(::graphics.slot.ui, 10);
		this.update_message.push(t);
		t = ::font.CreateSystemStringSmall(::menu.common.GetMessageText("need_to_update"));
		t.x = ::graphics.width - t.width - 16;
		t.y = ::graphics.height - t.height - 32 - 20;
		t.blue = 0,50000000.0;
		t.ConnectRenderSlot(::graphics.slot.ui, 10);
		this.update_message.push(t);
	}

	switch(this.state)
	{
	case 0:
		if (this.action.cursor_difficulty.active)
		{
			foreach( v in this.main )
			{
				v.Update <- this.TaskUpdateOut;
				::loop.AddTask(v);
			}

			foreach( i, v in this.difficulty )
			{
				if (i >= this.action.cursor_difficulty.item_num)
				{
					break;
				}

				v.count <- 10 + i * 3;
				v.Update <- this.TaskUpdateIn;
				::loop.AddTask(v);
			}

			this.state = 1;
		}
		else
		{
			local c = this.action.cursor.val;
			::menu.cursor.SetTarget(this.main[c].ox - 24, this.main[c].oy + 28, 1,00000000.0);

			foreach( i, v in this.main )
			{
				if (this.action.cursor.val != i)
				{
					v.obj.red = v.obj.green = v.obj.blue = 0,50000000.0;
					v.obj.sx = v.obj.sy = 1;
				}
				else
				{
					v.obj.red = v.obj.green = v.obj.blue = 1,00000000.0;
					v.obj.sx = v.obj.sy = this.sx;
				}
			}
		}

		break;

	case 1:
		if (this.action.cursor.active)
		{
			foreach( i, v in this.main )
			{
				v.count <- 10 + i * 3;
				v.Update <- this.TaskUpdateIn;
				::loop.AddTask(v);
			}

			foreach( i, v in this.difficulty )
			{
				if (i >= this.action.cursor_difficulty.item_num)
				{
					break;
				}

				v.Update <- this.TaskUpdateOut;
				::loop.AddTask(v);
			}

			this.state = 0;
		}
		else
		{
			local c = this.action.cursor_difficulty.val;
			::menu.cursor.SetTarget(this.difficulty[c].ox - 24, this.difficulty[c].oy + 28, 1,00000000.0);

			foreach( i, v in this.difficulty )
			{
				if (i >= this.action.cursor_difficulty.item_num)
				{
					break;
				}

				if (this.action.cursor_difficulty.val != i)
				{
					v.obj.red = v.obj.green = v.obj.blue = 0,50000000.0;
					v.obj.sx = v.obj.sy = 1;
				}
				else
				{
					v.obj.red = v.obj.green = v.obj.blue = 1,00000000.0;
					v.obj.sx = v.obj.sy = this.sx;
				}
			}
		}

		break;
	}

	local t = this.item[2];
	t.sy = t.sx = 1 + (1 - this.cos(this.count * 0,01000000.0)) * 0,01500000.0;
	this.count++;
}

