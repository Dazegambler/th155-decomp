this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/dummy.nut", this.player_class);
this.manbow.CompileFile("data/actor/dummy_base.nut", this.player_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = -1;
	this.baseGravity = 0,00000000.0;
	this.baseSlideSpeed = 0,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.change_reset = function ()
	{
	};
	this.resetFunc = function ()
	{
	};
	this.Load_SpellCardData("doremy");
};
