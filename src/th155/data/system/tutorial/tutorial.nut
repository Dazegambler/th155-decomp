this.act <- ::libact.LoadAct("data/system/tutorial/tutorial.act");
this.item <- [
	"exit",
	null,
	"prev_question",
	"next_question",
	null,
	"ret_title",
	"hide",
	"config"
];
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"LR",
	"select"
];
this.state <- 0;
this.cursor_item <- ::menu.common.CreateCursor(this.item);
this.proc <- clone ::menu.common.proc;
this.Update <- null;
function Initialize()
{
	::sound.PlaySE(111);
	this.Update = this.UpdateMain;
	::menu.help.Set(this.help);
	::menu.common.Initialize.call(this);
	this.BeginAct();
}

function Terminate()
{
	::input.SetDeviceAssign(0, ::battle.team[0].device_id, ::battle.team[0].input);
	::input.SetDeviceAssign(1, ::battle.team[1].device_id, ::battle.team[1].input);
	::menu.common.Terminate.call(this);
	this.EndAct();
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

this.proc.next_question <- function ()
{
};
this.proc.prev_question <- function ()
{
};
