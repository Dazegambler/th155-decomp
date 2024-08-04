this.state <- 0;
this.title <- "title_practice";
this.item_list <- [
	[
		"exit",
		null,
		"reset",
		"position",
		"life",
		"mp",
		"op",
		"sp",
		null,
		null,
		null,
		"ret_select",
		"ret_title",
		"hide",
		"config"
	],
	[
		"exit",
		null,
		"reset",
		"position",
		"life",
		"mp",
		"op",
		"sp",
		null,
		null,
		null,
		"ret_select",
		"ret_title",
		"hide",
		"config"
	],
	[
		"exit",
		null,
		"reset",
		"player2",
		"difficulty",
		"counter_mode",
		"guard_mode",
		"ex_guard_mode",
		"recover_mode",
		"slave_2p",
		null,
		"ret_select",
		"ret_title",
		"hide",
		"config"
	],
	[
		"exit",
		null,
		"macro_index",
		"macro_play",
		"macro_record",
		null,
		"ret_select",
		"ret_title",
		"hide",
		"config"
	]
];
this.item <- this.item_list[0];
this.cursor_item_list <- [
	::menu.common.CreateCursor(this.item_list[0]),
	::menu.common.CreateCursor(this.item_list[1]),
	::menu.common.CreateCursor(this.item_list[2]),
	::menu.common.CreateCursor(this.item_list[3])
];
this.cursor_item <- this.cursor_item_list[0];
this.cursor_page <- this.Cursor(1, this.item_list.len(), ::input_all);
this.page <- [
	{},
	{},
	{},
	{}
];
local _player_item = [
	"position",
	"life",
	"regain",
	"mp",
	"sp",
	"op",
	"guard",
	"marisa",
	"hijiri",
	"futo",
	"miko",
	"mamizou",
	"kokoro",
	"udonge",
	"doremy"
];

for( local i = 0; i < 2; i = ++i )
{
	local cursor = {};

	foreach( v in _player_item )
	{
		cursor[v] <- this.Cursor(1, ::practice[v].len(), ::input_all);
	}

	foreach( v in cursor )
	{
		v.loop = false;
	}

	this.page[i].cursor <- cursor;
}

local cursor = {};
cursor.player2 <- this.Cursor(1, 5, ::input_all);
cursor.difficulty <- this.Cursor(1, 4, ::input_all);
cursor.counter_mode <- this.Cursor(1, 3, ::input_all);
cursor.guard_mode <- this.Cursor(1, 4, ::input_all);
cursor.ex_guard_mode <- this.Cursor(1, 2, ::input_all);
cursor.recover_mode <- this.Cursor(1, 7, ::input_all);
cursor.slave_2p <- this.Cursor(1, 3, ::input_all);
this.page[2].cursor <- cursor;
local cursor = {};
cursor.macro_index <- this.Cursor(1, 9, ::input_all);
this.page[3].cursor <- cursor;
this.proc <- clone ::menu.common.proc;
this.help_list <- [
	[
		"B1",
		"ok",
		null,
		"B2",
		"return",
		null,
		"B3",
		"reset",
		null,
		"UD",
		"select",
		null,
		"LR",
		"page"
	],
	[
		"B1",
		"ok",
		null,
		"B2",
		"cancel",
		null,
		"LR",
		"change"
	],
	[
		"B1",
		"ok",
		null,
		"B2",
		"cancel",
		null,
		"LR",
		"set_life"
	],
	[
		"B1",
		"ok",
		null,
		"B2",
		"cancel",
		null,
		"LR",
		"set_regain"
	]
];
this.help <- this.help_list[0];
this.Update <- null;
this.cur_cursor <- null;
this.cur_target <- "";
this.cur_page <- 0;
this.anime <- {};
::manbow.CompileFile("data/system/practice/practice_animation.nut", this.anime);
function Initialize()
{
	for( local i = 0; i < 2; i = ++i )
	{
		this.item_list[i][8] = ::battle.team[i].master_name in ::practice ? ::battle.team[i].master_name : null;
		this.item_list[i][9] = ::battle.team[i].slave_name in ::practice ? ::battle.team[i].slave_name : null;
		local skip = [];

		foreach( v in this.item_list[i] )
		{
			skip.append(v ? 0 : 1);
		}

		this.cursor_item_list[i].SetSkip(skip);
	}

	::menu.common.Initialize.call(this);
	this.Update = this.UpdateMain;
	this.cursor_page.Reset();
	this.cursor_item.Reset();

	foreach( v in this.cursor_item_list )
	{
		v.val = 0;
		v.Reset();
	}

	local param = ::config.practice;

	foreach( page_index, v in this.page )
	{
		foreach( key, cursor in v.cursor )
		{
			if (!(key in param))
			{
				continue;
			}

			if (typeof param[key] == "array")
			{
				cursor.val = param[key][page_index];
			}
			else
			{
				cursor.val = param[key];
			}
		}
	}

	if (::battle.macro_state)
	{
		::battle.StopMacro();
	}

	this.BeginAnime();
}

function Terminate()
{
	::config.Save();

	if (::battle.macro_state)
	{
		::battle.Apply();
		::battle.PracticeRestart();
	}
	else
	{
		::input.ClearDeviceAssign(::battle.team[0].input);
		::input.ClearDeviceAssign(::battle.team[1].input);
		::input.SetDeviceAssign(0, ::battle.team[0].device_id, ::battle.team[0].input);
		::input.SetDeviceAssignPractice2P(::battle.team[1].device_id, ::battle.team[1].input);
		::battle.Apply();
	}

	::menu.common.Terminate.call(this);
	this.EndAnime();
}

this.Suspend <- ::menu.common.Suspend;
this.Resume <- ::menu.common.Resume;
function UpdateMain()
{
	if (::input_all.b2 == 1)
	{
		this.proc.reset.call(this);
		::input_all.Lock();
		return;
	}

	this.cursor_page.Update();

	if (this.cursor_page.diff)
	{
		local prev = this.cursor_item.val;
		this.item = this.item_list[this.cursor_page.val];
		this.cursor_item = this.cursor_item_list[this.cursor_page.val];

		if (this.cursor_item.item_num <= prev)
		{
			this.cursor_item.val = this.cursor_item.item_num - 1;
		}
		else
		{
			this.cursor_item.val = prev;
		}

		if (this.cursor_item.skip && this.cursor_item.skip[this.cursor_item.val])
		{
			this.cursor_item.val--;
		}
	}

	::menu.common.Update.call(this);
}

function Show()
{
	::menu.common.Show.call(this);
}

function Hide()
{
	::menu.common.Hide.call(this);
}

function CommonProc()
{
	::menu.help.Set(this.help_list[1]);
	this.cur_cursor.Update();

	if (this.cur_cursor.ok)
	{
		if (typeof ::config.practice[this.cur_target] == "array")
		{
			::config.practice[this.cur_target][this.cur_page] = this.cur_cursor.val;
		}
		else
		{
			::config.practice[this.cur_target] = this.cur_cursor.val;
		}

		this.Update = this.UpdateMain;
		return;
	}

	if (this.cur_cursor.cancel)
	{
		if (typeof ::config.practice[this.cur_target] == "array")
		{
			this.cur_cursor.val = ::config.practice[this.cur_target][this.cur_page];
		}
		else
		{
			this.cur_cursor.val = ::config.practice[this.cur_target];
		}

		this.Update = this.UpdateMain;
		return;
	}
}

function SetCommonProc( _target, _page )
{
	this.cur_target = _target;
	this.cur_page = _page;
	this.cur_cursor = this.page[_page].cursor[_target];

	if (typeof ::config.practice[this.cur_target] == "array")
	{
		this.cur_cursor.val = ::config.practice[this.cur_target][this.cur_page];
	}
	else
	{
		this.cur_cursor.val = ::config.practice[this.cur_target];
	}

	this.Update = this.CommonProc;
}

function LifeProc()
{
	::menu.help.Set(this.help_list[2]);
	this.cur_cursor.Update();
	this.page[this.cur_page].cursor.regain.val = this.cur_cursor.val;

	if (this.cur_cursor.ok)
	{
		if (this.cur_cursor.val == 0)
		{
			::config.practice.life[this.cur_page] = 0;
			::config.practice.regain[this.cur_page] = 0;
			this.Update = this.UpdateMain;
			return;
		}

		this.cur_target = "regain";
		this.cur_page = this.cursor_page.val;
		this.cur_cursor = this.page[this.cur_page].cursor[this.cur_target];
		this.Update = this.RegainProc;
		return;
	}

	if (this.cur_cursor.cancel)
	{
		this.cur_cursor.val = ::config.practice[this.cur_target][this.cur_page];
		this.page[this.cur_page].cursor.regain.val = ::config.practice.regain[this.cur_page];
		this.Update = this.UpdateMain;
		return;
	}
}

function RegainProc()
{
	::menu.help.Set(this.help_list[3]);
	this.cur_cursor.Update();

	if (this.cur_cursor.val < this.page[this.cur_page].cursor.life.val)
	{
		this.cur_cursor.val = this.page[this.cur_page].cursor.life.val;
	}

	if (this.cur_cursor.ok)
	{
		::config.practice.life[this.cur_page] = this.page[this.cur_page].cursor.life.val;
		::config.practice[this.cur_target][this.cur_page] = this.cur_cursor.val;
		this.Update = this.UpdateMain;
		return;
	}

	if (this.cur_cursor.cancel)
	{
		this.cur_target = "life";
		this.cur_page = this.cursor_page.val;
		this.cur_cursor = this.page[this.cur_page].cursor[this.cur_target];
		this.Update = this.LifeProc;
		return;
	}
}

this.proc.reset <- function ()
{
	::battle.PracticeRestart();
	::loop.End();
};
this.proc.position <- function ()
{
	this.SetCommonProc("position", this.cursor_page.val);
};
this.proc.life <- function ()
{
	this.cur_target = "life";
	this.cur_page = this.cursor_page.val;
	this.cur_cursor = this.page[this.cur_page].cursor[this.cur_target];
	this.cur_cursor.val = ::config.practice[this.cur_target][this.cur_page];
	this.Update = this.LifeProc;
};
this.proc.sp <- function ()
{
	this.SetCommonProc("sp", this.cursor_page.val);
};
this.proc.mp <- function ()
{
	this.SetCommonProc("mp", this.cursor_page.val);
};
this.proc.op <- function ()
{
	this.SetCommonProc("op", this.cursor_page.val);
};
this.proc.guard <- function ()
{
	this.SetCommonProc("guard", this.cursor_page.val);
};
this.proc.marisa <- function ()
{
	this.SetCommonProc("marisa", this.cursor_page.val);
};
this.proc.hijiri <- function ()
{
	this.SetCommonProc("hijiri", this.cursor_page.val);
};
this.proc.futo <- function ()
{
	this.SetCommonProc("futo", this.cursor_page.val);
};
this.proc.miko <- function ()
{
	this.SetCommonProc("miko", this.cursor_page.val);
};
this.proc.mamizou <- function ()
{
	this.SetCommonProc("mamizou", this.cursor_page.val);
};
this.proc.kokoro <- function ()
{
	this.SetCommonProc("kokoro", this.cursor_page.val);
};
this.proc.udonge <- function ()
{
	this.SetCommonProc("udonge", this.cursor_page.val);
};
this.proc.doremy <- function ()
{
	this.SetCommonProc("doremy", this.cursor_page.val);
};
this.proc.player2 <- function ()
{
	this.SetCommonProc("player2", 2);
};
this.proc.difficulty <- function ()
{
	this.SetCommonProc("difficulty", 2);
};
this.proc.counter_mode <- function ()
{
	this.SetCommonProc("counter_mode", 2);
};
this.proc.guard_mode <- function ()
{
	this.SetCommonProc("guard_mode", 2);
};
this.proc.ex_guard_mode <- function ()
{
	this.SetCommonProc("ex_guard_mode", 2);
};
this.proc.recover_mode <- function ()
{
	this.SetCommonProc("recover_mode", 2);
};
this.proc.slave_2p <- function ()
{
	this.SetCommonProc("slave_2p", 2);
};
this.proc.macro_index <- function ()
{
	this.SetCommonProc("macro_index", 3);
};
this.proc.macro_play <- function ()
{
	if (::battle.PlayMacro(::battle.team[1].master_name, ::battle.team[1].slave_name, this.page[3].cursor.macro_index.val))
	{
		::loop.End();
	}
};
this.proc.macro_record <- function ()
{
	::battle.RecordMacro(::battle.team[1].master_name, ::battle.team[1].slave_name, this.page[3].cursor.macro_index.val);
	::loop.End();
};
