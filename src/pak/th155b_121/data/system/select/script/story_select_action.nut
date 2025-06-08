this.story_list_base <- [
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
this.slave_list <- {};
this.stage_num <- {};

foreach( v in this.story_list_base )
{
	local t = [];
	::manbow.LoadCSVtoArray("data/story/stage_list/" + v + ".csv", t);
	this.slave_list[v] <- t[0].slave_1p;
	this.stage_num[v] <- t.len();
}

this.story_list <- [];
this.difficulty <- 0;
this.device <- null;
this.device_id <- -128;
this.count <- 0;
this.help <- [
	"B1",
	"ok",
	null,
	"B2",
	"cancel",
	null,
	"UD",
	"select"
];
this.cursor_story <- null;
this.cursor_stage <- null;
this.cursor_spell <- null;
this.prev_story <- -1;
this.master <- {};
this.master.val <- 0;
this.state <- null;
function Initialize( _difficulty = 0 )
{
	this.difficulty = _difficulty;
	this.device = null;
	this.device_id = ::input_all.GetLastDevice();
	this.device = ::input.CreateSystemInputDevice(this.device_id);
	this.count = 0;
	this.story_list = [];

	if (_difficulty == 4)
	{
		foreach( v in this.story_list_base )
		{
			if (::savedata.story[v].overdrive)
			{
				this.story_list.push(v);
			}
		}
	}
	else
	{
		foreach( v in this.story_list_base )
		{
			if (::savedata.story[v].available)
			{
				this.story_list.push(v);
			}
		}
	}

	this.cursor_story <- this.Cursor(0, this.story_list.len(), this.device);
	this.cursor_spell = this.Cursor(0, 3, this.device);
	this.cursor_stage = this.Cursor(0, this.stage.len(), this.device);
	this.state = this.SelectStory;
	this.anime <- {};
	this.anime.action <- this.weakref();
	::manbow.CompileFile("data/system/select/script/story_select_animation.nut", this.anime);
	this.anime.Initialize();
	::loop.AddTask(this.anime);
	::loop.Begin(this);
}

function Terminate()
{
	::menu.help.Reset();
	::effect.Clear();

	if (this.anime)
	{
		::loop.DeleteTask(this.anime);
	}

	this.anime = null;
}

function Resume()
{
	if (this.anime)
	{
		return;
	}

	this.cursor_story.Reset();
	this.cursor_spell.Reset();
	this.cursor_stage.Reset();
	this.state = this.SelectStory;
	this.anime <- {};
	this.anime.action <- this.weakref();
	::manbow.CompileFile("data/system/select/script/story_select_animation.nut", this.anime);
	this.anime.Initialize();
	::loop.AddTask(this.anime);
	::sound.PlayBGM(::savedata.GetTitleBGMID());
}

function Suspend()
{
	::menu.help.Reset();
	::effect.Clear();

	if (this.anime)
	{
		::loop.DeleteTask(this.anime);
	}

	this.anime = null;
}

function Update()
{
	this.menu.help.Set(this.help);
	this.device.Update();
	this.state();
	this.count++;
}

function SelectStory()
{
	this.cursor_story.Update();

	if (this.cursor_story.ok)
	{
		this.state = this.SelectStage;

		if (this.prev_story != this.cursor_story.val)
		{
			this.prev_story = this.cursor_story.val;
			this.cursor_stage.val = 0;
		}

		local name = this.story_list[this.cursor_story.val];
		local num = 1;

		if (name in ::savedata.story)
		{
			if (this.difficulty == 4)
			{
				num = this.savedata.story[name].stage_overdrive + 1;
			}
			else
			{
				num = this.savedata.story[name].stage + 1;
			}

			if (num <= 0)
			{
				num = 1;
			}
			else if (num > this.stage_num[name])
			{
				num = this.stage_num[name];
			}
		}

		this.cursor_stage.SetItemNum(num);
		this.master.val = ::character_id[name];
		return;
	}

	if (this.cursor_story.cancel)
	{
		::loop.EndWithFade();
		return;
	}
}

function SelectStage()
{
	this.cursor_stage.Update();

	if (this.cursor_stage.ok)
	{
		this.state = this.SelectSpell;
	}
	else if (this.cursor_stage.cancel)
	{
		this.state = this.SelectStory;
	}
}

function SelectSpell()
{
	this.cursor_spell.Update();

	if (this.cursor_spell.ok)
	{
		this.BeginBattle();
		return;
	}
	else if (this.cursor_spell.cancel)
	{
		this.state = this.SelectStage;
	}
}

function SelectEnd()
{
	if (this.input.b1 == 1)
	{
		::sound.PlaySE("sys_cancel");
		this.state = this.SelectColor;
	}
}

function BeginBattle()
{
	local param = this.story.InitializeParam();
	param.device_id = this.device_id;
	param.difficulty = this.difficulty;
	param.scenario_name = this.story_list[this.cursor_story.val];
	param.slave_name = this.slave_list[param.scenario_name];
	param.spell = this.cursor_spell.val;
	param.stage = this.cursor_stage.val;
	param.seed = this.rand();
	::sound.StopBGM(500);

	if (this.device)
	{
		this.device.Lock();
	}

	::replay.Reset();
	::loop.Fade(function ()
	{
		::menu.story_select.Suspend();
		::story.Initialize(param);
	});
}

