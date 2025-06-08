this.player_class.sn <- {};
this.player_class.sf <- {};
this.player_class.ran <- null;
this.player_class.chen <- null;
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/yukari_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/yukari_shot.nut", this.player_effect_class);
this.player_class.occult_foot <- null;
this.player_class.shot_front <- null;
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 17;
	this.baseGravity = 0.30000001;
	this.baseSlideSpeed = 12.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.shot_front = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.shot_front[0].y = -2;
	this.shot_front[0].x = 0;
	this.shot_front[1].y = 55;
	this.shot_front[1].x = 0;
	this.shot_front[2].y = 16;
	this.shot_front[2].x = 0;
	this.shot_front[3].y = -57;
	this.shot_front[3].x = 0;
	this.shot_front[4].y = 78;
	this.shot_front[4].x = 0;
	this.shot_front[5].y = -72;
	this.shot_front[5].x = 0;
	this.resetFunc = function ()
	{
		this.occult_foot = null;
		this.ran = null;
		this.chen = null;
		this.uv_count = 0;
	};
	this.change_reset = function ()
	{
	};
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
			this.Lose(null);
		},
		function ()
		{
			this.Spell_A_Init(null);
		},
		function ()
		{
			this.Spell_B_Init(null);
		},
		function ()
		{
			this.Spell_C_Init(null);
		}
	];
	this.Load_SpellCardData("yukari");

	if (this.team.slave == this)
	{
		this.spellcard.id = 1;
	}
};
