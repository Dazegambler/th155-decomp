this.data <- [];
this.spell <- 0;
this.difficulty <- 0;
this.device_id <- 0;
this.seed <- 0;
this.name <- null;
this.stage <- 0;
this.stock_init <- 2;
this.stock <- this.stock_init;
this.master_name <- [
	"",
	""
];
this.slave_name <- [
	"",
	""
];
this.master <- [
	null,
	null
];
this.slave <- [
	null,
	null
];
this.slave_sub <- [
	null,
	null
];
this.continue_count <- 0;
this.is_continued <- false;
class this.InitializeParam 
{
	game_mode = 10;
	difficulty = 0;
	device_id = -2;
	scenario_name = null;
	slave_name = "";
	spell = 0;
	stage = 0;
	stage_end = 0;
	seed = 0;
	param_list = [
		"difficulty",
		"scenario_name",
		"slave_name",
		"spell",
		"stage",
		"stage_end",
		"seed"
	];
	constructor()
	{
	}

}

function Initialize( param )
{
	this.name = param.scenario_name;
	this.spell = param.spell;
	this.device_id = param.device_id;
	this.difficulty = param.difficulty;
	this.seed = param.seed;
	this.continue_count = 0;
	this.stock = this.stock_init;
	this.is_continued = false;

	if (::replay.GetState() == ::replay.NONE)
	{
		::replay.Create(param.game_mode);
		::replay.SetUserData(param, param.param_list);
	}

	this.data = [];
	::manbow.LoadCSVtoArray("data/story/stage_list/" + this.name + ".csv", this.data);

	if (this.data.len() <= param.stage)
	{
		return false;
	}

	this.stage = param.stage;
	this.CreateStage(this.data[this.stage]);
	::loop.Begin(this);
	return true;
}

function Terminate()
{
	::battle.Release();
	this.master = [
		null,
		null
	];
	this.slave = [
		null,
		null
	];
	this.slave_sub = [
		null,
		null
	];
	this.master_name = [
		null,
		null
	];
	this.slave_name = [
		null,
		null
	];
	::talk.Clear();
	::stage.Clear();
	::actor.Clear();
}

function Update()
{
	::battle.Update();
}

function NextStage()
{
	if (this.stage >= this.data.len())
	{
		return;
	}

	local t = {};
	t.Update <- function ()
	{
		::battle.Release();
		::talk.Clear();
		::stage.Clear();
		::story.is_continued = false;
		::story.stage++;
		::story.CreateStage(::story.data[::story.stage]);
		::loop.DeleteTask(this);
	};
	::loop.AddTask(t);
}

function Continue()
{
	::battle.Release();
	::talk.Clear();
	::stage.Clear();
	this.is_continued = true;
	this.CreateStage(this.data[this.stage]);
}

function BeginEnding()
{
	::loop.Fade(function ()
	{
		::savedata.Save();
		::ed.Initialize();
	}, 180, 1, 1, 1);
}

function CreateStage( param )
{
	::manbow.CompileFile("data/script/battle/battle_param.nut", ::battle);
	local battle_param = ::battle.InitializeParam();
	battle_param.game_mode = 10;
	battle_param.seed = this.seed;
	::actor.InitializeStoryEffect();
	local _name = param.master_1p;

	if (this.master_name[0] != _name)
	{
		this.master_name[0] = _name;
		this.master[0] = ::actor.CreatePlayer("master0", _name, 0, 0, 0);
	}
	else
	{
		::actor.ResetPlayer("master0");
	}

	_name = param.slave_1p;

	if (_name in ::character_id_story)
	{
		if (this.slave_name[0] != _name)
		{
			this.slave_name[0] = _name;
			this.slave[0] = ::actor.CreatePlayer("slave0", _name, 100, 0, 0);
		}
		else
		{
			::actor.ResetPlayer("slave0");
		}
	}
	else
	{
		::actor.ReleasePlayer("slave0");
		this.slave_name[0] = null;
		this.slave[0] = null;
	}

	battle_param.team[0].master = this.master[0];
	battle_param.team[0].slave = this.slave[0];
	battle_param.team[0].master_spell = this.spell;
	battle_param.team[0].device_id = this.device_id;
	_name = param.master_2p;

	if (this.master_name[1] != _name)
	{
		this.master_name[1] = _name;
		this.master[1] = ::actor.CreatePlayer("master1", _name, 0, 2, this.difficulty);
	}
	else
	{
		::actor.ResetPlayer("master1");
	}

	_name = param.slave_2p;

	if (_name in ::character_id_story)
	{
		if (this.slave_name[1] != _name)
		{
			this.slave_name[1] = _name;
			this.slave[1] = ::actor.CreatePlayer("slave1", _name, 100, 2, this.difficulty);
		}
		else
		{
			::actor.ResetPlayer("slave1");
		}
	}
	else
	{
		::actor.ReleasePlayer("slave1");
		this.slave_name[1] = null;
		this.slave[1] = null;
	}

	battle_param.team[1].master = this.master[1];
	battle_param.team[1].slave = this.slave[1];

	if (param.exchange && this.slave[0] && this.slave[1])
	{
		this.slave_sub[0] = ::actor.ClonePlayer("slave_sub0", this.slave[1], 0, 0);
		this.slave_sub[1] = ::actor.ClonePlayer("slave_sub1", this.slave[0], 2, this.difficulty);
		battle_param.team[0].slave_sub = this.slave_sub[0];
		battle_param.team[1].slave_sub = this.slave_sub[1];
	}
	else
	{
		this.slave_sub[0] = this.slave_sub[1] = null;
	}

	::stage.Load(param.background);
	::talk.Load("data/event/script/" + this.name + "/stage" + (this.stage + 1) + ".pl");

	if (::replay.GetState() != ::replay.PLAY)
	{
		if (this.difficulty == 4)
		{
			if (::savedata.story[this.name].stage_overdrive < this.stage)
			{
				::savedata.story[this.name].stage_overdrive = this.stage;
				::savedata.Save();
			}
		}
		else if (::savedata.story[this.name].stage < this.stage)
		{
			::savedata.story[this.name].stage = this.stage;
			::savedata.Save();
		}

		if (!(param.master_2p in ::savedata.character))
		{
			::savedata.character[param.master_2p] <- 1;
			::savedata.UpdateFlag();
			::savedata.Save();
		}

		if (::replay.GetState() == ::replay.RECORD)
		{
			local t = {};
			t.stage_end <- this.stage;
			::replay.SetUserData(t);
		}
	}

	::battle.Create(battle_param);
	::battle.Begin();
}

