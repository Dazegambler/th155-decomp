this.item <- null;
this.texture <- ::manbow.Texture();
this.texture.Load("data/system/help/help.png");
this.src <- [
	{},
	{}
];
local static_src = {};
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

static_src.B1 <- this.func_init_sprite(15, 0, 113);
static_src.B2 <- this.func_init_sprite(15, 32, 113);
static_src.B3 <- this.func_init_sprite(15, 64, 113);
static_src.UDLR <- this.func_init_sprite(57, 96, 71);
static_src.UD <- this.func_init_sprite(92, 128, 36);
static_src.LR <- this.func_init_sprite(82, 160, 46);
static_src.KEY <- this.func_init_sprite(81, 192, 47);
static_src.PAD <- this.func_init_sprite(81, 224, 47);
function func_init_text( text )
{
	local t = {};
	local s = ::font.CreateSystemStringSmall(text);
	s.y = ::graphics.height - 32;
	t.width <- s.width;
	t.obj <- s;
	return t;
}

local item_table = ::manbow.LoadCSV("data/system/help/item.csv");

foreach( v in item_table )
{
	foreach( i, v2 in this.src )
	{
		v2[v[0]] <- this.func_init_text(v[i + 1]);
	}
}

foreach( key, obj in static_src )
{
	foreach( v in this.src )
	{
		v[key] <- obj;
	}
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
		local _src = this.src[::config.lang];

		foreach( v in this.item )
		{
			if (v in _src)
			{
				local s = _src[v];
				s.obj.x = w;
				w = w + s.width;
				s.obj.ConnectRenderSlot(::graphics.slot.front, 60000);
				s.obj.alpha = 0;
				this.obj.append(s.obj);
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
		v.alpha += 0,10000000.0;
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
		v.alpha -= 0,10000000.0;
	}

	if (this.obj.len() && this.obj[0].alpha <= 1)
	{
		this.Hide();
		::loop.DeleteTask(this);
	}
}

this.Update <- this.In;
