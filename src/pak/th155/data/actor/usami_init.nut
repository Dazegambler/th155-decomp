this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/usami_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/usami_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/usami_shot.nut", this.player_effect_class);
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.skillC_pole <- null;
this.player_class.skillD_pos <- null;
this.player_class.skillE_shot <- null;
this.player_class.doppel <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 13;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 17.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.skillD_pos = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.skillD_pos[0].x = 150;
	this.skillD_pos[0].y = 0;
	this.skillD_pos[0].z = 0;
	this.skillD_pos[1].x = 150;
	this.skillD_pos[1].y = 74;
	this.skillD_pos[1].z = 161;
	this.skillD_pos[2].x = 126;
	this.skillD_pos[2].y = -10;
	this.skillD_pos[2].z = 50;
	this.skillD_pos[3].x = 132;
	this.skillD_pos[3].y = -64;
	this.skillD_pos[3].z = 15;
	this.skillD_pos[4].x = 138;
	this.skillD_pos[4].y = 80;
	this.skillD_pos[4].z = 268;
	this.skillD_pos[5].x = 145;
	this.skillD_pos[5].y = -40;
	this.skillD_pos[5].z = 11;
	this.skillD_pos[6].x = 142;
	this.skillD_pos[6].y = -99;
	this.skillD_pos[6].z = 312;
	this.skillD_pos[7].x = 150;
	this.skillD_pos[7].y = 74;
	this.skillD_pos[1].z = 161;
	this.uv.SetMotion(9900, 0);
	this.resetFunc = function ()
	{
		this.uv_count = 0;
		this.skillC_pole = null;
		this.skillE_shot = null;
		this.doppel = null;
	};
	this.change_reset = function ()
	{
	};

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}

	this.Load_SpellCardData("usami");
};
