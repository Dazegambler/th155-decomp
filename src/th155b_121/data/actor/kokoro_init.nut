this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/kokoro_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/kokoro_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/kokoro_shot.nut", this.player_effect_class);
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.maskRot <- 0.00000000;
this.player_class.maskYaw <- 0.00000000;
this.player_class.maskPitch <- 0.00000000;
this.player_class.emotion <- 0;
this.player_class.emotionChange <- false;
this.player_class.mask <- null;
this.player_class.shadow <- null;
this.player_class.capture <- null;
this.player_class.captureString <- null;
this.player_class.spellA_Charge <- 0;
this.player_class.spellA_Aura <- null;
this.player_class.faceMask <- true;
this.player_class.shotRand <- null;
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 9;
	this.baseGravity = 0.40000001;
	this.baseSlideSpeed = 17.00000000;
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
	this.shotRand[0].x = 16.00000000;
	this.shotRand[0].y = -5 * 0.01745329;
	this.shotRand[0].z = 0;
	this.shotRand[1].x = 17.00000000;
	this.shotRand[1].y = 23 * 0.01745329;
	this.shotRand[1].z = 0;
	this.shotRand[2].x = 16;
	this.shotRand[2].y = 33 * 0.01745329;
	this.shotRand[2].z = 1;
	this.shotRand[3].x = 15;
	this.shotRand[3].y = -6 * 0.01745329;
	this.shotRand[3].z = 2;
	this.shotRand[4].x = 17;
	this.shotRand[4].y = 19 * 0.01745329;
	this.shotRand[4].z = 1;
	this.uv.SetMotion(9901, 0);
	this.ChangeEmotion(-1);
	this.resetFunc = function ()
	{
		this.uv_count = 0;
		this.maskRot = 0.00000000;
		this.maskYaw = 0.00000000;
		this.maskPitch = 0.00000000;
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
	this.change_reset = function ()
	{
	};
	this.practice_update = function ()
	{
		if (::battle.kokoro[this.team.index] == 3 && this.emotion != -1)
		{
			this.ChangeEmotion(-1);
		}
		else if (this.emotion != ::battle.kokoro[this.team.index] && ::battle.kokoro[this.team.index] >= 0 && ::battle.kokoro[this.team.index] <= 2)
		{
			this.ChangeEmotion(::battle.kokoro[this.team.index]);
		}
	};
	this.Load_SpellCardData("kokoro");

	if (this.team.slave == this)
	{
		this.spellcard.id = 2;
	}
};
