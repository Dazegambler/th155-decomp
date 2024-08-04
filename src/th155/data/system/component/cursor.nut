class this.CursorBase 
{
	input = null;
	ok = false;
	cancel = false;
	active = false;
	se_cursor = "sys_cursor";
	se_ok = "sys_ok";
	se_cancel = "sys_cancel";
	loop = true;
	enable_ok = true;
	enable_cancel = true;
	diff = 0;
	function Reset()
	{
		this.ok = false;
		this.cancel = false;
		this.active = false;
		this.diff = 0;
	}

	function UpdateButton()
	{
		this.active = true;
		this.ok = false;
		this.cancel = false;

		if (this.enable_ok && this.input.b0 == 1)
		{
			::PlaySE(this.se_ok);
			this.input.Lock();
			this.diff = 0;
			this.ok = true;
			this.active = false;
			return true;
		}

		if (this.enable_cancel && this.input.b1 == 1)
		{
			::PlaySE(this.se_cancel);
			this.input.Lock();
			this.diff = 0;
			this.cancel = true;
			this.active = false;
			return true;
		}

		return false;
	}

}

class this.Cursor extends this.CursorBase
{
	val = 0;
	item_num = 1;
	dir = 1;
	skip = null;
	update = null;
	constructor( _type, _num, _input = null )
	{
		switch(_type)
		{
		case 0:
			this.update = this.UpdateV;
			break;

		case 1:
			this.update = this.UpdateH;
			break;

		default:
			this.update = this.UpdateVH;
			break;
		}

		this.item_num = _num;
		this.input = _input;
	}

	function Update()
	{
		this.diff = 0;

		if (this.UpdateButton())
		{
			return;
		}

		if (this.update())
		{
			::PlaySE(this.se_cursor);

			if (this.skip)
			{
				for( local i = 0; i < this.item_num; i = ++i )
				{
					if (this.loop)
					{
						this.val = (this.val + this.item_num) % this.item_num;
					}
					else if (this.val < 0)
					{
						this.val = 0;
						  // [046]  OP_JMP            0     28    0    0
					}
					else if (this.val >= this.item_num)
					{
						this.val = this.item_num - 1;
					}

					if (!this.skip[this.val])
					{
						break;
					}

					this.val += this.diff * this.dir;
				}
			}
			else if (this.loop)
			{
				this.val = (this.val + this.item_num) % this.item_num;
			}
			else if (this.val < 0)
			{
				this.val = 0;
			}
			else if (this.val >= this.item_num)
			{
				this.val = this.item_num - 1;
			}
		}
	}

	function UpdateV()
	{
		if (this.input.y == -1 || this.input.y % 7 == 0 && this.input.y < -25)
		{
			this.diff = -1;
			this.val -= this.dir;
			return true;
		}

		if (this.input.y == 1 || this.input.y % 7 == 0 && this.input.y > 25)
		{
			this.diff = 1;
			this.val += this.dir;
			return true;
		}

		return false;
	}

	function UpdateH()
	{
		if (this.input.x == -1 || this.input.x % 7 == 0 && this.input.x < -25)
		{
			this.diff = -1;
			this.val -= this.dir;
			return true;
		}
		else if (this.input.x == 1 || this.input.x % 7 == 0 && this.input.x > 25)
		{
			this.diff = 1;
			this.val += this.dir;
			return true;
		}

		return false;
	}

	function UpdateVH()
	{
		if (this.UpdateV())
		{
			return true;
		}

		if (this.UpdateH())
		{
			return true;
		}

		return false;
	}

	function SetSkip( _t )
	{
		this.skip = [];
		this.skip.resize(this.item_num);

		foreach( i, v in _t )
		{
			if (i >= this.item_num)
			{
				break;
			}

			this.skip[i] = v;
		}
	}

	function SetItemNum( n )
	{
		this.item_num = n;

		if (this.val >= this.item_num)
		{
			this.val = this.item_num - 1;
		}
	}

}

class this.Cursor2 extends this.CursorBase
{
	x = 0;
	y = 0;
	item_num_x = 1;
	item_num_y = 1;
	diff_x = 0;
	diff_y = 0;
	skip = null;
	constructor( _x, _y, _input = null )
	{
		this.item_num_x = _x;
		this.item_num_y = _y;
		this.input = _input;
	}

	function Update()
	{
		this.diff_x = 0;
		this.diff_y = 0;

		if (this.input.x == -1 || this.input.x % 7 == 0 && this.input.x < -25)
		{
			this.diff_x = -1;
			this.x -= 1;
		}
		else if (this.input.x == 1 || this.input.x % 7 == 0 && this.input.x > 25)
		{
			this.diff_x = 1;
			this.x += 1;
		}

		if (this.loop)
		{
			this.x = (this.x + this.item_num_x) % this.item_num_x;
		}
		else if (this.x < 0)
		{
			this.x = 0;
		}
		else if (this.x >= this.item_num_x)
		{
			this.x = this.item_num_x - 1;
		}

		if (this.skip)
		{
			for( local i = 0; i < this.item_num_x; i = ++i )
			{
				if (this.loop)
				{
					this.x = (this.x + this.item_num_x) % this.item_num_x;
				}
				else if (this.x < 0)
				{
					this.x = 0;
					  // [123]  OP_JMP            0     28    0    0
				}
				else if (this.x >= this.item_num_x)
				{
					this.x = this.item_num_x - 1;
				}

				if (!this.skip[this.y][this.x])
				{
					break;
				}

				this.x += this.diff_x;
			}
		}

		if (this.input.y == -1 || this.input.y % 7 == 0 && this.input.y < -25)
		{
			this.diff_y = -1;
			this.y -= 1;
		}
		else if (this.input.y == 1 || this.input.y % 7 == 0 && this.input.y > 25)
		{
			this.diff_y = 1;
			this.y += 1;
		}

		if (this.loop)
		{
			this.y = (this.y + this.item_num_y) % this.item_num_y;
		}
		else if (this.y < 0)
		{
			this.y = 0;
		}
		else if (this.y >= this.item_num_y)
		{
			this.y = this.item_num_y - 1;
		}

		if (this.skip)
		{
			for( local i = 0; i < this.item_num_y; i = ++i )
			{
				if (this.loop)
				{
					this.y = (this.y + this.item_num_y) % this.item_num_y;
				}
				else if (this.y < 0)
				{
					this.y = 0;
					  // [267]  OP_JMP            0     28    0    0
				}
				else if (this.y >= this.item_num_y)
				{
					this.y = this.item_num_y - 1;
				}

				if (!this.skip[this.y][this.x])
				{
					break;
				}

				this.y += this.diff_y;
			}
		}

		if (this.diff_x || this.diff_y)
		{
			::PlaySE(this.se_cursor);
		}

		this.UpdateButton();
	}

	function SetSkip( _t )
	{
		this.skip = [];
		this.skip.resize(this.item_num_y);

		for( local _y = 0; _y < this.item_num_y; _y = ++_y )
		{
			this.skip[_y] = [];
			this.skip[_y].resize(this.item_num_x, false);

			if (_y >= _t.len())
			{
			}
			else
			{
				for( local _x = 0; _x < this.item_num_x; _x = ++_x )
				{
					if (_x >= _t[this.y].len())
					{
						break;
					}

					if (_t[_y][_x] == null)
					{
						this.skip[_y][_x] = true;
					}
				}
			}
		}
	}

}

class this.CursorCustom extends this.CursorBase
{
	val = 0;
	table = [
		[
			0,
			0,
			0,
			0
		]
	];
	function Initialize( a )
	{
		this.table = a;
	}

	function Update()
	{
		local val_prev = this.val;

		if (this.input.y == -1 || this.input.y % 7 == 0 && this.input.y < -25)
		{
			this.val = this.table[this.val][0];
		}
		else if (this.input.y == 1 || this.input.y % 7 == 0 && this.input.y > 25)
		{
			this.val = this.table[this.val][1];
		}
		else if (this.input.x == -1 || this.input.x % 7 == 0 && this.input.x < -25)
		{
			this.val = this.table[this.val][2];
		}
		else if (this.input.x == 1 || this.input.x % 7 == 0 && this.input.x > 25)
		{
			this.val = this.table[this.val][3];
		}

		if (this.val != val_prev)
		{
			::PlaySE(this.se_cursor);
		}

		this.UpdateButton();
	}

}

