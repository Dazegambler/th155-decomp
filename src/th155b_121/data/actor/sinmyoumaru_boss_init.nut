this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
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
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("sinmyoumaru");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/sinmyoumaru_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
