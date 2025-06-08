local replay_task = {};
local help = [];
replay_task.Update <- function ()
{
	::menu.help.Set(help);

	if (::replay.IsFinished())
	{
		::sound.StopBGM(500);
		::loop.EndWithFade();
	}
	else if (::input_all.b1 == 1)
	{
		::sound.PlaySE(111);
		::menu.pause.Initialize(3);
	}
};
this.AddTask(replay_task);
function Pause()
{
}

function BeginResult()
{
	this.End();
}

