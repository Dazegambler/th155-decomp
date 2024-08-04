::manbow.CompileFile("data/script/scene/vs.nut", this);
function Update()
{
	while (::network.IsEnableStreamingBuffer())
	{
		::battle.Update();
	}
}

