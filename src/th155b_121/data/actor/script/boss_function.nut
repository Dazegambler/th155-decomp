function AI_BossCommon()
{
	this.vf = this.Vector3();
	this.va = this.Vector3();
	this.vfBaria = this.Vector3();
	this.SetContactTestCallbackFunction(this.StoreActorData);
	this.hitOwner = this.weakref();
	this.hitTarget = {};
	this.owner = this.weakref();
	this.actorType = 1;
	this.hitAction = this.PlayerhitAction_Boss;
	this.guardAction = this.PlayerGuardAction_Normal;
	this.justGuardAction = this.PlayerGuardAction_Just;
	this.enableJustGuard = true;
	this.guardMissAction = this.PlayerMissGuardAction_Normal;
	this.guardCrashAction = this.PlayerGuardCrashAction_Normal;
	this.colorFunction = this.CommonColorUpdate;
	this.func_beginDemo = this.CommonBegin;
	this.func_beginDemoSkip = this.CommonBeginBattleSkip;
	this.func_timeDemo = this.CommonWin;
	this.func_winDemo = this.CommonWin;
	this.spellList = [];
	this.SetEndTakeCallbackFunction(this.KeyActionCheck);
}

function Team_Change_Boss()
{
	if (this.team.slave == null)
	{
		return false;
	}

	this.rx = 0,00000000.0;
	this.ry = 0,00000000.0;
	this.rz = 0,00000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.FitBoxfromSprite();
	this.hitBackFlag = 0;
	this.freeMap = false;
	this.collisionFree = false;
	this.team.Change();
	this.target.team.current.target = this.target.team.target.weakref();
	this.team.current.target = this.team.target.weakref();
	this.team.current.direction = this.direction;
	this.team.current.centerStop = this.centerStop;
	this.team.current.centerStopCheck = this.y < this.centerY ? -1 : 1;
	this.change_reserve = false;
	this.team.current.change_reserve = false;
	this.BuffReset();
	this.team.current.DrawActorPriority(190);
	this.team.current.masterAlpha = 1,00000000.0;
	this.team.current.direction = this.direction;
	this.team.current.Warp(this.x, this.y);
	this.change_reset();

	if (this.team.current == this.team.master)
	{
		this.team.master.team_update = this.Team_Update_Boss;

		if (this.team.slave.hyouiAura)
		{
			this.team.slave.hyouiAura.func();
		}
	}
	else
	{
		this.team.current.hyouiAura = this.SetEffect(this.team.current.x, this.team.current.y, 1,00000000.0, this.Hyoui_Aura, {}, this.team.current.weakref()).weakref();
		this.team.master.team_update = this.Team_Update_Boss;
	}
}

function Team_Update_Boss()
{
	if (::battle.state == 8)
	{
		if (this.mp_stop > 0)
		{
			this.mp_stop--;
		}
		else
		{
			this.AddMP(4, 0);
		}
	}
}

function CallBossCard( time_, name_ )
{
	this.EndBossCard();
	this.SetSpellBack(true);
	this.SetTimeStop(time_);
	this.team.spell_active = true;
	this.team.spell_time = 9999;

	if (::battle.boss_spell[0].master_name.len() > 0)
	{
		this.team.master.spellcard.Activate(::battle.boss_spell[0].master_name);
	}

	this.SetFreeObject(640 - 640, 720, -1,00000000.0, this.SpellUseFace, {});
	this.PlaySE(826);
}

function EndBossCard()
{
	if (!this.team.spell_active)
	{
		return;
	}

	this.boss_shot.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.SetEffect(this.x, this.y, this.direction, this.Boss_SpellBreak, {});
	this.SetSpellBack(false);
	this.team.spell_time = 0;
	this.boss_shot.Foreach(function ()
	{
		this.func[0].call(this);
	});

	if (this.boss_spell_end_func)
	{
		this.boss_spell_end_func();
		this.spellEndFunc = null;
	}

	this.team.spell_active = false;
	this.team.master.spellcard.Deactivate();

	if (this.team.slave)
	{
		this.team.slave.spellcard.Deactivate();
	}
}

function BossDamageFunc( d_ )
{
	if (this.team.shield)
	{
		if (this.team.regain_life <= this.team.life)
		{
			if (this.team.slave && this.team.slave == this && this.team.current == this.team.slave)
			{
				this.Boss_ChangeCurrent();

				if (this.team.regain_life > this.team.life)
				{
					this.team.regain_life = this.team.life;
				}

				this.boss_shot.Foreach(function ()
				{
					this.func[0].call(this);
				});
				::camera.Shake(10);
				local t_ = {};
				t_.count <- 15;
				t_.priority <- 210;
				this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
				this.Set_Boss_Shield(null);
				this.team.current.SpellCrash_Init(null);
				return;
			}
		}

		this.team.shield.func[3].call(this.team.shield);

		if (this.shield_rate == 1)
		{
			this.PlaySE(881);
		}
	}
}

function Set_Boss_Shield( life_ )
{
	if (life_ == null)
	{
		if (this.team.shield)
		{
			this.team.shield.func[0].call(this.team.shield);
		}

		if (this.team.master.armor < 0)
		{
			this.team.master.armor = 0;
		}

		if (this.team.slave && this.team.slave.armor < 0)
		{
			this.team.slave.armor = 0;
		}

		this.team.shield = null;
		this.team.master.baseDefRate = 1,00000000.0;
		this.team.master.DamageBuffAjust();

		if (this.team.slave)
		{
			this.team.slave.baseDefRate = 1,00000000.0;
			this.team.slave.DamageBuffAjust();
		}
	}
	else
	{
		this.team.master.baseDefRate = 0,33000001.0;
		this.team.master.DamageBuffAjust();

		if (this.team.slave)
		{
			this.team.slave.baseDefRate = 1,00000000.0;
			this.team.slave.DamageBuffAjust();
		}

		this.team.regain_life = this.team.life + life_;

		if (this.team.regain_life > this.team.life_max)
		{
			this.team.regain_life = this.team.life_max;
		}

		if (this.team.shield == null)
		{
			this.team.shield = this.SetEffect(this.x, this.y, 1,00000000.0, this.EF_Boss_Shield, {}, this.weakref()).weakref();
			this.armor = -1;

			if (this.team.slave)
			{
				this.team.slave.armor = -1;
			}
		}

		this.Set_BossSpellBariaRate(1);
	}
}

function Set_BossSpellBariaRate( rate_ )
{
	if (this.team.shield)
	{
		this.team.master.shield_rate = rate_;

		if (this.team.slave)
		{
			this.team.slave.shield_rate = rate_;
		}

		if (rate_ > 1)
		{
			this.team.master.baseDefRate = 1,00000000.0;
			this.team.master.DamageBuffAjust();
			this.PlaySE(873);
			this.team.shield.func[2].call(this.team.shield);
		}
		else
		{
			this.team.master.baseDefRate = 0,33000001.0;
			this.team.master.DamageBuffAjust();
			this.team.shield.func[1].call(this.team.shield);
		}
	}
}

function Common_BossKoEvent()
{
	this.Set_Boss_Shield(null);
}

