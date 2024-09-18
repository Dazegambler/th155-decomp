function Initialize()
{
	this.obj[1].y = -40;
	local action = ::menu.network;
	this.Update = action.dialog_port.Update;
	local space = 20;
	local offset = -space * 5 / 2;

	foreach( i, v in action.server_port_v )
	{
		local t = ::font.CreateSystemString(v.val.tostring());
		t.x = offset;
		this.obj.append(t);
		offset = offset + space;
	}

	local t = ::manbow.Sprite();
	t.Initialize(action.anime.texture, 352, 480, 32, 96);
	t.y = -23;
	this.obj.append(t);
}

function Update()
{
	::menu.cursor.SetTarget(this.obj[1].x - 20 + ::graphics.width / 2, this.obj[1].y + 24 + ::graphics.height / 2, 0.69999999);
	::menu.network.UpdateInputPort();

	foreach( i, v in ::menu.network.server_port_v )
	{
		local t = this.obj[i + 2];
		t.Set(v.val.tostring());

		if (i == ::menu.network.server_port_h.val)
		{
			local t2 = this.obj.top();
			t2.x = t.x - 4;
			t.red = t.blue = t.green = 1.00000000;
		}
		else
		{
			t.red = t.blue = t.green = 0.50000000;
		}
	}
}

