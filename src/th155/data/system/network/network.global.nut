function OnCreate()
{
}

function Init()
{
	this.action <- ::menu.network.weakref();
	this.count <- 20;
	this.item <- [
		"lobby_incomming",
		"lobby_match",
		null,
		"server",
		"client",
		null,
		"port",
		"upnp",
		null,
		"exit"
	];
	this.ox <- 640 - (this.gl.title.x + this.resource.title.src_width / 2);
	this.gl.x = this.ox - 1280;
	this.gl.y = ::menu.common.title_y;
	this.msg_window.visible = false;
	this.msg_window.x = (1280 - this.resource.mini_window.src_width) / 2;
	this.msg_window.y = (720 - this.resource.mini_window.src_height) / 2;
	this.addr_window.visible = false;
	this.addr_window.x = (1280 - this.resource.mini_window.src_width) / 2;
	this.addr_window.y = (720 - this.resource.mini_window.src_height) / 2;
	this.addr_cursor_x <- this.addr_window.cursor.x;
	this.port_window.visible = false;
	this.port_window.x = (1280 - this.resource.mini_window.src_width) / 2;
	this.port_window.y = (720 - this.resource.mini_window.src_height) / 2;
	this.port_cursor_x <- this.port_window.cursor.x;
	this.base_x <- {};

	foreach( v in this.item )
	{
		if (v)
		{
			this.base_x[v] <- this.resource[v].src_x;
		}
	}

	this.base_x.on <- this.resource.on.src_x;
	this.base_x.off <- this.resource.off.src_x;
	this.resource.on.src_x = this.base_x.on + (this.action.cursor_upnp.val == 0 ? -512 : 0);
	this.resource.off.src_x = this.base_x.off + (this.action.cursor_upnp.val == 1 ? -512 : 0);
	this.resource.lobby_incomming.src_x -= 512;
	local val = this.action.cursor.val;

	foreach( i, v in this.item )
	{
		if (v)
		{
			this.resource[v].src_x = this.base_x[v] + (val == i ? -512 : 0);
		}
	}
}

function Update()
{
	switch(this.action.state)
	{
	case 0:
		::menu.cursor.SetTarget(this.ox + this.gl.lobby_incomming.x - 20, this.gl.y + this.gl.lobby_incomming.y + 16 + this.action.cursor.val * 36, 0,69999999.0);

		if (this.count > 0)
		{
			this.count--;

			if (this.gl.x > this.ox)
			{
				this.gl.x = this.ox + this.count * this.count * 4;
			}
			else
			{
				this.gl.x = this.ox - this.count * this.count * 4;
			}
		}

		break;

	case -1:
		if (this.count < 20)
		{
			this.count++;
			this.gl.x = this.ox - this.count * this.count * 4;
		}

		break;

	case 1:
		if (this.count < 20)
		{
			this.count++;
			this.gl.x = this.ox + this.count * this.count * 4;
		}

		break;
	}

	if (this.action.cursor.diff)
	{
		local val = this.action.cursor.val;

		foreach( i, v in this.item )
		{
			if (v)
			{
				this.resource[v].src_x = this.base_x[v] + (val == i ? -512 : 0);
			}
		}
	}

	if (this.action.cursor_upnp.diff)
	{
		this.resource.on.src_x = this.base_x.on + (this.action.cursor_upnp.val == 0 ? -512 : 0);
		this.resource.off.src_x = this.base_x.off + (this.action.cursor_upnp.val == 1 ? -512 : 0);
	}

	if (this.action.update == this.action.UpdateWaitServer)
	{
		this.resource.message.src_y = 352;
		this.resource.message.src_width = 288;
		this.msg_window.visible = true;
		this.msg_window.text.x = (this.resource.mini_window.src_width - this.resource.message.src_width) / 2 + 16;
		this.msg_window.text.y = 48;
		this.msg_window.upnp_state.visible = ::config.network.upnp;
		this.msg_window.upnp_state_title.visible = ::config.network.upnp;
		::menu.cursor.SetTarget(this.msg_window.x + this.msg_window.text.x - 16, this.msg_window.y + this.msg_window.text.y + 16, 0,69999999.0);
	}
	else if (this.action.update == this.action.UpdateMatch || this.action.update == this.action.UpdateMatchWait)
	{
		this.resource.message.src_y = 320;
		this.resource.message.src_width = 288;
		this.msg_window.visible = true;
		this.msg_window.text.x = (this.resource.mini_window.src_width - this.resource.message.src_width) / 2 + 16;
		this.msg_window.text.y = 48;

		if (::network.upnp_port)
		{
			this.msg_window.upnp_state.visible = true;
			this.msg_window.upnp_state_title.visible = true;
		}
		else
		{
			this.msg_window.upnp_state.visible = false;
			this.msg_window.upnp_state_title.visible = false;
		}

		::menu.cursor.SetTarget(this.msg_window.x + this.msg_window.text.x - 16, this.msg_window.y + this.msg_window.text.y + 16, 0,69999999.0);
	}
	else if (this.action.update == this.action.UpdateWaitClient)
	{
		this.resource.message.src_y = 384;
		this.resource.message.src_width = 320;
		this.msg_window.visible = true;
		this.msg_window.text.x = (this.resource.mini_window.src_width - this.resource.message.src_width) / 2 + 16;
		this.msg_window.text.y = 48;
		this.msg_window.upnp_state.visible = false;
		this.msg_window.upnp_state_title.visible = false;
		::menu.cursor.SetTarget(this.msg_window.x + this.msg_window.text.x - 16, this.msg_window.y + this.msg_window.text.y + 16, 0,69999999.0);
	}
	else
	{
		this.msg_window.visible = false;
	}

	if (this.action.update == this.action.UpdateInputAddr)
	{
		this.addr_window.visible = true;
		local c = this.action.target_addr_h.val;

		if (this.action.target_addr_h.val <= 12)
		{
			c = c + this.action.target_addr_h.val / 3;
		}
		else
		{
			c = c + 4;
		}

		this.addr_window.cursor.x = this.addr_cursor_x + c * 20;
		::menu.cursor.SetTarget(this.addr_window.x + this.addr_window.input_addr.x - 16, this.addr_window.y + this.addr_window.input_addr.y + 16, 0,69999999.0);
	}
	else
	{
		this.addr_window.visible = false;
	}

	if (this.action.update == this.action.UpdateInputPort)
	{
		this.port_window.visible = true;
		this.port_window.cursor.x = this.port_cursor_x + this.action.server_port_h.val * 20;
		::menu.cursor.SetTarget(this.port_window.x + this.port_window.input_port.x - 16, this.port_window.y + this.port_window.input_port.y + 16, 0,69999999.0);
	}
	else
	{
		this.port_window.visible = false;
	}
}

function Draw()
{
	local state = ::LOBBY.GetNetworkState();
	local st_text = "";

	switch(state)
	{
	case 0:
		this.resource.lobby_state.src_x = 128;
		break;

	case 1:
		this.resource.lobby_state.src_x = 0;
		break;

	case 2:
		this.resource.lobby_state.src_x = 256;
		break;

	default:
		this.resource.lobby_state.src_x = 128;
		break;
	}

	local upnp_state = ::UPnP.GetAsyncState();

	switch(::UPnP.GetAsyncState())
	{
	case 0:
		this.resource.upnp_state.src_y = 672;
		break;

	case 1:
		this.resource.upnp_state.src_y = 672 + 32;
		break;

	case 2:
		if (::UPnP.GetExternalIP() == "")
		{
			this.resource.upnp_state.src_y = 672;
		}
		else
		{
			this.resource.upnp_state.src_y = 672 + 64;
		}

		break;

	case 3:
		this.resource.upnp_state.src_y = 672 + 32;
		break;
	}

	local port = ::config.network.hosting_port;

	for( local i = 0; i < 5; i = ++i )
	{
		local d = port % 10;
		local offset = d * 32;
		this.gl.port.Blit(408 - i * 20, 0, 32, 32, this.resource.num, offset, 0, this.BLEND_ALPHA, 1,00000000.0);
		port = port / 10;

		if (port == 0)
		{
			break;
		}
	}

	if (this.msg_window.visible)
	{
		if (this.msg_window.upnp_state.visible)
		{
			local ip = ::UPnP.GetAsyncState() == 2 ? ::UPnP.GetExternalIP() : "";

			if (ip != "")
			{
				local actor = this.msg_window.upnp_state;
				local x = 52;
				local y = 1;

				for( local i = 0; i < ip.len(); i = ++i )
				{
					local offset = (ip[i] == 46 ? 11 : ip[i].tointeger() - 48) * 32;
					actor.Blit(x, y, 32, 32, this.resource.num, offset, 0, this.BLEND_ALPHA, 1,00000000.0);
					actor.BlitScale(0,50000000.0, 0,50000000.0, 0, 0);
					x = x + 10;
				}
			}
		}
	}

	if (this.addr_window.visible)
	{
		local x = this.addr_cursor_x + 2;
		local y = this.addr_window.cursor.y + 32;
		local w = 32;
		local s = 20;
		local r = this.resource.num;

		for( local i = 0; i < 12 + 5; i = ++i )
		{
			if (i == 3 || i == 6 || i == 9)
			{
				this.addr_window.window.Blit(x, y, 32, 32, r, 11 * w, 0, this.BLEND_ALPHA, 1,00000000.0);
				x = x + s;
			}

			if (i == 12)
			{
				this.addr_window.window.Blit(x, y, 32, 32, r, 10 * w, 0, this.BLEND_ALPHA, 1,00000000.0);
				x = x + s;
			}

			local offset = this.action.target_addr_v[i].val * w + (this.action.target_addr_h.val == i ? 0 : 512);
			this.addr_window.window.Blit(x, y, 32, 32, this.resource.num, offset, 0, this.BLEND_ALPHA, 1,00000000.0);
			x = x + s;
		}
	}

	if (this.port_window.visible)
	{
		local x = this.port_cursor_x + 2;
		local y = this.port_window.cursor.y + 32;
		local w = 32;
		local s = 20;
		local r = this.resource.num;

		for( local i = 0; i < 5; i = ++i )
		{
			local offset = this.action.server_port_v[i].val * w + (this.action.server_port_h.val == i ? 0 : 512);
			this.port_window.window.Blit(x, y, 32, 32, this.resource.num, offset, 0, this.BLEND_ALPHA, 1,00000000.0);
			x = x + s;
		}
	}
}

