local pat_name = "data/actor/namazu/namazu.pat";
local palette_name = "data/actor/namazu/palette" + (this.color < 100 ? "0" : "") + (this.color < 10 ? "0" : "") + this.color + ".bmp";
this.mgr.LoadAnimationData(pat_name, palette_name);
this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/tenshi_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/tenshi_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 16;
	this.baseGravity = 0.80000001;
	this.baseSlideSpeed = 17.00000000;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_beginDemoSkip = function ()
	{
		this.CommonBeginBattleSkip();

		if (this.stone)
		{
			this.stone.func[2].call(this.stone);
		}
	};
	this.resetFunc = function ()
	{
		this.stone = this.SetFreeObject(this.x, this.y, this.direction, this.Foot_Stone, {}).weakref();
		this.sword = null;
		this.momo_time = 0;
		this.momo_aura = null;
		this.occult_back = null;
		this.occult_time = 0;
		this.occult_cycle = 0;
	};
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
		if (this.momo_aura)
		{
			this.momo_aura.func[1].call(this.momo_aura);
		}

		this.stone.func[0].call(this.stone);
		this.Vanish_Sword();
	};
	this.stone = this.SetFreeObject(this.x, this.y, this.direction, this.Foot_Stone, {}).weakref();
	this.Load_SpellCardData("tenshi");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/tenshi_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
