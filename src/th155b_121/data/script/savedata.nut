this.sig <- "th155";
this.version <- this.GetVersion();
this.bgm <- {};
this.stage <- {};
local stage_list = [
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	11,
	26,
	12,
	28,
	30
];

foreach( v in stage_list )
{
	this.stage[v] <- 1;
}

this.character <- {};
this.story <- {};
local story_list = [
	"reimu",
	"marisa",
	"nitori",
	"mamizou",
	"miko",
	"futo",
	"udonge",
	"usami",
	"tenshi",
	"yukari",
	"jyoon"
];

foreach( v in story_list )
{
	local t = {};
	t.available <- false;
	t.overdrive <- 0;
	t.stage <- -1;
	t.stage_overdrive <- -1;
	t.ed <- 0;
	this.story[v] <- t;
}

this.story.reimu.available = true;
this.story.reimu.overdrive = 1;
this.story.reimu.stage = 0;
this.ed <- {};
this.ed.type0 <- 0;
this.ed.type1 <- 0;
this.ed.type2 <- 0;
function Initialize()
{
}

function Save()
{
	return ::manbow.SaveTable("score.dat", this);
}

function Load()
{
	local t = {};

	if (::manbow.LoadTableEx("score.dat", t, false))
	{
		if (this.Validate(t))
		{
			::manbow.LoadTableEx("score.dat", this, false);
			this.version = this.GetVersion();
			return true;
		}
	}

	return false;
}

function Validate( t )
{
	if (!("sig" in t) || this.sig != "th155")
	{
		return false;
	}

	return true;
}

function UpdateFlag()
{
	local count_check = [
		"marisa",
		"mamizou",
		"miko",
		"nitori",
		"futo"
	];
	local clear_count = 0;

	foreach( v in count_check )
	{
		if (this.story[v].ed)
		{
			clear_count++;
		}
	}

	if (this.story.reimu.ed)
	{
		this.story.marisa.available = true;
		this.story.mamizou.available = true;
		this.story.miko.available = true;
	}

	if (this.story.marisa.ed)
	{
		this.story.nitori.available = true;
	}

	if (this.story.miko.ed)
	{
		this.story.futo.available = true;
	}

	if (clear_count >= 1)
	{
		this.story.udonge.available = true;
	}

	if (clear_count >= 3)
	{
		this.story.usami.available = true;
	}

	if (clear_count >= 5)
	{
		this.story.tenshi.available = true;
	}

	if (this.story.tenshi.ed)
	{
		this.story.yukari.available = true;
	}

	if (this.story.yukari.ed)
	{
		this.story.jyoon.available = true;
	}

	clear_count = 0;

	foreach( v in count_check )
	{
		if (this.story[v].ed & 16)
		{
			clear_count++;
		}
	}

	if (this.story.reimu.ed & 16)
	{
		this.story.marisa.overdrive = 1;
		this.story.mamizou.overdrive = 1;
		this.story.miko.overdrive = 1;
	}

	if (this.story.marisa.ed & 16)
	{
		this.story.nitori.overdrive = 1;
	}

	if (this.story.miko.ed & 16)
	{
		this.story.futo.overdrive = 1;
	}

	if (clear_count >= 1)
	{
		this.story.udonge.overdrive = 1;
	}

	if (clear_count >= 3)
	{
		this.story.usami.overdrive = 1;
	}

	if (clear_count >= 5)
	{
		this.story.tenshi.overdrive = 1;
	}

	if (this.story.tenshi.ed & 16)
	{
		this.story.yukari.overdrive = 1;
	}

	if (this.story.yukari.ed & 16)
	{
		this.story.jyoon.overdrive = 1;
	}

	if ("yukari" in this.character)
	{
		this.stage[27] <- 1;
	}
}

function IsTitleChange()
{
	return this.story.jyoon.available;
}

function GetTitleBGMID()
{
	if (this.story.jyoon.available)
	{
		return 504;
	}

	if (this.story.tenshi.available)
	{
		return 503;
	}

	if (this.story.reimu.ed)
	{
		return 502;
	}

	return 501;
}

function GetDifficultyNum()
{
	if (this.story.jyoon.ed & 255)
	{
		return 5;
	}

	return 4;
}

function GetColorNum()
{
	if (this.story.jyoon.ed & 16)
	{
		return 10;
	}

	if (this.story.jyoon.ed & 255)
	{
		return 9;
	}

	return 8;
}


if (!this.Load())
{
	this.Save();
}

this.UpdateFlag();
