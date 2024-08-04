this.time_unit <- 90;
this.time <- 99 * this.time_unit;
this.camera_pos <- this.Vector3();
this.camera_zoom <- 1,00000000.0;
this.is_continued <- false;
this.enable_win_demo <- true;
this.enable_demo_talk <- false;
this.enable_KO_exp <- true;
this.enable_KO_stand <- false;
this.enable_slave <- [
	true,
	true
];
this.KO_slave <- false;
this.name_actor <- [
	null,
	null
];
this.info_text <- null;
this.bgm <- null;
this.change_slave <- false;
this.GuardCrash_Check = this.GuardCrash_Check_Story;
this.boss_spell <- [];

if (::story.difficulty == 4)
{
	if (!::manbow.LoadCSVtoArray("data/story/spell_list/" + ::story.name + "_stage_" + (::story.stage + 1) + "_od.csv", this.boss_spell))
	{
		::manbow.LoadCSVtoArray("data/story/spell_list/" + ::story.name + "_stage_" + (::story.stage + 1) + ".csv", this.boss_spell);
	}
}
else
{
	::manbow.LoadCSVtoArray("data/story/spell_list/" + ::story.name + "_stage_" + (::story.stage + 1) + ".csv", this.boss_spell);
}

function Pause()
{
	::sound.PlaySE(111);
	::input_talk.Lock();
	::menu.pause.Initialize(2);
}

function Begin()
{
	this.state = 2;
	this.demoCount = 0;
	this.enable_contact_test = false;
	::talk.Begin("main_1");
	this.Player_Setting();
	this.Boss_Setting();
}

function Restart_Stage()
{
	if (this.change_slave)
	{
		this.change_slave = false;
		::battle.team[0].ChangeSlave();
		::battle.team[1].ChangeSlave();
	}

	this.boss_spell <- [];
	::manbow.LoadCSVtoArray("data/story/spell_list/" + ::story.name + "_stage_" + (::story.stage + 1) + ".csv", this.boss_spell);
	this.demoCount = 0;
	this.group_player.Clear(~15);
	this.group_effect.Clear(-1);
	this.team[0].ResetRound();
	this.team[1].ResetBoss();
	this.Player_Setting();
	this.Boss_Setting();
	::camera.Reset();
	::camera.SetTarget(640, 340, 2,00000000.0, true);
	this.Begin();
	::graphics.FadeIn(15);
}

function Player_Setting()
{
	local player = this.team[0];
	player.SetDamage_FullRegain = player.SetDamage_FullRegain_Base;
	player.AddSP = player.AddSP_Base;

	if (!this.enable_slave[0])
	{
		player.slave_ban = -1;
	}
}

function Boss_Setting()
{
	if (this.boss_spell.len() <= 0)
	{
		return false;
	}

	local boss = this.team[1];

	if (!this.enable_slave[1])
	{
		boss.slave_ban = -1;
	}

	boss.life = this.boss_spell[0].master_life;
	boss.regain_life = this.boss_spell[0].master_life + this.boss_spell[0].slave_life;
	boss.life_max = boss.regain_life;
	boss.shield_life = 0;
	boss.SetDamage = boss.SetDamageBoss;
	boss.AddSP = boss.AddSP_Boss;

	if (this.boss_spell.len() <= 1 && this.enable_KO_exp)
	{
		boss.master.koExp = true;

		if (boss.slave)
		{
			boss.slave.koExp = true;
		}

		if (boss.slave_sub)
		{
			boss.slave_sub.koExp = true;
		}

		if (this.KO_slave)
		{
			boss.master.ko_slave = true;

			if (boss.slave)
			{
				boss.slave.ko_slave = true;
			}

			if (boss.slave_sub)
			{
				boss.slave_sub.ko_slave = true;
			}
		}
		else
		{
			boss.master.ko_slave = false;

			if (boss.slave)
			{
				boss.slave.ko_slave = false;
			}

			if (boss.slave_sub)
			{
				boss.slave_sub.ko_slave = false;
			}
		}
	}
	else
	{
		boss.master.koExp = false;

		if (boss.slave)
		{
			boss.slave.koExp = false;
		}

		if (boss.slave_sub)
		{
			boss.slave_sub.koExp = false;
		}

		if (this.KO_slave)
		{
			boss.master.ko_slave = true;

			if (boss.slave)
			{
				boss.slave.ko_slave = true;
			}

			if (boss.slave_sub)
			{
				boss.slave_sub.ko_slave = true;
			}
		}
		else
		{
			boss.master.ko_slave = false;

			if (boss.slave)
			{
				boss.slave.ko_slave = false;
			}

			if (boss.slave_sub)
			{
				boss.slave_sub.ko_slave = false;
			}
		}
	}

	if (this.boss_spell[0].master_func.len() > 0)
	{
		boss.master[this.boss_spell[0].master_func]();
	}

	if (boss.slave && this.boss_spell[0].slave_func.len() > 0)
	{
		boss.slave[this.boss_spell[0].slave_func]();
	}
}

function Boss_Spell_Lost()
{
	if (this.boss_spell.len() <= 1)
	{
		return true;
	}

	this.boss_spell.remove(0);
	return false;
}

function BeginCamera()
{
	this.camera_pos.x = 640;
	this.camera_pos.y = 340;
	this.camera_zoom = 1,10000002.0;
	::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	this.battleUpdate = function ()
	{
		this.camera_zoom += (2,00000000.0 - this.camera_zoom) * 0,07500000.0;

		if (this.camera_zoom > 1,99800003.0)
		{
			this.camera_zoom = 2,00000000.0;
			this.battleUpdate = null;
		}

		::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	};
}

function BeginCamera_Live()
{
	this.camera_pos.x = 640;
	this.camera_pos.y = 720;
	this.camera_zoom = 2,00000000.0;
	::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	this.battleUpdate = function ()
	{
		this.camera_pos.y -= 1,00000000.0;

		if (this.camera_pos.y <= 340)
		{
			this.camera_pos.y = 340;
			this.battleUpdate = null;
		}

		::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	};
}

function BeginCamera_LiveStart()
{
	this.camera_pos.x = 640;
	this.camera_pos.y = 640;
	this.camera_zoom = 6,00000000.0;
	::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	this.battleUpdate = function ()
	{
		this.camera_zoom += (2,00000000.0 - this.camera_zoom) * 0,02500000.0;
		this.camera_pos.y += (340 - this.camera_pos.y) * 0,02500000.0;

		if (this.camera_zoom < 2,00200009.0)
		{
			this.camera_zoom = 2,00000000.0;
			this.camera_pos.y = 340;
			this.battleUpdate = null;
		}

		::camera.SetTarget(this.camera_pos.x, this.camera_pos.y, this.camera_zoom, true);
	};
}

function Set_BattleMessage( x_, y_, text_ )
{
	if (this.info_text)
	{
		this.info_text.func[0].call(this.info_text);
		this.info_text = null;
	}

	local t_ = {};
	t_.text <- text_;
	this.info_text = ::actor.SetEffect(x_, y_, 1,00000000.0, ::actor.effect_class.Font_Infomation, t_).weakref();
}

function Clear_BattleMessage()
{
	if (this.info_text)
	{
		this.info_text.func[0].call(this.info_text);
		this.info_text = null;
	}
}

function PlayBGM_Title( bgm_ )
{
	::sound.PlayBGM(bgm_);
	this.bgm = this.BGMTitle();
	this.bgm.Activate();
}

function ShowBGM_Title()
{
	this.bgm = this.BGMTitle();
	this.bgm.Activate();
}

function Show_StageTitle()
{
	::actor.SetStoryEffect(640, 360, 1,00000000.0, ::actor.effect_class.Story_Title_Name, {});
}

function Show_EnemyName()
{
	this.name_actor[0] = ::actor.SetStoryEffect(1480, 720, 1,00000000.0, ::actor.effect_class.Story_EnemyName, {}).weakref();

	if (this.name_actor[1])
	{
		this.name_actor[1].func();
	}
}

function Show_EnemySlaveName()
{
	this.name_actor[1] = ::actor.SetStoryEffect(1500, 740, 1,00000000.0, ::actor.effect_class.Story_EnemySlaveName, {}).weakref();

	if (this.name_actor[0])
	{
		this.name_actor[0].func();
	}
}

function Hide_EnemyName()
{
	if (this.name_actor[0])
	{
		this.name_actor[0].func();
	}

	if (this.name_actor[1])
	{
		this.name_actor[1].func();
	}
}

function Begin_StartDemo()
{
	this.demoCount = 0;
	this.state = 1;
	this.battleUpdate = this.Begin_StartDemo_Update;
}

function Begin_StartDemo_Update()
{
}

function Begin_BattleDemo()
{
	this.gauge.Hide();
	this.demoCount = 0;
	this.state = 1;
	this.battleUpdate = this.BattleDemo_Update;
}

function BattleDemo_Update()
{
	this.demoCount++;

	if (this.demoCount == 60)
	{
		::talk.Begin("demo_1");
	}
}

function Battle_Ready()
{
	this.Hide_EnemyName();
	this.demoCount = 0;
	this.state = 4;
	this.battleUpdate = this.Battle_Ready_Update;
	this.gauge.Show();
	this.ShowBGM_Title();
}

function Battle_Ready_Update()
{
	this.demoCount++;

	if (this.demoCount == 100 - 70)
	{
		this.PlaySE(851);
		::actor.SetEffectLight(640, 360, 1001);
	}

	if (this.demoCount == 148 - 70)
	{
		this.PlaySE(853);
	}

	if (this.demoCount == 100 + 70 - 70)
	{
		this.Battle_Fight();
	}
}

function Battle_Fight()
{
	this.demoCount = 0;
	this.state = 8;
	this.battleUpdate = this.Fight_Update;
	this.enable_contact_test = true;
	::camera.SetTarget(640, 340, 2,00000000.0, true);
	::camera.SetMode_Battle();
}

function Battle_Restart()
{
	if (this.enable_demo_talk)
	{
		this.enable_demo_talk = false;
		this.Begin_BattleDemo();
		return;
	}

	this.demoCount = 0;
	this.state = 8;
	this.battleUpdate = this.Fight_Update;
	this.enable_contact_test = true;
}

function Battle_Restart_Demo()
{
	this.gauge.Show(25);
	this.demoCount = 0;
	this.battleUpdate = this.Restart_Demo_Update;
}

function Restart_Demo_Update()
{
	this.demoCount++;

	if (this.demoCount == 15)
	{
		this.demoCount = 0;
		this.state = 8;
		this.battleUpdate = this.Fight_Update;
		this.enable_contact_test = true;
	}
}

function Fight_Update()
{
	this.demoCount++;

	if (this.demoCount == 120)
	{
		if (this.bgm)
		{
			this.bgm.Deactivate();
			this.bgm = null;
		}
	}

	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	local p1_ko = this.team[0].CheckKO();
	local p2_ko = this.team[1].CheckKO();

	if (p1_ko)
	{
		if (p2_ko)
		{
			if (this.bgm)
			{
				this.bgm.Deactivate();
				this.bgm = null;
			}

			::battle.Clear_BattleMessage();
			this.Double_KO();
			return;
		}
		else
		{
			if (this.bgm)
			{
				this.bgm.Deactivate();
				this.bgm = null;
			}

			::battle.Clear_BattleMessage();
			this.Player_KO();
			return;
		}
	}
	else if (p2_ko)
	{
		if (this.bgm)
		{
			this.bgm.Deactivate();
			this.bgm = null;
		}

		::battle.Clear_BattleMessage();
		this.Enemy_KO();
		return;
	}

	if (!this.is_time_stop && this.enableTimeCount && this.time >= 0)
	{
		this.time--;

		if (this.time < 0)
		{
			this.time = 0;
		}
	}
}

function Player_KO()
{
	if (::story.stock <= 0)
	{
		this.Player_Defeat();
		return;
	}

	::story.stock--;
	local t_ = {};
	t_.count <- 60;
	t_.priority <- 210;
	::actor.SetEffect(640, 360, 1,00000000.0, ::actor.effect_class.EF_SpeedLine, t_);
	::actor.SetEffectLight(640, 360, 1001, 1);
	this.PlaySE(855);
	this.demoCount = 0;
	this.SetTimeStop(30);
	this.battleUpdate = this.Player_KO_Update;
}

function Player_KO_Update()
{
	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	if (this.team[0].current.centerStop == 0)
	{
		this.demoCount++;

		if (this.demoCount >= 45)
		{
			this.team[0].life = this.team[0].life_max;
			this.team[0].regain_life = this.team[0].life_max;
			this.team[0].damage_life = this.team[0].life_max;
			this.team[0].master.enableStandUp = true;
			this.team[0].slave.enableStandUp = true;
			this.Battle_Restart();
			return;
		}
	}
}

function Player_Defeat()
{
	this.FightEndFunction();
	local t_ = {};
	t_.count <- 60;
	t_.priority <- 210;
	::actor.SetEffect(640, 360, 1,00000000.0, ::actor.effect_class.EF_SpeedLine, t_);
	::actor.SetEffectLight(640, 360, 1001, 1);
	this.PlaySE(855);
	this.state = 64;
	this.demoCount = 0;
	this.enable_contact_test = false;
	this.enableTimeCount = false;
	this.endWinDemo = [
		false,
		false
	];
	this.endLoseDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	this.SetTimeStop(60);
	this.battleUpdate = this.Player_Defeat_Update;
}

function Player_Defeat_Update()
{
	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	this.demoCount++;

	if (this.demoCount == 120)
	{
		this.team[0].ResetCombo();
		this.team[1].ResetCombo();
		this.demoCount = 0;
		this.battleUpdate = function ()
		{
			if (this.team[0].current.centerStop == 0)
			{
				this.demoCount++;

				if (this.demoCount == 30)
				{
					this.Lose();
					return;
				}
			}
		};
	}
}

function Enemy_KO()
{
	if (this.boss_spell.len() <= 1)
	{
		this.Enemy_Defeat();
		return;
	}

	this.team[1].current.EndBossCard();
	local t_ = {};
	t_.count <- 60;
	t_.priority <- 210;
	::actor.SetEffect(640, 360, 1,00000000.0, ::actor.effect_class.EF_SpeedLine, t_);
	::actor.SetEffectLight(640, 360, 1001, 1);
	this.PlaySE(855);
	this.state = 64;
	this.demoCount = 0;
	this.enable_contact_test = false;
	this.enableTimeCount = false;
	this.endWinDemo = [
		false,
		false
	];
	this.endLoseDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	this.SetTimeStop(60);
	this.battleUpdate = this.Enemy_KO_Update;
}

function Enemy_KO_Update()
{
	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	this.demoCount++;

	if (this.demoCount > 60 && this.team[0].current.IsFree() && (!this.team[1].current.isVisible || this.team[1].current.centerStop == 0))
	{
		this.demoCount = 0;
		this.battleUpdate = function ()
		{
			this.demoCount++;

			if (this.demoCount >= 60)
			{
				this.team[1].current.stanCount = 0;
				this.team[1].current.stanBossCount = 0;
				this.team[1].current.enableStandUp = true;
				this.team[1].current.enableKO = false;
				this.Boss_Spell_Lost();
				this.Boss_Setting();
				this.Battle_Restart();
			}
		};
	}
}

function Enemy_Defeat()
{
	this.FightEndFunction();
	this.team[1].current.EndBossCard();
	local t_ = {};
	t_.count <- 60;
	t_.priority <- 210;
	::actor.SetEffect(640, 360, 1,00000000.0, ::actor.effect_class.EF_SpeedLine, t_);
	::actor.SetEffectLight(640, 360, 1001, 1);
	this.PlaySE(855);
	this.state = 64;
	this.demoCount = 0;
	this.enable_contact_test = false;
	this.enableTimeCount = false;
	this.endWinDemo = [
		false,
		false
	];
	this.endLoseDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	this.SetTimeStop(60);
	this.SetSlow(180);
	this.battleUpdate = this.Enemy_Defeat_Update;
}

function Enemy_Defeat_Update()
{
	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	this.demoCount++;

	if (this.demoCount >= 300 && this.team[0].life <= 0)
	{
		if (this.team[0].current.centerStop == 0)
		{
			this.team[0].life = this.team[0].life_max;
			this.team[0].regain_life = this.team[0].life_max;
			this.team[0].damage_life = this.team[0].life_max;
			this.team[0].master.enableStandUp = true;
			this.team[0].slave.enableStandUp = true;
			return;
		}
	}

	if (this.enable_KO_exp)
	{
		if (this.demoCount >= 420 && this.team[0].current.IsFree() && this.team[0].current.centerStop == 0)
		{
			this.Win();
			return;
		}
	}
	else if (this.team[0].current.IsFree() && this.team[0].current.centerStop == 0 && this.team[1].current.centerStop == 0)
	{
		this.demoCount = 0;
		this.battleUpdate = function ()
		{
			this.demoCount++;

			if (this.demoCount == 60)
			{
				this.Win();
				return;
			}
		};
	}
}

function Double_KO()
{
	if (::story.stock <= 0)
	{
		this.Player_Defeat();
		return;
	}

	::story.stock--;

	if (this.boss_spell.len() <= 1)
	{
		this.Enemy_Defeat();
		return;
	}

	this.team[1].current.EndBossCard();
	local t_ = {};
	t_.count <- 60;
	t_.priority <- 210;
	::actor.SetEffect(640, 360, 1,00000000.0, ::actor.effect_class.EF_SpeedLine, t_);
	::actor.SetEffectLight(640, 360, 1001, 1);
	this.PlaySE(855);
	this.state = 64;
	this.demoCount = 0;
	this.enable_contact_test = false;
	this.enableTimeCount = false;
	this.endWinDemo = [
		false,
		false
	];
	this.endLoseDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	this.SetTimeStop(60);
	this.battleUpdate = this.Double_KO_Update;
}

function Double_KO_Update()
{
	if (this.team[0].current.command)
	{
		this.team[0].current.command.Update(this.team[0].current.direction, this.team[0].current.hitStopTime <= 0 && this.team[0].current.damageStopTime <= 0);
	}

	if (this.team[1].current.command)
	{
		this.team[1].current.command.Update(this.team[1].current.direction, this.team[1].current.hitStopTime <= 0 && this.team[1].current.damageStopTime <= 0);
	}

	this.demoCount++;

	if (this.demoCount > 60 && this.team[0].current.centerStop == 0 && (!this.team[1].current.isVisible || this.team[1].current.centerStop == 0))
	{
		this.demoCount = 0;
		this.battleUpdate = function ()
		{
			this.demoCount++;

			if (this.demoCount >= 60)
			{
				this.team[0].life = this.team[0].life_max;
				this.team[0].regain_life = this.team[0].life_max;
				this.team[0].damage_life = this.team[0].life_max;
				this.team[0].master.enableStandUp = true;
				this.team[0].slave.enableStandUp = true;
				this.team[1].current.stanCount = 0;
				this.team[1].current.stanBossCount = 0;
				this.team[1].current.enableStandUp = true;
				this.team[1].current.enableKO = false;
				this.Boss_Spell_Lost();
				this.Boss_Setting();
				this.Battle_Restart();
			}
		};
	}
}

function CenterDemo()
{
}

function CenterDemo_Update()
{
}

function Win()
{
	this.state = 32;
	this.demoCount = 0;
	this.endWinDemo = [
		false,
		false
	];
	this.skipDemo = [
		false,
		false
	];
	local a = this.team[0].current;

	if (!this.enable_KO_stand)
	{
		a.autoCamera = false;
		::camera.SetTarget(a.x, a.y - 20, 2,00000000.0, false);
	}

	if (this.enable_win_demo)
	{
		if (a.team.current == a.team.slave)
		{
			a.team.current.Team_Win();
		}
		else if (a.func_winDemo)
		{
			a.func_winDemo();
		}

		local t = {};
		t.winner <- a.type;
		t.team <- a.team;
		this.infoActor = [
			null,
			null
		];

		if (a.x <= 640)
		{
			this.infoActor[0] = a.SetEffect(880, 460, 1,00000000.0, ::actor.effect_class.Round_Call_Win1P, t).weakref();
			this.infoActor[1] = a.SetFreeObject(0, 600, 1,00000000.0, a.WinPlayerName_L, {}).weakref();
		}
		else
		{
			this.infoActor[0] = a.SetEffect(400, 460, 1,00000000.0, ::actor.effect_class.Round_Call_Win1P, t).weakref();
			this.infoActor[1] = a.SetFreeObject(1280, 600, 1,00000000.0, a.WinPlayerName_R, {}).weakref();
		}

		this.battleUpdate = function ()
		{
			if (this.endWinDemo[0] || this.endWinDemo[1])
			{
				this.Round_WinCall();
				return;
			}
		};
	}
	else
	{
		this.battleUpdate = function ()
		{
			if (this.team[0].current.IsFree() && this.team[0].current.centerStop == 0)
			{
				this.battleUpdate = function ()
				{
					this.demoCount++;

					if (this.demoCount == 60)
					{
						this.Round_WinCall();
						return;
					}
				};
			}
		};
	}
}

function Round_WinCall()
{
	this.battleUpdate = this.Game_WinCallUpdate;
	this.state = 32;
	this.demoCount = 0;
	this.skipDemo = [
		false,
		false
	];
}

function Game_WinCallUpdate()
{
	this.demoCount++;

	if (this.demoCount == 15)
	{
		if (this.infoActor)
		{
			foreach( a in this.infoActor )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}
		}

		if (this.enable_KO_stand)
		{
			::battle.team[1].current.enableStandUp = true;
			::battle.team[1].life = 1;
		}

		this.infoActor = null;
		this.state = 1;
		::talk.Begin("win");
		this.battleUpdate = null;
	}
}

function Lose()
{
	this.battleUpdate = this.Lose_Update;
	this.state = 32;
	this.demoCount = 0;
}

function Lose_Update()
{
	this.demoCount++;

	if (this.demoCount == 60)
	{
		this.state = 1;
		::talk.Begin("lose");
		this.battleUpdate = null;
	}
}

function Continue()
{
	this.demoCount = 0;
	this.battleUpdate = this.Continue_Update;
}

function Continue_Update()
{
	this.demoCount++;

	if (this.demoCount == 10)
	{
		::Dialog(1, ::menu.common.GetMessageText("_continue"), function ( t )
		{
			if (t)
			{
				::replay.disable_save = true;
				this.Continue_Restart();
			}
			else
			{
				this.battleUpdate = function ()
				{
					this.End();
				};
				::replay.Confirm(null);
			}
		}.bindenv(this), 0);
		return;
	}
}

function Continue_Restart()
{
	this.state = 128;
	::trophy.Continue();
	this.is_continued = true;
	::story.stock = this.story.stock_init;
	::story.continue_count++;
	this.demoCount = 0;
	this.battleUpdate = this.Continue_Restart_Update;
	::graphics.FadeOut(30);

	if (this.infoActor)
	{
		foreach( a in this.infoActor )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	}

	this.infoActor = null;
}

function Continue_Restart_Update()
{
	this.demoCount++;

	if (this.demoCount == 30)
	{
		::story.Continue();
	}
}

function Game_End()
{
}

function Game_End_Update()
{
}

function Go_NextStage()
{
	this.demoCount = 0;
	this.battleUpdate = this.Go_NextStage_Update;
}

function Go_NextStage_Update()
{
	this.demoCount++;

	if (this.demoCount == 10)
	{
		::graphics.FadeOut(120);
	}

	if (this.demoCount == 180)
	{
		::story.NextStage();
		this.battleUpdate = null;
	}
}

function Go_Ending()
{
	this.demoCount = 0;
	this.battleUpdate = this.Go_Ending_Update;
	::trophy.StoryClear();
}

function Go_Ending_Update()
{
	this.demoCount++;

	if (this.demoCount == 30)
	{
		::story.BeginEnding();
		this.battleUpdate = null;
	}

	if (this.demoCount == 300)
	{
		::story.NextStage();
		this.battleUpdate = null;
	}
}

function Enable_win_demo( t_ )
{
	this.enable_win_demo = t_;
}

function Enable_Boss_exp( t_ )
{
	this.enable_KO_exp = t_;
	local boss = this.team[1];

	if (this.boss_spell.len() <= 1 && this.enable_KO_exp)
	{
		boss.master.koExp = true;

		if (boss.slave)
		{
			boss.slave.koExp = true;
		}
	}
	else
	{
		boss.master.koExp = false;

		if (boss.slave)
		{
			boss.slave.koExp = false;
		}
	}
}

function Enable_BossKo_StandUp()
{
	this.enable_KO_exp = false;
	this.enable_KO_stand = true;
	local boss = this.team[1];
	boss.master.koExp = false;

	if (boss.slave)
	{
		boss.slave.koExp = false;
	}
}

function Move_TalkPosition()
{
	this.team[0].current.TalkPosition(null);
	this.team[1].current.TalkPosition(null);
}

function FightEndFunction()
{
	this.gauge.Hide();
	this.team[0].current.EndSpellCard();
	this.team[1].current.EndSpellCard();
	this.team[0].master.BuffReset();
	this.team[1].master.BuffReset();

	if (this.team[0].slave)
	{
		this.team[0].slave.BuffReset();
	}

	if (this.team[1].slave)
	{
		this.team[1].slave.BuffReset();
	}
}

function Live_Start()
{
	this.demoCount = 0;
	this.battleUpdate = this.Live_Start_Update;
	::graphics.FadeOut(60, null, 1,00000000.0, 1,00000000.0, 1,00000000.0);
}

function Live_Start_Update()
{
	this.demoCount++;

	if (this.demoCount == 60)
	{
		::stage.background.Switch();
	}

	if (this.demoCount == 90)
	{
		this.BeginCamera_LiveStart();
		::graphics.FadeIn(120);
	}
}

function Jyoon_Ban_ShionMode()
{
	if (this.team[0].slave.type == 18)
	{
		this.team[0].slave.shion_ban = true;
	}
}

function Ban_Slave()
{
	this.enable_slave = [
		false,
		false
	];
	this.team[0].slave_ban = -1;
	this.team[1].slave_ban = -1;
}

