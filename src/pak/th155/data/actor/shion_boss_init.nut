this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/shion_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/shion_boss_shot.nut", this.player_effect_class);
this.player_class.aura <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 19;
	this.baseGravity = 0.50000000;
	this.baseSlideSpeed = 10.00000000;
	this.com_difficulty = this.difficulty;

	switch(this.difficulty)
	{
	case 0:
		this.com_level = 0;
		break;

	case 1:
		this.com_level = 33;
		break;

	case 2:
		this.com_level = 66;
		break;

	case 3:
		this.com_level = 100;
		break;
	}

	this.Reset_PlayerCommon();
	this.func_beginDemo = null;
	this.func_timeDemo = null;
	this.func_winDemo = null;
	this.resetFunc = function ()
	{
		this.aura = null;
	};
	this.change_reset = function ()
	{
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.motion_test = [
		function ()
		{
			this.BeginBattleA(null);
		},
		function ()
		{
			this.BeginBattleB(null);
		},
		function ()
		{
			this.WinA(null);
		},
		function ()
		{
			this.WinB(null);
		},
		function ()
		{
			this.WinC(null);
		},
		function ()
		{
			this.WinD(null);
		},
		function ()
		{
			this.Lose(null);
		}
	];
};
