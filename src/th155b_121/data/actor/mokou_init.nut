this.player_class.sn <- {};
this.player_class.occultCount <- 0;
this.player_class.occult_level <- 0;
this.player_class.occult_cycle <- 40;
this.player_class.occultEffect <- 0;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/mokou_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/mokou_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 11;
	this.baseGravity = 0.75000000;
	this.baseSlideSpeed = 17.50000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();
		this.freeMap = false;
	};
	this.resetFunc = function ()
	{
		this.occultCount = 0;
		this.occultEffect = 0;
		this.occult_level = 0;
		this.occult_cycle = 40;
	};
	this.change_reset = function ()
	{
		if (this.occultCount > 0)
		{
			this.team.enable_regain = true;
			this.occultCount = 0;
			this.atkRate = 1.00000000;
			this.occult_level = 0;
		}
	};
	this.motion_test = [
		function ()
		{
			this.Func_BeginBattle();
		},
		function ()
		{
			this.Func_Win();
		},
		function ()
		{
			this.Func_Lose();
		}
	];
	this.Load_SpellCardData("mokou");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
