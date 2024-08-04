function Initialize()
{
	local battle_param = ::battle.InitializeParam();
	battle_param.game_mode = 30;
	battle_param.seed = ::manbow.timeGetTime();

	for( local i = 0; i < 2; i = ++i )
	{
		battle_param.team[i].master = ::actor.CreatePlayer("master" + i, "reimu", 0, 4, 0);
		battle_param.team[i].slave = ::actor.CreatePlayer("slave" + i, "reimu", 0, 4, 0);
		battle_param.team[i].master_spell = 0;
		battle_param.team[i].device_id = ::input_all.GetLastDevice();
	}

	::stage.Load(1);
	::sound.PreLoadBGM(801);
	::battle.Create(battle_param);
	::battle.Begin();
	::loop.Begin(this);
	return true;
}

function Terminate()
{
	::battle.Release();
	::talk.Clear();
	::stage.Clear();
	::actor.Clear();
}

function Update()
{
	::battle.Update();
}

