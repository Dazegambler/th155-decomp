class this.UIBase 
{
	action = null;
	target = null;
	state = -2;
	ox = 0;
	count = 20;
	task = null;
	OnActive = null;
	OnDeactive = null;
	OnMove = null;
	static LEFT = -1;
	static RIGHT = 1;
	constructor()
	{
		this.task = ::loop.GeneratorTask();
	}

	function Terminate()
	{
		this.task.Reset();
	}

	function Update()
	{
		if (this.action)
		{
			if (this.state == this.action.state)
			{
				return;
			}

			this.SetState(this.action.state);
		}
	}

	function SetState( s )
	{
		if (this.state == -2)
		{
			if (this.OnMove)
			{
				this.OnMove.call(this.target);
			}
		}

		this.state = s;

		switch(this.state)
		{
		case 0:
			this.task.Set(function ()
			{
				// Function is a generator.
				local env = this;
				this.target.visible = true;

				if (this.OnActive)
				{
					this.OnActive.call(this.target);
				}

				for( local t = this.target.x > this.ox ? 4 : -4; this.count-- > 0;  )
				{
					if (!this.target)
					{
						return;
					}

					this.target.x = this.ox + this.count * this.count * t;

					if (this.OnMove)
					{
						this.OnMove.call(this.target);
					}

					yield true;
				}
			}());
			break;

		case -1:
			this.task.Set(function ()
			{
				// Function is a generator.
				local env = this;

				while (this.count++ < 20)
				{
					if (!this.target)
					{
						return;
					}

					this.target.x = this.ox - this.count * this.count * 4;

					if (this.OnMove)
					{
						this.OnMove.call(this.target);
					}

					yield true;
				}

				if (!this.target)
				{
					return;
				}

				if (this.OnDeactive)
				{
					this.OnDeactive.call(this.target);
				}

				this.target.visible = false;
			}());

			if (this.target.x > this.ox)
			{
				this.target.x = this.ox;
			}

			break;

		case 1:
			this.task.Set(function ()
			{
				// Function is a generator.
				local env = this;

				while (this.count++ < 20)
				{
					if (!this.target)
					{
						return;
					}

					this.target.x = this.ox + this.count * this.count * 4;

					if (this.OnMove)
					{
						this.OnMove.call(this.target);
					}

					yield true;
				}

				if (!this.target)
				{
					return;
				}

				if (this.OnDeactive)
				{
					this.OnDeactive.call(this.target);
				}

				this.target.visible = false;
			}());

			if (this.target.x < this.ox)
			{
				this.target.x = this.ox;
			}

			break;
		}
	}

	function Activate( direction )
	{
		if (direction != this.state)
		{
			this.count = 20;
		}

		if (direction == 0)
		{
			this.count = 0;
			this.target.x = this.ox;
		}
		else
		{
			this.target.x = direction < 0 ? this.ox - this.count * this.count * 4 : this.ox + this.count * this.count * 4;
		}

		if (this.action)
		{
			this.action.state = 0;
		}

		this.SetState(0);
	}

}

class this.UIPager 
{
	action = null;
	state = 0;
	page = null;
	index = 0;
	constructor()
	{
		this.page = [];
	}

	function Clear()
	{
		foreach( v in this.page )
		{
			v.Terminate();
		}

		this.page.resize(0);
		this.index = 0;
	}

	function Append( _target )
	{
		_target.action = this.action;
		this.page.append(_target);
	}

	function Activate( _index, dir = 0 )
	{
		this.index = _index;

		foreach( i, v in this.page )
		{
			if (i == this.index)
			{
				v.Activate(dir);
			}
			else
			{
				v.SetState(-1);
			}
		}
	}

	function Deactivate( dir = 1 )
	{
		if (this.index >= this.page.len())
		{
			return;
		}

		this.page[this.index].SetState(dir);
	}

	function Set( _index )
	{
		if (this.index == _index)
		{
			return;
		}

		local diff = _index - this.index;

		if (diff > 1)
		{
			diff = -1;
		}
		else if (diff < -1)
		{
			diff = 1;
		}

		if (diff > 0)
		{
			this.page[this.index].SetState(-1);
			this.page[_index].Activate(1);
		}
		else if (diff < 0)
		{
			this.page[this.index].SetState(1);
			this.page[_index].Activate(-1);
		}
		else
		{
			this.page[_index].Activate(0);
		}

		this.index = _index;
	}

	function Next()
	{
		if (this.page.len() <= 1)
		{
			return;
		}

		this.page[this.index].SetState(-1);
		this.index = (this.index + 1) % this.page.len();
		this.page[this.index].Activate(1);
	}

	function Prev()
	{
		if (this.page.len() <= 1)
		{
			return;
		}

		this.page[this.index].SetState(1);
		this.index = (this.index - 1 + this.page.len()) % this.page.len();
		this.page[this.index].Activate(-1);
	}

	function Update()
	{
		this.page[this.index].Update();
	}

}

class this.UIItemHighlight 
{
	back = ::manbow.Sprite();
	left = 0;
	right = 0;
	width = 16;
	height = 16;
	mat_world = null;
	count = 0;
	function Set( _left, top, _right, bottom )
	{
		local texture = ::menu.cursor.texture_back;
		this.left = _left;
		this.right = _right;
		this.width = this.right - this.left;
		this.height = bottom - top;
		this.back.Initialize(::menu.cursor.texture_back, 0, 0, this.width, this.height);
		this.back.x = this.left;
		this.back.y = top;
		this.back.address = 0;
		this.back.red = 0;
		this.back.alpha = 0,50000000.0;
		::menu.cursor.left.x = this.left - 32;
		::menu.cursor.right.x = this.right + 32;
		::menu.cursor.left.y = ::menu.cursor.right.y = (top + bottom) / 2 - 16;
		::menu.cursor.left.ConnectRenderSlot(this.graphics.slot.overlay, -1);
		::menu.cursor.right.ConnectRenderSlot(this.graphics.slot.overlay, -1);
		this.back.ConnectRenderSlot(this.graphics.slot.overlay, -1);
		this.count = 0;
		::loop.AddTask(this);
	}

	function Reset()
	{
		::menu.cursor.left.DisconnectRenderSlot();
		::menu.cursor.right.DisconnectRenderSlot();
		this.back.DisconnectRenderSlot();
		::loop.DeleteTask(this);
	}

	function Show()
	{
	}

	function Hide()
	{
	}

	function Update()
	{
		this.count++;
		this.back.SetUV(0, this.count * 2 % 128, this.width, this.height);
		local a = this.abs(this.sin(this.count * 0,10000000.0) * 4);
		::menu.cursor.left.x = this.left - 32 - a;
		::menu.cursor.right.x = this.right + 32 + a;
	}

}

class this.UIItemSelector 
{
	item = null;
	cursor = null;
	mat_world = null;
	cur = 0;
	red = 1;
	green = 1;
	blue = 1;
	constructor( item_list, x, y, width, _mat_world, _cursor )
	{
		this.cursor = _cursor;
		this.mat_world = _mat_world;
		this.item = [];
		local w = 0;
		local _ltem_list = clone item_list;
		_ltem_list.resize(this.cursor.item_num, "no text");

		foreach( v in _ltem_list )
		{
			local text = ::font.CreateSystemString(v);
			text.y = y;
			text.ConnectRenderSlot(::graphics.slot.overlay, 0);
			this.item.append(text);
			w = w + text.width;
		}

		if (this.item.len() > 1)
		{
			local w = width / this.item.len();

			foreach( i, v in this.item )
			{
				v.x = x - v.width / 2 + w * (i + 0,50000000.0);
			}
		}
		else
		{
			this.item[0].x = x + width / 2 - this.v.width;
		}

		this.cur = this.cursor.val;

		foreach( i, v in this.item )
		{
			v.SetWorldTransform(this.mat_world);
			v.red = v.green = v.blue = this.cursor.val == i ? 1,00000000.0 : 0,50000000.0;
		}
	}

	function Show()
	{
		foreach( v in this.item )
		{
			v.visible = true;
		}
	}

	function Hide()
	{
		foreach( v in this.item )
		{
			v.visible = false;
		}
	}

	function SetColor( _r, _g, _b )
	{
		this.red = _r;
		this.green = _g;
		this.blue = _b;

		foreach( i, v in this.item )
		{
			local c = this.cursor.val == i ? 1,00000000.0 : 0,50000000.0;
			v.red = this.red * c;
			v.green = this.green * c;
			v.blue = this.blue * c;
		}
	}

	function Update()
	{
		foreach( i, v in this.item )
		{
			v.SetWorldTransform(this.mat_world);
		}

		if (this.cursor.val != this.cur)
		{
			this.item[this.cur].red = this.red * 0,50000000.0;
			this.item[this.cur].green = this.green * 0,50000000.0;
			this.item[this.cur].blue = this.blue * 0,50000000.0;
			this.cur = this.cursor.val;
			this.item[this.cur].red = this.red;
			this.item[this.cur].green = this.green;
			this.item[this.cur].blue = this.blue;
		}
	}

}

class this.UIItemSelectorSingle 
{
	item = null;
	cursor = null;
	mat_world = null;
	current = 0;
	active = false;
	highlight = null;
	left = 9999;
	top = 9999;
	right = -9999;
	bottom = -9999;
	constructor( item_list, x, y, _mat_world, _cursor )
	{
		this.cursor = _cursor;
		this.mat_world = _mat_world;
		this.item = [];
		local w = 0;
		local _ltem_list = clone item_list;
		_ltem_list.resize(this.cursor.item_num, "no text");

		foreach( v in _ltem_list )
		{
			local text = ::font.CreateSystemString(v);
			text.x = x - text.width / 2;
			text.y = y;
			text.ConnectRenderSlot(::graphics.slot.overlay, 0);
			this.item.append(text);

			if (text.x < this.left)
			{
				this.left = text.x;
			}

			if (text.x + text.width > this.right)
			{
				this.right = text.x + text.width;
			}
		}

		this.left -= 8;
		this.right += 8;
		this.top = y + 10;
		this.bottom = this.top + ::font.system_size + 3;
		this.current = this.cursor.val;

		foreach( i, v in this.item )
		{
			v.SetWorldTransform(this.mat_world);
			v.visible = this.cursor.val == i;
		}

		this.highlight = this.UIItemHighlight();
	}

	function Show()
	{
		this.item[this.cursor.val].visible = true;
	}

	function Hide()
	{
		this.item[this.cursor.val].visible = false;
	}

	function SetColor( r, g, b )
	{
		foreach( i, v in this.item )
		{
			v.red = r;
			v.green = g;
			v.blue = b;
		}
	}

	function Update()
	{
		foreach( i, v in this.item )
		{
			v.SetWorldTransform(this.mat_world);
		}

		if (this.cursor.val != this.current)
		{
			this.item[this.current].visible = false;
			this.current = this.cursor.val;
			this.item[this.current].visible = true;
		}

		if (this.cursor.active && !this.active)
		{
			this.highlight.Set(this.left, this.top, this.right, this.bottom);
			this.active = true;
		}
		else if (!this.cursor.active && this.active)
		{
			this.highlight.Reset();
			this.active = false;
		}
	}

}

