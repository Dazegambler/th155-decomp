class this.Text 
{
	x = 1155;
	y = 130;
	offset = 0;
	scale = 0.00000000;
	text = null;
	constructor()
	{
		this.text = [];
	}

	function Set( _text )
	{
		this.text = [];
		this.offset = 0;
		this.CreateText(_text);
	}

	function Add( _text )
	{
		this.CreateText(_text);
	}

	function CreateText( _text )
	{
		local len = _text.len();

		if (len == 0)
		{
			this.offset -= 26 + 10;
			return;
		}

		local t = ::manbow.String();
		t.Initialize(::talk.font);
		t.SetVertical(true);
		t.SetSpace(0, 10);
		t.filter = 1;
		t.Set(_text);
		t.x = this.x + this.offset;
		t.y = this.y;
		t.red = t.blue = t.green = 0;
		t.alpha = 0;
		this.offset -= t.width + 10;
		this.text.append(t);
	}

	function Show()
	{
		foreach( v in this.text )
		{
			v.ConnectRenderSlot(::graphics.slot.talk, 20);
		}

		local t = ::newthread(function ( t )
		{
			for( local b = true; b;  )
			{
				b = false;

				foreach( v in t.text )
				{
					if (v.alpha < 1.00000000)
					{
						v.alpha += 0.10000000;
						b = true;
					}
				}

				this.suspend();
			}
		});
		t.call(this);
		::talk.async_task[this.tostring()] <- t;
	}

	function Hide()
	{
		local t = ::newthread(function ( t )
		{
			local b = true;

			while (b)
			{
				b = false;

				foreach( v in t.text )
				{
					if (v.alpha > 0.00000000)
					{
						v.alpha -= 0.10000000;
						b = true;
					}
				}

				this.suspend();
			}

			foreach( v in t.text )
			{
				v.DisconnectRenderSlot();
			}
		});
		t.call(this);
		::talk.async_task[this.tostring()] <- t;
	}

	function Update()
	{
	}

}

