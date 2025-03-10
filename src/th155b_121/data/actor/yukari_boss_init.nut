this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/yukari_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/yukari_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 17;
	this.baseGravity = 0.50000000;
	this.baseSlideSpeed = 14.00000000;
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
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("yukari");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/yukari_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
