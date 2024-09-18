this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/shion_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/shion_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/shion_shot.nut", this.player_effect_class);
this.player_class.aura <- null;
this.player_class.shion <- null;
this.player_class.shion_act <- false;
this.player_class.shion_ban <- false;
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.uv2 <- this.mgr.GetGlobalAnimation(2);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 19;
	this.baseGravity = 0.50000000;
	this.baseSlideSpeed = 10.00000000;
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
};
