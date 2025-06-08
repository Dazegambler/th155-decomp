this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/mamizou_shot.nut", this.player_effect_class);
this.player_class.shapeshift <- false;
this.player_class.raccoon <- 4;
this.player_class.revive <- 0;
this.player_class.hyakki <- 0;
this.player_class.spellC_Hit <- false;
this.player_class.alien <- null;
this.player_class.karasaka <- null;
this.player_class.space <- 0;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 8;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 13.00000000;
	this.atkRange = 175.00000000;
	this.alien = [];
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.shapeshift = false;
		this.raccoon = 4;
		this.revive = 0;
		this.hyakki = 0;
		this.spellC_Hit = false;
		this.karasaka = null;
		this.space = 0;
		this.alien = [];
	};
	this.change_reset = function ()
	{
	};
	this.resetPracticeFunc = function ()
	{
		this.hyakki = 0;
		this.space = 0;
	};
	this.Load_SpellCardData("mamizou");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
