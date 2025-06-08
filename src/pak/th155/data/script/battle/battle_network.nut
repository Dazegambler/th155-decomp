function Pause()
{
	::sound.StopBGM(500);

	if (::network.use_lobby)
	{
		::network.Disconnect();
	}
	else
	{
		::loop.EndWithFade();
	}
}

function BeginResult()
{
	if (::config.replay.save_mode_online == 0)
	{
		::replay.Save();
	}
	else
	{
	}

	this.End();
}

