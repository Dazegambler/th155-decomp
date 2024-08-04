this.game_mode <- 0;
this.difficulty <- 0;
this.device <- [
	null,
	null
];
this.device_current <- [
	null,
	null
];
this.device_id <- [
	-128,
	-128
];
this.count <- 0;
this.end_wait <- 0;
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"UDLR",
	"select"
];
this.help_stage <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"UD",
	"select"
];
this.help_stage2 <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"LR",
	"B3",
	"change_stage",
	null,
	"UD",
	"select"
];
this.help_bgm <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"LR",
	"B3",
	"page",
	null,
	"UD",
	"select"
];
this.help_network <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	"disconnect",
	null,
	"UDLR",
	"select"
];
this.t <- [
	{},
	{}
];

foreach( v in this.t )
{
	v.cursor_master <- this.Cursor(0, this.character_name.len());
	v.cursor_slave <- this.Cursor(0, this.character_name.len());
	v.cursor_spell <- this.Cursor(2, 3);
	v.cursor_color_master <- this.Cursor(0, 8);
	v.cursor_color_slave <- this.Cursor(0, 8);
	v.cursor_center <- this.Cursor2(3, 7);
	v.cursor_center.SetSkip(this.character_map);
	v.cursor_center.enable_cancel = false;
	v.cursor_center.se_ok = 0;
	v.cursor_center_slave <- this.Cursor2(3, 7);
	v.cursor_center_slave.SetSkip(this.character_map);
	v.cursor_center_slave.se_ok = 0;
	v.device <- null;
	v.device_id <- -2;
	v.state <- 0;
	v.input <- null;
	v.setdelegate(this);
}

this.character_map_current <- null;
this.hide_character <- true;
this.stage_base <- [
	99,
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18
];
this.stage <- [];
this.stage_index <- [];
this.prev_stage <- -1;
this.cursor_stage <- null;
this.device_stage <- null;
this.stage_table <- [
	[
		1,
		16,
		17,
		31
	],
	[
		2
	],
	[
		3,
		19
	],
	[
		4,
		20
	],
	[
		6,
		21
	],
	[
		5,
		22
	],
	[
		7,
		23
	],
	[
		8,
		24
	],
	[
		9,
		10
	],
	[
		11,
		15
	],
	[
		44
	],
	[
		26
	],
	[
		12,
		25
	],
	[
		28
	],
	[
		30
	],
	[
		40
	],
	[
		41
	],
	[
		27
	],
	[
		43,
		42
	]
];
this.stage_default <- [
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	false,
	true,
	true,
	true,
	true,
	false,
	false,
	false,
	false
];
this.bgm_base <- [
	[
		99,
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108,
		109,
		110,
		113,
		111,
		112,
		114,
		115,
		116,
		117,
		118,
		319
	],
	[
		99,
		301,
		302,
		303,
		304,
		305,
		306,
		307,
		308,
		309,
		310,
		313,
		311,
		312,
		314,
		315,
		316,
		317,
		318,
		319,
		351,
		352,
		353,
		354
	]
];
this.cursor_bgm <- null;
this.bgm_page <- 0;
this.bgm_wait <- 0;
this.bgm_prev <- 0;
this.bgm <- [
	[],
	[]
];
this.handle_name <- {};
::manbow.LoadCSVtoTable("data/system/select/name/handle_name.csv", this.handle_name);
this.Update <- null;
function Initialize( _game_mode, _difficulty = 0 )
{
	this.game_mode = _game_mode;
	this.difficulty = _difficulty;
	this.device = [
		null,
		null
	];
	this.device_current = [
		null,
		null
	];
	this.device_id = [
		-128,
		-128
	];
	this.prev_stage = -1;
	this.bgm_page = 0;
	this.end_wait = 0;
	this.count = 0;

	if (::network.IsActive())
	{
		::network.input_local = ::input.CreateSystemInputDevice(::network.local_device_id);
		::network.inst.BeginSyncInput(::network.input_local, 2, false);
		this.device[0] = ::network.inst.device[0];
		this.device[1] = ::network.inst.device[1];
		this.character_map_current = this.character_map;
		this.stage = clone this.stage_base;
		this.bgm[0] = clone this.bgm_base[0];
		this.bgm[1] = clone this.bgm_base[1];
		this.hide_character = false;
	}
	else
	{
		this.character_map_current = this.GetCharacterSelectMap();
		this.hide_character = this.character_map_current[6][1] == null;
		this.stage = [];
		this.bgm[0] = [];
		this.bgm[1] = [];

		foreach( i, v in this.stage_base )
		{
			if (v == 99)
			{
				this.stage.push(99);
				this.bgm[0].push(99);
				this.bgm[1].push(99);
			}
			else if (this.stage_default[v] || this.stage_table[v][0] in ::savedata.stage)
			{
				this.stage.push(this.stage_base[i]);
				this.bgm[0].push(this.bgm_base[0][i]);
				this.bgm[1].push(this.bgm_base[1][i]);
			}
		}

		this.bgm[1].extend(this.bgm_base[1].slice(this.bgm_base[0].len()));
	}

	this.t[0].cursor_center.x = 0;
	this.t[0].cursor_center.y = 0;
	this.t[1].cursor_center.x = 2;
	this.t[1].cursor_center.y = 0;
	this.t[0].cursor_center_slave.x = 2;
	this.t[0].cursor_center_slave.y = 0;
	this.t[1].cursor_center_slave.x = 0;
	this.t[1].cursor_center_slave.y = 0;

	foreach( v in this.t )
	{
		v.state = this.SelectMaster;
		v.cursor_spell.val = 0;
		v.cursor_color_master.val = 0;
		v.cursor_color_slave.val = 0;
		v.cursor_center.Reset();
		v.cursor_center_slave.Reset();
		v.cursor_center.SetSkip(this.character_map_current);
		v.cursor_center_slave.SetSkip(this.character_map_current);
		v.cursor_master.Reset();
		v.cursor_spell.Reset();
		v.cursor_slave.Reset();
		v.cursor_color_master.Reset();
		v.cursor_color_slave.Reset();
		local name = this.character_map_current[v.cursor_center.y][v.cursor_center.x];

		if (name in this.character_id)
		{
			v.cursor_master.val = this.character_id[name];
		}

		name = this.character_map_current[v.cursor_center_slave.y][v.cursor_center_slave.x];

		if (name in this.character_id)
		{
			v.cursor_slave.val = this.character_id[name];
		}
	}

	this.device_stage = ::manbow.InputMulti();

	if (this.device[0])
	{
		this.device_stage.Append(this.device[0]);
	}

	if (this.device[1])
	{
		this.device_stage.Append(this.device[1]);
	}

	this.stage_index.resize(this.stage_table.len(), 0);
	this.cursor_stage = this.Cursor(0, this.stage.len(), this.device_stage);
	this.cursor_bgm = this.Cursor(0, this.bgm[this.bgm_page].len(), this.device_stage);
	this.Update = this.UpdateCharacterSelect;
	this.anime <- {};
	this.anime.action <- this.weakref();
	::manbow.CompileFile("data/system/select/script/character_select_animation.nut", this.anime);
	this.anime.Initialize();
	::loop.AddTask(this.anime);
	::loop.Begin(this);
}

function Terminate()
{
	if (::network.inst)
	{
	}

	::menu.help.Reset();
	::effect.Clear();

	if (this.anime)
	{
		::loop.DeleteTask(this.anime);
	}

	this.anime = null;
}

function Resume()
{
	if (this.anime)
	{
		return;
	}

	if (::network.IsActive())
	{
		::network.input_local = ::input.CreateSystemInputDevice(::network.local_device_id);
		::network.inst.BeginSyncInput(::network.input_local, 2, false);
		this.device[0] = ::network.inst.device[0];
		this.device[1] = ::network.inst.device[1];
		this.device_stage.Release();
		this.device_stage.Append(this.device[0]);
		this.device_stage.Append(this.device[1]);
	}

	this.end_wait = 0;

	foreach( v in this.t )
	{
		v.state = this.SelectMaster;
		v.cursor_center.Reset();
		v.cursor_center_slave.Reset();
		v.cursor_master.Reset();
		v.cursor_spell.Reset();
		v.cursor_slave.Reset();
	}

	this.cursor_stage.Reset();
	this.cursor_bgm.Reset();
	this.Update = this.UpdateCharacterSelect;
	this.anime <- {};
	this.anime.action <- this.weakref();
	::manbow.CompileFile("data/system/select/script/character_select_animation.nut", this.anime);
	this.anime.Initialize();
	::loop.AddTask(this.anime);
	::sound.PlayBGM(::savedata.GetTitleBGMID());
}

function Suspend()
{
	::menu.help.Reset();
	::effect.Clear();

	if (this.anime)
	{
		::loop.DeleteTask(this.anime);
	}

	this.anime = null;
}

function UpdateCharacterSelect()
{
	this.menu.help.Set(::network.inst ? this.help_network : this.help);
	this.UpdateInput();

	if (this.t[0].state == this.SelectEnd && this.t[1].state == this.SelectEnd)
	{
		this.Update = this.UpdateStageSelect;
		return;
	}
	else
	{
		this.end_wait = 0;
	}

	if (::network.IsActive())
	{
		if (this.device[0].b1 == 120 || this.device[1].b1 == 120)
		{
			::sound.PlaySE("sys_cancel");
			::network.Disconnect();
			return;
		}
	}
	else if (this.t[0].state == this.SelectMaster && this.t[1].state == this.SelectMaster)
	{
		if (this.device[0] && this.device[0].b1 == 1 || this.device[1] && this.device[1].b1 == 1)
		{
			::sound.PlaySE("sys_cancel");
			::loop.EndWithFade();
			return;
		}
	}

	for( local i = 0; i < 2; i = ++i )
	{
		if (this.device_current[i])
		{
			this.t[i].state(this.device_current[i]);
		}
	}

	this.count++;
}

function UpdateStageSelect()
{
	this.device_stage.Update();
	this.cursor_stage.Update();

	if (this.cursor_stage.ok)
	{
		this.Update = this.UpdateBgmSelect;
		this.bgm_wait = 0;

		if (this.prev_stage != this.cursor_stage.val)
		{
			this.cursor_bgm.val = this.cursor_stage.val;
			this.prev_stage = this.cursor_stage.val;
		}

		return;
	}

	if (this.cursor_stage.cancel)
	{
		this.Update = this.UpdateCharacterSelect;
		this.t[1].state = this.SelectColorSlave;

		if (this.device[1])
		{
			this.t[0].state = this.SelectColorSlave;
		}

		return;
	}

	local s = this.stage[this.cursor_stage.val];

	if (this.device_stage.b2 == 1)
	{
		if (s != 99)
		{
			::sound.PlaySE("sys_cursor");
			this.stage_index[s] = (this.stage_index[s] + 1) % this.stage_table[s].len();
		}
	}
	else if (this.abs(this.device_stage.x) == 1 && this.device_stage.y == 0)
	{
		if (s != 99)
		{
			::sound.PlaySE("sys_cursor");
			this.stage_index[s] = (this.stage_index[s] + this.device_stage.x + this.stage_table[s].len()) % this.stage_table[s].len();
		}
	}

	this.menu.help.Set(s != 99 && this.stage_table[s].len() > 1 ? this.help_stage2 : this.help_stage);
}

function UpdateBgmSelect()
{
	this.menu.help.Set(this.help_bgm);
	this.device_stage.Update();
	this.cursor_bgm.Update();

	if (this.cursor_bgm.diff)
	{
		this.bgm_wait = 0;
	}

	if (this.cursor_bgm.ok)
	{
		this.BeginBattle();
		return;
	}

	if (this.cursor_bgm.cancel)
	{
		this.Update = this.UpdateStageSelect;
		::sound.PlayBGM(::savedata.GetTitleBGMID());
		return;
	}

	if (this.device_stage.b2 == 1 || this.abs(this.device_stage.x) == 1 && this.device_stage.y == 0)
	{
		::sound.PlaySE("sys_cursor");
		this.bgm_page = (this.bgm_page + 1) % this.bgm.len();
		local prev = this.cursor_bgm.val;
		this.cursor_bgm.SetItemNum(this.bgm[this.bgm_page].len());

		if (prev >= this.bgm[this.bgm_page].len())
		{
			this.cursor_bgm.val = 0;
		}

		this.cursor_bgm.diff = 1;
		this.bgm_wait = 0;
	}

	if (this.bgm_wait++ == 30)
	{
		if (this.bgm[this.bgm_page][this.cursor_bgm.val] != 99)
		{
			::sound.PlayBGM(this.bgm[this.bgm_page][this.cursor_bgm.val] + 500, true);
		}
		else
		{
			::sound.PlayBGM(::savedata.GetTitleBGMID());
		}

		this.bgm_prev = 0;
	}

	if (this.bgm_wait > 600 && this.bgm_wait % 60 == 0 && ::sound.current_bgm_index != ::savedata.GetTitleBGMID())
	{
		local t = ::sound.GetCurrentBGMPosition();

		if (t == this.bgm_prev)
		{
			local index = ::sound.current_bgm_index;
			this.bgm_wait = 60;
			this.bgm_prev = 0;
			::sound.StopBGM(0);
			::sound.PlayBGM(index, true);
		}

		this.bgm_prev = t;
	}
}

function UpdateInput()
{
	if (this.device[0] == null)
	{
		this.device_id[0] = ::input_all.GetLastDevice();
		this.device[0] = ::input.CreateSystemInputDevice(this.device_id[0]);
		this.device_stage.Append(this.device[0]);
	}
	else if (this.game_mode != 0 && this.device[1] == null)
	{
		local id = ::input_all.GetLastDevice();

		if (this.device_id[0] != id)
		{
			this.device_id[1] = id;
			this.device[1] = ::input.CreateSystemInputDevice(this.device_id[1]);
			this.device_stage.Append(this.device[1]);
		}
	}

	foreach( v in this.device )
	{
		if (v)
		{
			v.Update();
		}
	}

	this.device_current = [
		this.device[0],
		this.device[1]
	];

	if (this.device_current[0] && this.device_current[1] == null)
	{
		if (this.t[0].state == this.SelectEnd)
		{
			this.device_current[0] = this.t[1].state == this.SelectMaster ? this.device[0] : null;
			this.device_current[1] = this.device[0];
		}
		else
		{
			this.t[1].cursor_master.active = false;
		}
	}
}

function SelectMaster( input )
{
	this.cursor_center.input = input;
	this.cursor_center.Update();
	this.SetCursor(this.cursor_center, this.cursor_master);

	if (this.cursor_master.ok)
	{
		::sound.PlaySE("sys_ok");
		this.state = this.SelectColorMaster;
		return;
	}
}

function SelectColorMaster( input )
{
	this.cursor_color_master.input = input;
	this.cursor_color_master.Update();

	if (this.cursor_color_master.ok)
	{
		this.state = this.SelectSpell;
	}
	else if (this.cursor_color_master.cancel)
	{
		this.state = this.SelectMaster;
	}
}

function SelectSpell( input )
{
	this.cursor_spell.input = input;
	this.cursor_spell.Update();

	if (this.cursor_spell.ok)
	{
		this.state = this.SelectSlave;
	}
	else if (this.cursor_spell.cancel)
	{
		this.state = this.SelectColorMaster;
	}
	else if (input.b2 > 7 && input.b2 % 5 == 0)
	{
		::sound.PlaySE("sys_cursor");
		this.cursor_spell.val = (this.cursor_spell.val + 1) % this.cursor_spell.item_num;
		this.cursor_spell.diff = 1;
	}
}

function SelectSlave( input )
{
	this.cursor_center_slave.input = input;
	this.cursor_center_slave.Update();
	this.SetCursor(this.cursor_center_slave, this.cursor_slave, this.cursor_master.val);

	if (this.cursor_slave.ok && this.cursor_slave.val == this.cursor_master.val)
	{
		::sound.PlaySE("sys_invalid");
		this.cursor_center_slave.active = true;
		this.cursor_center_slave.ok = false;
		this.cursor_slave.active = true;
		this.cursor_slave.ok = false;
	}

	if (this.cursor_slave.ok)
	{
		::sound.PlaySE("sys_ok");
		this.state = this.SelectColorSlave;
	}
	else if (this.cursor_slave.cancel)
	{
		this.state = this.SelectSpell;
	}
}

function SelectColorSlave( input )
{
	this.cursor_color_slave.input = input;
	this.cursor_color_slave.Update();

	if (this.cursor_color_slave.ok)
	{
		this.state = this.SelectEnd;
	}
	else if (this.cursor_color_slave.cancel)
	{
		this.state = this.SelectSlave;
	}
}

function SelectEnd( input )
{
	if (input.b1 == 1)
	{
		::sound.PlaySE("sys_cancel");
		this.state = this.SelectColorSlave;
	}
}

function SetCursor( src, dst, exclude = -1 )
{
	local prev = dst.val;
	local name = this.character_map_current[src.y][src.x];

	if (name in this.character_id)
	{
		dst.val = this.character_id[name];
	}
	else
	{
		local prev = dst.val;

		if (this.count % 6 == 0)
		{
			while (dst.val == prev || dst.val == exclude)
			{
				dst.val = this.rand() % this.character_id.len();

				if (this.hide_character)
				{
					if (dst.val == this.character_id[::character_map[6][1]])
					{
						dst.val = prev;
					}
				}
			}
		}
	}

	if (prev != dst.val)
	{
		dst.diff = src.diff_x ? src.diff_x : src.diff_y ? src.diff_y : 1;
	}
	else
	{
		dst.diff = 0;
	}

	dst.ok = src.ok;
	dst.cancel = src.cancel;
	dst.active = dst.ok || dst.cancel ? false : true;

	if (!dst.active)
	{
		dst.diff = 0;
	}
}

function BeginBattle()
{
	local param = this.vs.InitializeParam();
	param.game_mode = this.game_mode;
	param.device_id[0] = this.device_id[0];
	param.device_id[1] = this.device_id[1];

	switch(this.game_mode)
	{
	case 0:
		param.mode[1] = 1;
		param.difficulty = this.difficulty;
		param.device_id[1] = -2;
		break;

	case 40:
		param.mode[1] = 3;
		param.difficulty = this.difficulty;
		param.device_id[1] = this.device_id[0];
		break;

	default:
		if (this.device[1] == null)
		{
			param.device_id[1] = -1;
		}
	}

	foreach( i, v in this.t )
	{
		param.master_name[i] = ::character_name[v.cursor_master.val];
		param.slave_name[i] = ::character_name[v.cursor_slave.val];
		param.spell[i] = v.cursor_spell.val;
		param.master_color[i] = v.cursor_color_master.val;
		param.slave_color[i] = v.cursor_color_slave.val;
	}

	local color_num = this.t[0].cursor_color_master.item_num;

	for( local i = 0; i < color_num; i = ++i )
	{
		if (param.master_name[1] == param.master_name[0] && param.master_color[1] == param.master_color[0])
		{
			param.master_color[1] = (param.master_color[1] + 1) % color_num;
		}
		else if (param.master_name[1] == param.slave_name[0] && param.master_color[1] == param.slave_color[0])
		{
			param.master_color[1] = (param.master_color[1] + 1) % color_num;
		}
		else
		{
			break;
		}
	}

	for( local i = 0; i < color_num; i = ++i )
	{
		if (param.slave_name[1] == param.master_name[0] && param.slave_color[1] == param.master_color[0])
		{
			param.slave_color[1] = (param.slave_color[1] + 1) % color_num;
		}
		else if (param.slave_name[1] == param.slave_name[0] && param.slave_color[1] == param.slave_color[0])
		{
			param.slave_color[1] = (param.slave_color[1] + 1) % color_num;
		}
		else
		{
			break;
		}
	}

	local s = this.stage[this.cursor_stage.val];

	if (s == 99)
	{
		local t = [];
		local t2 = [];

		foreach( i, v in this.stage )
		{
			if (v < 99)
			{
				t.extend(this.stage_table[v]);
				local t3 = [];
				t3.resize(this.stage_table[v].len(), this.bgm[this.bgm_page][i]);
				t2.extend(t3);
			}
		}

		local r = this.rand() % t.len();
		param.background_id = t[r];

		if (this.cursor_bgm.val == 0)
		{
			param.bgm_id = t2[r];
		}
		else
		{
			param.bgm_id = this.bgm[this.bgm_page][this.cursor_bgm.val];
		}
	}
	else
	{
		param.background_id = this.stage_table[s][this.stage_index[s]];

		if (this.cursor_bgm.val == 0)
		{
			local t = [];
			t.extend(this.bgm[0].slice(1));
			t.extend(this.bgm[1].slice(1));
			param.bgm_id = t[this.rand() % t.len()];
		}
		else
		{
			param.bgm_id = this.bgm[this.bgm_page][this.cursor_bgm.val];
		}
	}

	param.seed = this.rand();
	::sound.StopBGM(500);

	if (this.device[0])
	{
		this.device[0].Lock();
	}

	if (this.device[1])
	{
		this.device[1].Lock();
	}

	::loop.Fade(function ()
	{
		::menu.character_select.Suspend();
		::vs.Initialize(param);
	});
}

