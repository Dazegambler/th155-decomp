this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/kokoro_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/kokoro_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 9;
	this.baseGravity = 0,40000001.0;
	this.baseSlideSpeed = 17,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.captureString = [];
	this.shotRand = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.shotRand[0].x = 16,00000000.0;
	this.shotRand[0].y = -5 * 0,01745329.0;
	this.shotRand[0].z = 0;
	this.shotRand[1].x = 17,00000000.0;
	this.shotRand[1].y = 23 * 0,01745329.0;
	this.shotRand[1].z = 0;
	this.shotRand[2].x = 16;
	this.shotRand[2].y = 33 * 0,01745329.0;
	this.shotRand[2].z = 1;
	this.shotRand[3].x = 15;
	this.shotRand[3].y = -6 * 0,01745329.0;
	this.shotRand[3].z = 2;
	this.shotRand[4].x = 17;
	this.shotRand[4].y = 19 * 0,01745329.0;
	this.shotRand[4].z = 1;
	this.uv.SetMotion(9901, 0);
	this.ChangeEmotion(-1);
	this.resetFunc = function ()
	{
		this.uv_count = 0;
		this.maskRot = 0,00000000.0;
		this.maskYaw = 0,00000000.0;
		this.maskPitch = 0,00000000.0;
		this.emotion = -1;
		this.emotionChange = false;
		this.mask = null;
		this.shadow = null;
		this.capture = null;
		this.captureString = [];
		this.spellA_Charge = 0;
		this.spellA_Aura = null;
		this.faceMask = true;
		this.ChangeEmotion(-1);
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("kokoro");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
