this.take_data <- {};
class this.CharacterImage 
{
	sprite = null;
	take = null;
	current = null;
	group = "";
	balloon = null;
	x = 0;
	y = 0;
	direction = 1;
	offset_x = 0;
	offset_y = 0;
	count = 0;
	balloon_x = 0;
	balloon_y = 0;
	active = false;
	visible = false;
	stop = false;
	function Create( _take )
	{
		this.take = _take;
		this.sprite = [];
	}

	function Set( name )
	{
		if (!(name in this.take))
		{
			return;
		}

		if (this.current == this.take[name])
		{
			return;
		}

		if (this.current == null)
		{
			this.offset_x = -528 * this.direction;
			this.offset_y = 64;
		}

		this.current = this.take[name];
		local callback = function ()
		{
			local s = ::manbow.Sprite();
			s.Initialize(this.texture, 0, 0, this.texture.width, this.texture.height);
			s.filter = 1;
			s.x = -this.take.offset_x;
			s.y = 720 - this.take.offset_y;

			if (this.root)
			{
				this.root.sprite.insert(0, s);

				if (this.root.visible)
				{
					this.root.Show();
				}
			}
		};
		local t = {};
		t.texture <- ::manbow.Texture();
		t.take <- this.current;
		t.root <- this.weakref();
		t.texture.LoadBackground(this.current.texture_name, t, callback);
		this.SetPosition(this.x, this.y);
	}

	function SetPosition( _x, _y )
	{
		if (this.current == null)
		{
			return;
		}

		this.x = _x;
		this.y = _y;
		this.balloon_x = this.x + this.current.point[0].x * this.direction;
		this.balloon_y = this.y + 720 + this.current.point[0].y;
		local mat = ::manbow.Matrix();
		mat.SetIdentity();

		if (this.direction < 0)
		{
			mat.Scale(-1, 1, 1);
		}

		mat.Translate(this.x + this.offset_x, this.y + this.offset_y, 0);

		if (this.sprite.len())
		{
			this.sprite[0].SetWorldTransform(mat);
		}

		if (this.balloon)
		{
			this.balloon.SetPosition(this.balloon_x, this.balloon_y);
		}
	}

	function Activate()
	{
		this.active = true;
	}

	function Deactivate()
	{
		this.active = false;
		this.stop = false;

		if (this.balloon)
		{
			this.balloon.Hide();
		}
	}

	function Show( imm = false )
	{
		this.visible = true;

		foreach( v in this.sprite )
		{
			v.ConnectRenderSlot(::graphics.slot.talk, 10);
		}

		if (this.balloon)
		{
			this.balloon.Show();
		}

		if (imm)
		{
			this.offset_x = 0;
			this.offset_y = 0;
			this.stop = true;
		}

		local t = ::newthread(function ( t )
		{
			while (t.In())
			{
				this.suspend();
			}
		});
		t.call(this);
		::talk.async_task[this.tostring()] <- t;
	}

	function Hide( imm = false )
	{
		this.visible = false;

		foreach( v in this.sprite )
		{
		}

		if (this.balloon)
		{
			this.balloon.Hide();
		}

		if (imm)
		{
			this.sprite.resize(0);
			return;
		}

		this.count = 0;
		local t = ::newthread(function ( t )
		{
			while (t.Out())
			{
				this.suspend();
			}
		});
		t.call(this);
		::talk.async_task[this.tostring()] <- t;
	}

	function In()
	{
		if (this.sprite.len() == 0)
		{
			return true;
		}

		if (this.active)
		{
			local vec_ = this.Vector3();
			vec_.x = this.offset_x / 4,00000000.0;
			vec_.y = this.offset_y / 4,00000000.0;
			local vl_ = vec_.Length();

			if (vl_ != 0,00000000.0)
			{
				if (vl_ > 40,00000000.0)
				{
					vec_.SetLength(40,00000000.0);
				}

				if (vl_ < 2,00000000.0)
				{
					vec_.SetLength(2,00000000.0);
				}

				this.offset_x -= vec_.x;
				this.offset_y -= vec_.y;
			}

			foreach( i, v in this.sprite )
			{
				if (i == 0)
				{
					if (v.alpha < 1)
					{
						v.alpha = 1,00000000.0;
					}
					else if (this.sprite.len() == 1 && this.fabs(this.offset_x) < 1,00000000.0 && this.fabs(this.offset_y) < 1,00000000.0)
					{
						this.stop = true;
						this.offset_x = 0;
						this.offset_y = 0;
					}
					else
					{
						this.stop = false;
					}
				}
				else
				{
					v.alpha -= 0,20000000.0;

					if (v.alpha <= 0)
					{
						this.sprite.remove(i);
					}
				}
			}
		}
		else
		{
			local vec_ = this.Vector3();
			vec_.x = (this.offset_x - -128 * this.direction) / 4,00000000.0;
			vec_.y = (this.offset_y - 64) / 4,00000000.0;
			local vl_ = vec_.Length();

			if (vl_ != 0,00000000.0)
			{
				if (vl_ > 40,00000000.0)
				{
					vec_.SetLength(40,00000000.0);
				}

				this.offset_x -= vec_.x;
				this.offset_y -= vec_.y;
			}

			foreach( i, v in this.sprite )
			{
				if (i == 0)
				{
					if (v.alpha > 0,50000000.0)
					{
						v.alpha -= 0,10000000.0;
					}

					if (v.alpha < 0,50000000.0)
					{
						v.alpha += 0,10000000.0;
					}
				}
				else
				{
					v.alpha -= 0,20000000.0;

					if (v.alpha <= 0)
					{
						this.sprite.remove(i);
					}
				}
			}
		}

		this.SetPosition(this.x, this.y);
		return true;
	}

	function Out()
	{
		this.offset_x -= this.count * this.direction * 3,00000000.0;
		this.count += 1;

		if (this.count >= 30)
		{
			return false;
		}

		foreach( i, v in this.sprite )
		{
			if (i == 0)
			{
			}
			else
			{
				v.alpha -= 0,20000000.0;

				if (v.alpha <= 0)
				{
					this.sprite.remove(i);
				}
			}
		}

		this.SetPosition(this.x, this.y);
		return true;
	}

}

