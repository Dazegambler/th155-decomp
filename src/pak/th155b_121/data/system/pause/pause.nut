this.state <- 0;
this.item <- [
	"exit"
];
this.cursor_item <- null;
this.proc <- clone ::menu.common.proc;
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"return",
	null,
	"UD",
	"select"
];
this.Update <- null;
this.anime <- {};
::manbow.CompileFile("data/system/pause/pause_animation.nut", this.anime);
function Initialize( _mode )
{
	::menu.common.Initialize.call(this);
	this.proc = clone ::menu.common.proc;

	switch(_mode)
	{
	case 3:
		this.item = [
			"exit",
			null,
			"ret_replay_select",
			"ret_title",
			"hide"
		];
		break;

	case 2:
		this.item = [
			"exit",
			null,
			"ret_story_select",
			"ret_title",
			"hide",
			"config"
		];
		this.proc.ret_story_select = function ()
		{
			::replay.Confirm(::menu.common.proc.ret_story_select.bindenv(this));
		};
		this.proc.ret_title = function ()
		{
			::replay.Confirm(::menu.common.proc.ret_title.bindenv(this));
		};
		break;

	default:
		this.item = [
			"exit",
			null,
			"ret_select",
			"ret_title",
			"hide",
			"config"
		];
		this.proc.ret_select = function ()
		{
			::replay.Confirm(::menu.common.proc.ret_select.bindenv(this));
		};
		this.proc.ret_title = function ()
		{
			::replay.Confirm(::menu.common.proc.ret_title.bindenv(this));
		};
		break;
	}

	this.cursor_item = ::menu.common.CreateCursor(this.item);
	this.Update = this.UpdateMain;
	this.BeginAnime();
}

function Terminate()
{
	::input.ClearDeviceAssign(::battle.team[0].input);
	::input.ClearDeviceAssign(::battle.team[1].input);
	::input.SetDeviceAssign(0, ::battle.team[0].device_id, ::battle.team[0].input);
	::input.SetDeviceAssign(1, ::battle.team[1].device_id, ::battle.team[1].input);
	::menu.common.Terminate.call(this);
	this.EndAnime();
}

this.Suspend <- ::menu.common.Suspend;
this.Resume <- ::menu.common.Resume;
this.UpdateMain <- ::menu.common.Update;
function Show()
{
	::menu.common.Show.call(this);
}

function Hide()
{
	::menu.common.Hide.call(this);
}

