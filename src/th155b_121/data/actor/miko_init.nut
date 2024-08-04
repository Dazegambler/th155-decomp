this.player_class.sn <- {};
this.manbow.CompileFile("data/actor/player_common_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_team_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/player_story_move.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko_base.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko_combo.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko_team.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko_shot.nut", this.player_class);
this.manbow.CompileFile("data/actor/miko_shot.nut", this.shot_class);
this.manbow.CompileFile("data/actor/miko_shot.nut", this.collision_object_class);
this.manbow.CompileFile("data/actor/miko_shot.nut", this.player_effect_class);
this.player_class.uv <- this.mgr.GetGlobalAnimation(0);
this.player_class.uv_count <- 0;
this.player_class.style <- 0;
this.player_class.styleTime <- 0;
this.player_class.styleAura <- [];
this.player_class.ghost <- [];
this.player_class.warpCount <- 0;
this.player_class.spellB_Pat <- [
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3(),
	this.Vector3()
];
this.player_class.Init <- function ()
{
	this.SetMotion(0, 0);
	this.AI_PlayerCommon();
	this.type = 5;
	this.baseGravity = 0,55000001.0;
	this.baseSlideSpeed = 17,00000000.0;
	this.Reset_PlayerCommon();
	this.func_beginDemo = this.Func_BeginBattle;
	this.func_timeDemo = this.Func_Lose;
	this.func_winDemo = this.Func_Win;
	this.styleAura = [];
	this.ghost = [];
	this.spellB_Pat = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.spellB_Pat[0].x = 156;
	this.spellB_Pat[0].y = -83;
	this.spellB_Pat[0].z = 0,01745329.0 * 213;
	this.spellB_Pat[1].x = 267;
	this.spellB_Pat[1].y = 87;
	this.spellB_Pat[1].z = 0,01745329.0 * 266;
	this.spellB_Pat[2].x = 210;
	this.spellB_Pat[2].y = -17;
	this.spellB_Pat[2].z = 0,01745329.0 * 76;
	this.spellB_Pat[3].x = 238;
	this.spellB_Pat[3].y = -95;
	this.spellB_Pat[3].z = 0,01745329.0 * 286;
	this.spellB_Pat[4].x = 238;
	this.spellB_Pat[4].y = -61;
	this.spellB_Pat[4].z = 0,01745329.0 * 54;
	this.spellB_Pat[5].x = 170;
	this.spellB_Pat[5].y = -48;
	this.spellB_Pat[5].z = 0,01745329.0 * 152;
	this.spellB_Pat[6].x = 223;
	this.spellB_Pat[6].y = -4;
	this.spellB_Pat[6].z = 0,01745329.0 * 96;
	this.spellB_Pat[7].x = 184;
	this.spellB_Pat[7].y = 102;
	this.spellB_Pat[7].z = 0,01745329.0 * 327;
	this.spellB_Pat[8].x = 265;
	this.spellB_Pat[8].y = -120;
	this.spellB_Pat[8].z = 0,01745329.0 * 184;
	this.spellB_Pat[9].x = 189;
	this.spellB_Pat[9].y = 38;
	this.spellB_Pat[9].z = 0,01745329.0 * 50;
	this.spellB_Pat[10].x = 238;
	this.spellB_Pat[10].y = -142;
	this.spellB_Pat[10].z = 0,01745329.0 * 70;
	this.spellB_Pat[11].x = 188;
	this.spellB_Pat[11].y = 112;
	this.spellB_Pat[11].z = 0,01745329.0 * 198;
	this.spellB_Pat[12].x = 224;
	this.spellB_Pat[12].y = 91;
	this.spellB_Pat[12].z = 0,01745329.0 * 163;
	this.spellB_Pat[13].x = 172;
	this.spellB_Pat[13].y = 100;
	this.spellB_Pat[13].z = 0,01745329.0 * 329;
	this.spellB_Pat[14].x = 268;
	this.spellB_Pat[14].y = -108;
	this.spellB_Pat[14].z = 0,01745329.0 * 9;
	this.spellB_Pat[15].x = 192;
	this.spellB_Pat[15].y = 60;
	this.spellB_Pat[15].z = 0,01745329.0 * 305;
	this.spellB_Pat[16].x = 155;
	this.spellB_Pat[16].y = -142;
	this.spellB_Pat[16].z = 0,01745329.0 * 199;
	this.spellB_Pat[17].x = 209;
	this.spellB_Pat[17].y = -129;
	this.spellB_Pat[17].z = 0,01745329.0 * 64;
	this.spellB_Pat[18].x = 249;
	this.spellB_Pat[18].y = 55;
	this.spellB_Pat[18].z = 0,01745329.0 * 63;
	this.spellB_Pat[19].x = 264;
	this.spellB_Pat[19].y = -90;
	this.spellB_Pat[19].z = 0,01745329.0 * 163;
	this.spellB_Pat[20].x = 187;
	this.spellB_Pat[20].y = 1;
	this.spellB_Pat[20].z = 0,01745329.0 * 205;
	this.spellB_Pat[21].x = 196;
	this.spellB_Pat[21].y = -78;
	this.spellB_Pat[21].z = 0,01745329.0 * 21;
	this.spellB_Pat[22].x = 219;
	this.spellB_Pat[22].y = 129;
	this.spellB_Pat[22].z = 0,01745329.0 * 214;
	this.spellB_Pat[23].x = 230;
	this.spellB_Pat[23].y = 55;
	this.spellB_Pat[23].z = 0,01745329.0 * 255;
	this.spellB_Pat[24].x = 197;
	this.spellB_Pat[24].y = 141;
	this.spellB_Pat[24].z = 0,01745329.0 * 312;
	this.spellB_Pat[25].x = 221;
	this.spellB_Pat[25].y = -13;
	this.spellB_Pat[25].z = 0,01745329.0 * 87;
	this.uv.SetMotion(9901, 0);
	this.resetFunc = function ()
	{
		this.uv_count = 0;
		this.style = 0;
		this.styleTime = 0;
		this.ghost = [];
		this.styleAura = [];
		this.warpCount = 0;
		this.uv.SetMotion(9901, 0);
	};
	this.practice_update = function ()
	{
		if (::battle.miko[this.team.index] >= 0 && this.style != ::battle.miko[this.team.index])
		{
			foreach( a in this.styleAura )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.styleAura = [];
			this.SetMantType(::battle.miko[this.team.index]);

			if (this.style > 0)
			{
				this.styleTime = 1000;
				local t_ = {};
				t_.type <- this.style + 3;
				this.styleAura.append(this.SetFreeObjectDynamic(this.x, this.y + 50, 1,00000000.0, this.Okult_TimeAura, t_).weakref());
			}
			else
			{
				this.styleTime = 0;
			}
		}
	};
	this.change_reset = function ()
	{
	};
	this.Load_SpellCardData("miko");

	if (this.team.slave == this)
	{
		this.spellcard.id = 0;
	}
};
