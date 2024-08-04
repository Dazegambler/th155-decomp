function Load( id )
{
	this.background <- {};
	this.background.camera <- ::camera;
	this.background.Update <- function ()
	{
	};
	this.background.id <- id;

	if (::config.graphics.background == 0)
	{
		local name = "data/script/background/bg" + (id < 10 ? "0" : "") + id + ".nut";
		::manbow.CompileFile(name, this.background);
	}
	else
	{
		switch(id)
		{
		case 43:
			::manbow.CompileFile("data/script/background/bg_min_43.nut", this.background);
			break;

		case 46:
			::manbow.CompileFile("data/script/background/bg_min_46.nut", this.background);
			break;

		default:
			::manbow.CompileFile("data/script/background/bg_min.nut", this.background);
			break;
		}
	}

	if (::replay.GetState() != ::replay.PLAY)
	{
		if (!(id in ::savedata.stage))
		{
			::savedata.stage[id] <- 1;
			::savedata.UpdateFlag();
			::savedata.Save();
		}
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

