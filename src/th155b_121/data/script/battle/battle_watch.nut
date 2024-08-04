local replay_task = {};
replay_task.Update <- function ()
{
	if (::input_all.b1 == 1)
	{
		::sound.PlaySE(111);
		::network.Disconnect();
	}
};
this.AddTask(replay_task);
function Pause()
{
}

function BeginResult()
{
}

