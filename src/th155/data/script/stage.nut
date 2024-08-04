function Load( id )
{
	this.background <- {};
	this.background.camera <- ::camera;
	this.background.Update <- function ()
	{
	};
	local name = "data/script/background/bg" + (id < 10 ? "0" : "") + id + ".nut";
	::manbow.CompileFile(name, this.background);

	if (!(id in ::savedata.stage))
	{
		::savedata.stage[id] <- 1;
		::savedata.UpdateFlag();
		::savedata.Save();
	}
}

function Update()
{
	this.background.Update();
}

function Clear()
{
	this.background <- null;
}

