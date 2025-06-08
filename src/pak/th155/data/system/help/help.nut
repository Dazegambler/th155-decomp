this.item <- null;
this.texture <- ::manbow.Texture();
this.texture.Load("data/system/help/help.png");
this.src <- {};
function func_init_sprite( x, y, w )
{
	local t = {};
	local s = this.manbow.Sprite();
	s.Initialize(this.texture, x, y, w, 32);
	s.y = ::graphics.height - 32;
	t.width <- w;
	t.obj <- s;
	return t;
}

this.src.B1 <- this.func_init_sprite(15, 0, 113);
this.src.B2 <- this.func_init_sprite(15, 32, 113);
this.src.B3 <- this.func_init_sprite(15, 64, 113);
this.src.UDLR <- this.func_init_sprite(57, 96, 71);
this.src.UD <- this.func_init_sprite(92, 128, 36);
this.src.LR <- this.func_init_sprite(82, 160, 46);
this.src.KEY <- this.func_init_sprite(81, 192, 47);
this.src.PAD <- this.func_init_sprite(81, 224, 47);
function func_init_text( text )
{
	local t = {};
	local s = ::font.CreateSystemStringSmall(text);
	s.y = ::graphics.height - 32;
	t.width <- s.width;
	t.obj <- s;
	return t;
}

local item_table = ::menu.common.LoadItemText("data/system/help/item.csv");

foreach( key, v in item_table )
{
	this.src[key] <- this.func_init_text(v);
}

this.obj <- [];
function Set( _item )
{
	if (_item == null)
	{
		if (this.item)
		{
			this.Reset();
		}

		this.item = null;
	}
	else if (this.item != _item)
	{
		this.item = _item;

		foreach( v in this.obj )
		{
			v.DisconnectRenderSlot();
		}

		this.obj.resize(0);
		local w = 0;

		foreach( v in this.item )
		{
			if (v in this.src)
			{
				this.src[v].obj.x = w;
				w = w + this.src[v].width;
				this.src[v].obj.ConnectRenderSlot(::graphics.slot.front, 60000);
				this.src[v].obj.alpha = 0;
				this.obj.append(this.src[v].obj);
			}
			else
			{
				w = w + 8;
			}
		}

		w = this.ceil((::graphics.width - w) / 2);

		foreach( v in this.obj )
		{
			v.x += w;
		}

		this.Update <- this.In;
		::loop.AddTask(this);
	}
}

function Reset()
{
	if (this.item)
	{
		this.item = null;
		this.Update <- this.Out;
		::loop.AddTask(this);
	}
}

function Show()
{
	foreach( v in this.obj )
	{
		v.ConnectRenderSlot(::graphics.slot.front, 60000);
	}
}

function Hide()
{
	foreach( v in this.obj )
	{
		v.DisconnectRenderSlot();
	}
}

function In()
{
	foreach( v in this.obj )
	{
		v.alpha += 0.10000000;
	}

	if (this.obj.len() && this.obj[0].alpha >= 1)
	{
		::loop.DeleteTask(this);
	}
}

function Out()
{
	foreach( v in this.obj )
	{
		v.alpha -= 0.10000000;
	}

	if (this.obj.len() && this.obj[0].alpha <= 1)
	{
		this.Hide();
		::loop.DeleteTask(this);
	}
}

this.Update <- this.In;
