this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/mokou_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/mokou_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 8;
	this.type = 11;
	this.baseGravity = 0.75000000;
	this.baseSlideSpeed = 17.50000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.resetFunc = function ()
	{
		this.occultCount = 0;
		this.occultEffect = 0;
		this.occult_level = 0;
		this.occult_cycle = 40;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
		if (this.occultCount > 0)
		{
			this.occultCount = 0;
			this.atkRate = 1.00000000;
			this.occult_level = 0;
		}
	};
	this.Load_SpellCardData("mokou");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/mokou_com_function.nut", this.player_class);
