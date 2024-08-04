function Initialize()
{
	this.Begin();
	::loop.Begin(this);
}

function Terminate()
{
	::network.Disconnect();
}

function Suspend()
{
}

function Resume()
{
	this.Begin();
}

function Update()
{
	if (::input_all.b1 == 1)
	{
		::loop.EndWithFade();
	}
}

function Begin()
{
	::network.BeginStreamingPlay(function ()
	{
		::replay.Watch();
		local param = this.vs.InitializeParam();
		::replay.GetUserData(param, param.param_list);
		::sound.StopBGM(500);
		::loop.Fade(function ()
		{
			::menu.watch.Suspend();
			::watch.Initialize(param);
		});
	}, function ()
	{
		::replay.Reset();
		::loop.EndWithFade();
	});
}

