local replay_task = {};
replay_task.Update <- function ()
{
	if (::replay.IsFinished())
	{
		::sound.StopBGM(500);
		::sound.SetVolumeSE(::config.sound.se / 100.00000000);
		::loop.EndWithFade();
	}
	else if (::input_all.b1 == 1 && !::talk.is_active && !::graphics.IsFading())
	{
		::sound.PlaySE(111);
		::sound.SetVolumeSE(::config.sound.se / 100.00000000);
		::menu.pause.Initialize(3);
	}
};
this.AddTask(replay_task);
::sound.SetVolumeSE(0);
function Update()
{
	while (true)
	{
		this.UpdateMain();

		if (!::talk.is_active)
		{
			::sound.SetVolumeSE(::config.sound.se / 100.00000000);
			this.Update = function ()
			{
				this.UpdateMain();
			};
			break;
		}

		if (::replay.IsFinished())
		{
			break;
		}
	}
}

function Pause()
{
}

function Round_WinCall()
{
	this.battleUpdate = null;

	if (::replay.recorder.userdata.stage_end == ::story.stage)
	{
		::loop.EndWithFade();
		return;
	}

	::graphics.FadeOut(60, function ()
	{
		::story.NextStage();
	});
}

function Lose()
{
	this.battleUpdate = null;
	::loop.EndWithFade();
}

this.Continue = this.Lose;
