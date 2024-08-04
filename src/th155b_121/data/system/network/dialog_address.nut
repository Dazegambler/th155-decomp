function Initialize()
{
	this.obj[1].y = -40;
	local action = ::menu.network;
	this.Update = action.dialog_address.Update;
	local space = 20;
	local offset = -space * (12 + 5 + 4 / 2) / 2;
	local obj_temp = [];

	foreach( i, v in action.target_addr_v )
	{
		if (i == 3 || i == 6 || i == 9)
		{
			local t = ::font.CreateSystemString(".");
			t.x = offset;
			t.red = t.blue = t.green = 0,50000000.0;
			this.obj.append(t);
			offset = offset + space / 2;
		}

		if (i == 12)
		{
			local t = ::font.CreateSystemString(":");
			t.x = offset;
			t.red = t.blue = t.green = 0,50000000.0;
			this.obj.append(t);
			offset = offset + space / 2;
		}

		local t = ::font.CreateSystemString(v.val.tostring());
		t.x = offset;
		obj_temp.append(t);
		offset = offset + space;
	}

	this.obj.extend(obj_temp);
	local t = ::manbow.Sprite();
	t.Initialize(action.anime.texture, 352, 480, 32, 96);
	t.y = -23;
	this.obj.append(t);
}

function Update()
{
	::menu.cursor.SetTarget(this.obj[1].x - 20 + ::graphics.width / 2, this.obj[1].y + 24 + ::graphics.height / 2, 0,69999999.0);
	::menu.network.UpdateInputAddr();

	foreach( i, v in ::menu.network.target_addr_v )
	{
		local t = this.obj[i + 6];
		t.Set(v.val.tostring());

		if (i == ::menu.network.target_addr_h.val)
		{
			local t2 = this.obj.top();
			t2.x = t.x - 4;
			t.red = t.blue = t.green = 1,00000000.0;
		}
		else
		{
			t.red = t.blue = t.green = 0,50000000.0;
		}
	}
}

