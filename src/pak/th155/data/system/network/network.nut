this.act <- ::libact.LoadAct("data/system/network/network.act");
this.item <- [
	"WAIT_INCOMMING",
	"MATCHING",
	null,
	"SERVER",
	"CLIENT",
	null,
	"PORT",
	"UPNP",
	null,
	"EXIT"
];
this.cursor <- this.Cursor(0, this.item.len(), ::input_all);
local skip = [];

foreach( v in this.item )
{
	skip.push(v ? 0 : 1);
}

this.cursor.SetSkip(skip);
this.update <- null;
this.state <- 0;
this.plugin <- {};
this.plugin.se_lobby <- ::libact.LoadPlugin("data/plugin/se_lobby.dll");
this.plugin.se_upnp <- ::libact.LoadPlugin("data/plugin/se_upnp.dll");
this.plugin.se_infomation <- ::libact.LoadPlugin("data/plugin/se_information.dll");
this.target_addr_v <- [];

for( local i = 0; i < 12 + 5; i = ++i )
{
	local c = this.Cursor(0, 10, ::input_all);
	c.dir = -1;
	c.enable_ok = false;
	c.enable_cancel = false;
	this.target_addr_v.push(c);
}

this.target_addr_h <- this.Cursor(1, 12 + 5, ::input_all);
this.server_port_v <- [];

for( local i = 0; i < 5; i = ++i )
{
	local c = this.Cursor(0, 10, ::input_all);
	c.dir = -1;
	c.enable_ok = false;
	c.enable_cancel = false;
	this.server_port_v.push(c);
}

this.server_port_h <- this.Cursor(1, 5, ::input_all);
this.cursor_upnp <- this.Cursor(1, 2, ::input_all);
this.cursor_upnp.enable_ok = false;
this.cursor_upnp.enable_cancel = false;
this.timeout <- 0;
this.retry_count <- 0;
this.lobby_user_state <- 0;
this.lobby_interval <- 10 * 1000;
this.lobby_time_stamp <- ::manbow.timeGetTime() - this.lobby_interval + 1000;
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"return",
	null,
	"UD",
	"select",
	null,
	"LR",
	"change"
];
this.help_cancel <- [
	"B2",
	"cancel"
];
this.help_port <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"UD",
	"val",
	null,
	"LR",
	"digit"
];
this.help_addr <- [
	"B1",
	"ok",
	"B2",
	"cancel",
	"B3",
	"clipboard",
	"UD",
	"val",
	"LR",
	"digit"
];
function Initialize()
{
	::menu.cursor.Activate();
	::menu.back.Activate();
	this.update = this.UpdateMain;
	this.state = 0;
	this.timeout = 0;
	this.cursor.val = 0;
	::LOBBY.SetPrefix(::network.lobby_prefix);
	::LOBBY.SetExternalPort(::config.network.hosting_port);
	::LOBBY.SetVersionSig(::network.lobby_version_sig);
	::LOBBY.SetStrikeFactor(1, 1000);
	::config.network.lobby_name = ::network.lobby_name;
	this.SetHostingPortToCursor(::config.network.hosting_port);
	this.SetTargetHostToCursor(::config.network.target_host);
	this.SetTargetPortToCursor(::config.network.target_port);
	this.cursor_upnp.val = ::config.network.upnp ? 0 : 1;
	this.BeginAct();
	::loop.Begin(this);
}

function Terminate()
{
	this.state = -1;
	::menu.help.Reset();
	::menu.back.Deactivate();
	::menu.cursor.Deactivate();
	this.EndActDelayed();
	this.update = null;
	this.LobbyTerminate();
	::network.Terminate();
}

function Suspend()
{
	::menu.title.Hide();
	::menu.help.Reset();
	::menu.cursor.Deactivate();
	::menu.back.Deactivate(true);
	this.EndAct();
}

function Resume()
{
	::sound.PlayBGM(::savedata.GetTitleBGMID());
	::menu.title.Show();
	::network.Terminate();
	this.update = this.UpdateMain;
	this.timeout = 0;
	::menu.cursor.Activate();
	::menu.back.Activate();
	this.BeginAct();
}

function Update()
{
	if (::input_all.b10 == 1)
	{
		::sound.PlaySE("sys_cancel");
		::loop.End();
		return;
	}

	this.LobbyUpdate();

	if (this.update)
	{
		this.update();
	}
}

function UpdateMain()
{
	::menu.help.Set(this.help);
	this.cursor.Update();

	if (::input_all.b0 == 1)
	{
		::input_all.Lock();
		::network.local_device_id = ::input_all.GetLastDevice();

		switch(this.cursor.val)
		{
		case 0:
			if (::LOBBY.GetNetworkState() == 2)
			{
				::LOBBY.SetExternalPort(::config.network.hosting_port);
				::LOBBY.SetUserData("" + ::config.network.hosting_port);

				if (!::config.network.upnp)
				{
					::LOBBY.SetLobbyUserState(::LOBBY.WAIT_INCOMMING);
				}

				this.lobby_user_state = ::LOBBY.WAIT_INCOMMING;
				::network.use_lobby = true;
				::network.StartupServer(::config.network.hosting_port);
				this.update = this.UpdateMatch;
			}

			break;

		case 1:
			if (::LOBBY.GetNetworkState() == 2)
			{
				::LOBBY.SetExternalPort(::config.network.hosting_port);
				::LOBBY.SetUserData("" + ::config.network.hosting_port);
				::LOBBY.SetLobbyUserState(::LOBBY.MATCHING);
				this.lobby_user_state = ::LOBBY.MATCHING;
				this.update = this.UpdateMatch;
			}

			break;

		case 3:
			::network.use_lobby = false;
			::network.StartupServer(::config.network.hosting_port);
			this.update = this.UpdateWaitServer;
			break;

		case 4:
			this.target_addr_h.val = 0;
			this.update = this.UpdateInputAddr;
			break;

		case 6:
			this.SetHostingPortToCursor(::config.network.hosting_port);
			this.server_port_h.val = 0;
			this.update = this.UpdateInputPort;
			break;

		case 9:
			::loop.End();
			break;
		}
	}
	else if (::input_all.b1 == 1)
	{
		::loop.End();
	}
	else if (this.cursor.val == 7)
	{
		this.cursor_upnp.Update();

		if (this.cursor_upnp.diff)
		{
			::config.network.upnp = this.cursor_upnp.val == 0 ? true : false;
			::config.Save();
		}
	}
	else
	{
	}
}

function UpdateInputPort()
{
	::menu.help.Set(this.help_port);
	this.server_port_h.Update();
	this.server_port_v[this.server_port_h.val].Update();

	if (::input_all.b0 == 1)
	{
		local port = 0;

		for( local i = 0; i < 5; i = ++i )
		{
			port = port * 10;
			port = port + this.server_port_v[i].val;
		}

		::config.network.hosting_port = port;
		::config.Save();
		this.update = this.UpdateMain;
	}
	else if (::input_all.b1 == 1)
	{
		this.update = this.UpdateMain;
	}
}

function UpdateWaitServer()
{
	::menu.help.Set(this.help_cancel);

	if (::input_all.b1 == 1)
	{
		::network.Terminate();
		this.update = this.UpdateMain;
	}
}

function UpdateInputAddr()
{
	::menu.help.Set(this.help_addr);
	this.target_addr_h.Update();
	this.target_addr_v[this.target_addr_h.val].Update();

	if (::input_all.b0 == 1)
	{
		local addr = "";
		local t = 0;

		for( local i = 0; i < 12; i = ++i )
		{
			if (i == 3 || i == 6 || i == 9)
			{
				addr = addr + t;
				addr = addr + ".";
				t = 0;
			}

			t = t * 10;
			t = t + this.target_addr_v[i].val;
		}

		addr = addr + t;
		local port = 0;

		for( local i = 12; i < 12 + 5; i = ++i )
		{
			port = port * 10;
			port = port + this.target_addr_v[i].val;
		}

		::network.StartupClient(addr, port);
		this.update = this.UpdateWaitClient;
		::config.network.target_host = addr;
		::config.network.target_port = port;
		::config.Save();
	}
	else if (::input_all.b1 == 1)
	{
		::network.Terminate();
		this.update = this.UpdateMain;
	}

	if (::input_all.b2 == 1)
	{
		local ret = this.GetIPAddress(::manbow.GetClipboardString());

		if (ret != "")
		{
			this.SetTargetHostToCursor(this.GetHostName(ret));
			this.SetTargetPortToCursor(this.GetHostPort(ret).tointeger());
		}
	}
}

function UpdateWaitClient()
{
	::menu.help.Set(this.help_cancel);

	if (::input_all.b1 == 1)
	{
		::network.Terminate();
		this.update = this.UpdateInputAddr;
	}
}

function UpdateMatch()
{
	::menu.help.Set(this.help_cancel);

	if (::input_all.b1 == 1)
	{
		::LOBBY.SetLobbyUserState(::LOBBY.NO_OPERATION);
		::network.Terminate();
		this.update = this.UpdateMain;
		return;
	}

	if (::config.network.upnp)
	{
		if (::LOBBY.GetLobbyUserState() == ::LOBBY.NO_OPERATION)
		{
			if (::UPnP.GetAsyncState() == 2)
			{
				if (::UPnP.GetExternalIP() != "")
				{
					::LOBBY.SetLobbyUserState(::LOBBY.WAIT_INCOMMING);
				}
				else
				{
					::LOBBY.SetLobbyUserState(::LOBBY.WAIT_INCOMMING);
				}
			}
		}
	}

	if (::LOBBY.GetLobbyUserState() == 102)
	{
		if (this.timeout++ > 360)
		{
			if (this.retry_count++ > 5)
			{
				this.lobby_user_state = ::LOBBY.MATCHING;
			}

			::LOBBY.SetLobbyUserState(this.lobby_user_state);
			this.timeout = 0;
			return;
		}
	}
	else
	{
		this.timeout = 0;
	}

	local st_host = ::LOBBY.GetMatchHost();
	local st_userdata = ::LOBBY.GetMatchUserData();

	if (st_host != "")
	{
		::LOBBY.SetLobbyUserState(::LOBBY.NO_OPERATION);
		::network.Terminate();
		::network.StartupClient(this.GetHostName(st_host), st_userdata.tointeger());
		this.update = this.UpdateMatchWait;
		return;
	}
}

function UpdateMatchWait()
{
	::menu.help.Set(this.help_cancel);

	if (::input_all.b1 == 1)
	{
		::LOBBY.SetLobbyUserState(::LOBBY.NO_OPERATION);
		::network.Terminate();
		this.update = this.UpdateMain;
		return;
	}

	if (this.timeout++ > 360)
	{
		::LOBBY.SetLobbyUserState(this.lobby_user_state);
		::network.Terminate();
		this.timeout = 0;

		if (this.lobby_user_state == ::LOBBY.WAIT_INCOMMING)
		{
			::network.StartupServer(::config.network.hosting_port);
		}

		this.update = this.UpdateMatch;
		return;
	}
}

function LobbyUpdate()
{
	local now = ::manbow.timeGetTime();

	if (now - this.lobby_time_stamp < this.lobby_interval)
	{
		return;
	}

	this.lobby_time_stamp = now;

	if (::config.network.lobby_name != "")
	{
		if (::LOBBY.GetNetworkState() == ::LOBBY.CLOSED)
		{
			local lobby_server = "202.216.14.165";
			local lobby_port = "49955";
			local lobby_pass = "kzxmckfqbpqieh8rw<rczuturKfnsjxhauhybttboiuuzmWdmnt5mnlczpythaxf";
			::LOBBY.Connect(lobby_server, "" + lobby_port, lobby_pass, ::config.network.lobby_name, ::config.network.lobby_name);
		}
	}
	else if (::LOBBY.GetNetworkState() != ::LOBBY.CLOSED)
	{
		::LOBBY.Close();
	}
}

function LobbyTerminate()
{
	if (::LOBBY.GetNetworkState() != ::LOBBY.CLOSED)
	{
		::LOBBY.Close();
	}
}

function SetTargetHostToCursor( t )
{
	for( local i = 0; i < 4; i = ++i )
	{
		local val = 0;
		local d = t.find(".");

		if (d)
		{
			val = t.slice(0, d).tointeger();
			t = t.slice(d + 1);
		}
		else
		{
			val = t.tointeger();
		}

		this.target_addr_v[i * 3 + 2].val = val % 10;
		val = val / 10;
		this.target_addr_v[i * 3 + 1].val = val % 10;
		val = val / 10;
		this.target_addr_v[i * 3].val = val;
	}
}

function SetHostingPortToCursor( t )
{
	local t = ::config.network.hosting_port;

	for( local i = 4; i >= 0; i = --i )
	{
		this.server_port_v[i].val = t % 10;
		t = t / 10;
	}
}

function SetTargetPortToCursor( t )
{
	for( local i = 4; i >= 0; i = --i )
	{
		this.target_addr_v[12 + i].val = t % 10;
		t = t / 10;
	}
}

function GetHostName( _str )
{
	local delimit_pos = _str.find(":");

	if (delimit_pos != null)
	{
		return _str.slice(0, delimit_pos);
	}

	return _str;
}

function GetHostPort( _str )
{
	local delimit_pos = _str.find(":");

	if (delimit_pos != null)
	{
		return _str.slice(delimit_pos + 1);
	}

	return null;
}

function GetIPAddress( text )
{
	local ex = this.regexp("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}:\\d{1,5}");
	local ret = ex.search(text);

	if (ret == null)
	{
		return "";
	}

	return text.slice(ret.begin, ret.end);
}

