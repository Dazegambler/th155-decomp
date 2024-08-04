local replay_task = {};
replay_task.Update <- function ()
{
	if (::input_all.b1 == 1)
	{
		::sound.PlaySE(111);
		::loop.EndWithFade();
	}
};
this.AddTask(replay_task);
function Pause()
{
}

function BeginResult()
{
}

