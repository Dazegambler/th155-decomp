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
	::menu.common.CreateCursor(this.item_list[2])
];
this.cursor_item <- this.cursor_item_list[0];
this.cursor_page <- this.Cursor(1, this.item_list.len(), ::input_all);
this.page <- [
	{},
	{},
	{}
];
local _cursor;
local _item;
local CreateCursor = function ( _name, _item )
{
};

for( local i = 0; i < 2; i = ++i )
{
	local cursor = {};
	cursor.position <- this.Cursor(1, ::practice.position.len(), ::input_all);
	cursor.life <- this.Cursor(1, ::practice.life.len(), ::input_all);
	cursor.mp <- this.Cursor(1, ::practice.mp.len(), ::input_all);
	cursor.sp <- this.Cursor(1, ::practice.sp.len(), ::input_all);
	cursor.op <- this.Cursor(1, ::practice.op.len(), ::input_all);
	cursor.guard <- this.Cursor(1, ::practice.guard.len(), ::input_all);
	cursor.master <- this.Cursor(1, 11, ::input_all);
	cursor.slave <- this.Cursor(1, 11, ::input_all);

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
cursor.recover_mode <- this.Cursor(1, 4, ::input_all);
this.page[2].cursor <- cursor;
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

	this.BeginAnime();
}

function Terminate()
{
	::config.Save();
	::battle.Apply();
	::input.SetDeviceAssign(0, ::battle.team[0].device_id, ::battle.team[0].input);
	::input.SetDeviceAssignPractice2P(::battle.team[1].device_id, ::battle.team[1].input);
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
	this.SetCommonProc("life", this.cursor_page.val);
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
this.proc.master <- function ()
{
	this.SetCommonProc("master", this.cursor_page.val);
};
this.proc.slave <- function ()
{
	this.SetCommonProc("slave", this.cursor_page.val);
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
