this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/mamizou_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/mamizou_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
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
	this.event_defeat = this.Common_BossKoEvent;
	this.Load_SpellCardData("mamizou");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/mamizou_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
