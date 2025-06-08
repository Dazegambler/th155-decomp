local _balloon_src = {};
local _balloon_src_auto = {};
_balloon_src_auto.a <- [];
_balloon_src_auto.b <- [];
_balloon_src_auto.c <- [];
_balloon_src_auto.d <- [];
_balloon_src_auto.e <- [];
local data = ::actor.LoadAnimationData("data/event/balloon/balloon.pat");
local p;

foreach( key, v in data )
{
	local t = {};
	t.point <- v.point[0];
	local texture = ::manbow.Texture();
	texture.Load(v.texture_name);
	t.type <- key.slice(0, 1);
	t.height <- key.slice(1, 3).tointeger();
	t.width <- key.slice(4, 5).tointeger();
	t.width = t.width * ::talk.font.size + (t.width - 1) * 16;
	t.height = t.height * (::talk.font.size + 1);
	t.texture <- texture;
	t.cx <- v.offset_x;
	t.cy <- v.offset_y;
	_balloon_src[v.name] <- t;
	_balloon_src_auto[t.type].append(t);
}

local compare = function ( a, b )
{
	if (a.width < b.width)
	{
		return -1;
	}

	if (a.width > b.width)
	{
		return 1;
	}

	if (a.height < b.height)
	{
		return 1;
	}

	if (a.height > b.height)
	{
		return -1;
	}

	return 0;
};

foreach( v in _balloon_src_auto )
{
	v.sort(compare);
}

class this.Balloon 
{
	static balloon_src = _balloon_src;
	static balloon_src_auto = _balloon_src_auto;
	sprite = null;
	text = null;
	subtitle = null;
	direction = 1;
	owner = null;
	x = 0;
	y = 0;
	scale = 0.00000000;
	function Create( _text, name, _owner )
	{
		this.Perse(_text);
		local src;

		if (name in this.balloon_src_auto)
		{
			local src_array = this.balloon_src_auto[name];

			foreach( v in src_array )
			{
				if (v.width < this.text.width)
				{
					continue;
				}

				if (v.width > this.text.width && src)
				{
					break;
				}

				if (v.height < this.text.height)
				{
					continue;
				}

				src = v;
			}
		}
		else if (name in this.balloon_src)
		{
			src = this.balloon_src[name];
		}

		if (src == null)
		{
			src = this.balloon_src[::talk.default_balloon];
		}

		this.owner = _owner.weakref();
		this.direction = this.owner.direction;

		if (this.sprite == null)
		{
			this.sprite = ::manbow.Sprite();
		}

		this.sprite.Initialize(src.texture, 0, 0, src.texture.width, src.texture.height);
		this.sprite.x = -src.cx;
		this.sprite.y = -src.cy;
		this.text.x = src.point.x * this.direction + this.text.width / 2.00000000;
		this.text.y = src.point.y - this.text.height / 2.00000000;
		this.scale = 0;
		this.owner.balloon = this;
		this.SetPosition(this.owner.balloon_x, this.owner.balloon_y);
		this.Show();
	}

	function SetSubtitle( text )
	{
		this.subtitle = ::talk.CreateSubtitle(text);

		foreach( v in this.subtitle )
		{
			v.alpha = 0;
			v.ConnectRenderSlot(::graphics.slot.talk, 30);
		}
	}

	function Perse( _str )
	{
		local len = _str.len();
		local str = "";
		local begin = 0;
		local end = 0;

		for( local i = 0; i < len; i = ++i )
		{
			str = str + _str[i].tostring();
		}

		this.text = ::manbow.String();
		this.text.Initialize(::talk.font);
		this.text.SetVertical(true);
		this.text.SetSpace(0, 16);
		this.text.filter = 1;
		this.text.Set(_str);
		this.text.red = this.text.blue = this.text.green = 0;
	}

	function SetPosition( _x, _y )
	{
		this.x = _x;
		this.y = _y;
		this.UpdatePosition();
	}

	function UpdatePosition()
	{
		local mat = ::manbow.Matrix();
		mat.SetScaling(this.scale, this.scale, 1);
		mat.Translate(this.x, this.y, 0);
		this.text.SetWorldTransform(mat);
		mat.SetScaling(this.direction * this.scale, 1 * this.scale, 1);
		mat.Translate(this.x, this.y, 0);
		this.sprite.SetWorldTransform(mat);
	}

	function Show()
	{
		this.sprite.ConnectRenderSlot(::graphics.slot.talk, 20);
		this.text.ConnectRenderSlot(::graphics.slot.talk, 20);

		if (this.subtitle)
		{
			foreach( v in this.subtitle )
			{
				v.ConnectRenderSlot(::graphics.slot.talk, 30);
			}
		}

		local t = ::newthread(function ( t )
		{
			while (!t.owner.stop)
			{
				this.suspend();
			}

			while (t.scale < 1.00000000)
			{
				t.scale += 0.10000000;
				t.UpdatePosition();

				if (t.subtitle)
				{
					foreach( v in t.subtitle )
					{
						v.alpha = t.scale;
					}
				}

				this.suspend();
			}
		});
		t.call(this);
		::talk.async_task[this.tostring()] <- t;
		this.UpdatePosition();
	}

	function Hide()
	{
		this.sprite.DisconnectRenderSlot();
		this.text.DisconnectRenderSlot();

		if (this.subtitle)
		{
			foreach( v in this.subtitle )
			{
				v.DisconnectRenderSlot();
			}
		}
	}

	function Update()
	{
	}

}

