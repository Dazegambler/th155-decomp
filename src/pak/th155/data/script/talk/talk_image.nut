class this.Image 
{
	sprite = null;
	group = "";
	x = 0;
	y = 0;
	direction = 1;
	function Create( filename )
	{
		local texture = ::manbow.Texture();
		texture.Load(filename);
		this.sprite = ::manbow.Sprite();
		this.sprite.Initialize(texture, 0, 0, texture.width, texture.height);
		this.sprite.alpha = 0;
	}

	function SetPosition( _x, _y )
	{
		this.x = _x;
		this.y = _y;
		local mat = ::manbow.Matrix();

		if (this.direction < 0)
		{
			mat.SetScaling(-1, 1, 1);
			mat.Translate(this.x, this.y, 0);
		}
		else
		{
			mat.SetTranslation(this.x, this.y, 0);
		}

		this.sprite.SetWorldTransform(mat);
	}

	function Show( count = 30 )
	{
		this.sprite.ConnectRenderSlot(::graphics.slot.talk, 0);

		if (count <= 0)
		{
			this.sprite.alpha = 1;
			return;
		}

		local t = ::newthread(function ( t, count )
		{
			local delta = (1.00000000 - t.sprite.alpha) / count.tofloat();

			for( local i = 0; i < count; i = ++i )
			{
				t.sprite.alpha += delta;
				this.suspend();
			}
		});
		t.call(this, count);
		::talk.async_task[this.tostring()] <- t;
	}

	function Hide( count = 30 )
	{
		if (count <= 0)
		{
			this.sprite.DisconnectRenderSlot();
			return;
		}

		local t = ::newthread(function ( t, count )
		{
			local delta = t.sprite.alpha / count.tofloat();

			for( local i = 0; i < count; i = ++i )
			{
				t.sprite.alpha -= delta;
				this.suspend();
			}

			t.sprite.DisconnectRenderSlot();
		});
		t.call(this, count);
		::talk.async_task[this.tostring()] <- t;
	}

}

