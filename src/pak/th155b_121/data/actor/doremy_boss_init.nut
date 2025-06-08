this.manbow.CompileFile("data/actor/script/boss_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/boss_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_boss_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_boss_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_boss.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_boss_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_boss_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/doremy_boss_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/doremy_boss_shot.nut", this.player_effect_class);
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_BossCommon();
	this.type = 15;
	this.baseGravity = 0.60000002;
	this.baseSlideSpeed = 14.00000000;
	this.back_park = null;
	this.back_hole = [];
	this.mukon = ::manbow.Actor2DProcGroup();
	this.balloon = ::manbow.Actor2DProcGroup();
	this.mukon_se = 0;
	this.mukon_charge = 0;
	this.mukon_stock = [];
	local vec_ = this.Vector3();
	vec_.x = 100.00000000;
	local vec2_ = this.Vector3();
	vec2_.y = 100.00000000;
	local vec3_ = this.Vector3();
	vec3_.x = -100.00000000;
	local vec4_ = this.Vector3();
	vec4_.y = -100.00000000;
	this.mukon_pos = [
		vec_,
		vec2_,
		vec3_,
		vec4_
	];
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.event_defeat = this.Common_BossKoEvent;
	this.change_reset = function ()
	{
	};
	this.resetFunc = function ()
	{
		this.back_park = null;
		this.back_hole = [];
		this.mukon = ::manbow.Actor2DProcGroup();
		this.balloon = ::manbow.Actor2DProcGroup();
		this.mukon_se = 0;
		this.mukon_charge = 0;
		this.mukon_stock = [];
		local vec_ = this.Vector3();
		vec_.x = 100.00000000;
		local vec2_ = this.Vector3();
		vec2_.y = 100.00000000;
		local vec3_ = this.Vector3();
		vec3_.x = -100.00000000;
		local vec4_ = this.Vector3();
		vec4_.y = -100.00000000;
		this.mukon_pos = [
			vec_,
			vec2_,
			vec3_,
			vec4_
		];
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
	this.Load_SpellCardData("doremy");
};
this.manbow.CompileFile("data/actor/script/com_member.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_update.nut", this.player_class);
this.manbow.CompileFile("data/actor/com_common_action.nut", this.player_class);
this.manbow.CompileFile("data/actor/doremy_com_function.nut", this.player_class);
this.manbow.CompileFile("data/actor/script/com_boss.nut", this.player_class);
