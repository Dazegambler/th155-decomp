this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_shot.nut", this.player_effect_class);
this.player_class.kobito <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 12;
	this.baseGravity = 0,80000001.0;
	this.baseSlideSpeed = 17,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.kobito = ::manbow.Actor2DProcGroup();
	this.resetFunc = function ()
	{
		this.kobito = ::manbow.Actor2DProcGroup();
	};
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("sinmyoumaru");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
