this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/marisa_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/marisa_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/marisa_shot.nut", this.player_effect_class);
this.player_class.bitList <- ::manbow.Actor2DProcGroup();
this.player_class.bitCore <- null;
this.player_class.bitShot <- 0;
this.player_class.okltSelect <- 0;
this.player_class.okltItem <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 1;
	this.baseGravity = 0,85000002.0;
	this.baseSlideSpeed = 19,50000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.practice_update = function ()
	{
		if (::battle.marisa[this.team.index] >= 0)
		{
			this.okltSelect = ::battle.marisa[this.team.index];
		}
	};
	this.resetFunc = function ()
	{
		this.okltItem = null;
		this.bitCore = 0;
		this.bitList = ::manbow.Actor2DProcGroup();
		this.bitShot = 0;
	};
	this.resetPracticeFunc = function ()
	{
		this.okltSelect = 0;
	};
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("marisa");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
