function ConvertTotalSpeed()
{
	if (this.vx_slow)
	{
		this.vx = this.va.x * 0,25000000.0 + this.vf.x + this.vfBaria.x;
		this.vy = this.va.y + this.vf.y + this.vfBaria.y;
	}
	else
	{
		this.vx = this.va.x + this.vf.x + this.vfBaria.x;
		this.vy = this.va.y + this.vf.y + this.vfBaria.y;
	}
}

function ResetSpeed()
{
	this.vx = 0,00000000.0;
	this.vy = 0,00000000.0;
	this.va.x = 0,00000000.0;
	this.va.y = 0,00000000.0;
	this.vf.x = 0,00000000.0;
	this.vf.y = 0,00000000.0;
	this.vfBaria.x = 0,00000000.0;
	this.vfBaria.y = 0,00000000.0;
	this.vx_slow = 0;
	this.hitBackFlag = 0;
	this.bariaBackFlag = 0;
	this.ConvertTotalSpeed();
}

function FullRecover()
{
	this.team.life = this.team.life_max;
	this.team.regain_life = this.team.life_max;
	this.guardMax = this.guardMaxBase;
	this.guard = this.guardMax;
	this.team.mp = 1000;
	this.team.mp_stop = 0;
	this.autoGuard = false;
	this.autoBaria = 0;
	this.autoEvade = 0;
	this.disableGuard = 0;
}

function SetSelfDamage( damage_ )
{
	if (::battle.state == 8)
	{
		this.team.life -= damage_;

		if (this.team.life <= 0)
		{
			this.team.life = 1;
		}
	}
}

function LifeRecover()
{
	if (::battle.state & (8 | 256))
	{
		if (this.team.regain_life < this.team.life)
		{
			this.team.regain_life = this.team.life;
		}
		else
		{
			this.team.life = this.team.regain_life;
		}
	}
}

function Guard_ADD( add_ )
{
	if (this.guard + add_ >= this.guardMax)
	{
		this.guard = this.guardMax;
	}
	else if (this.guard + add_ < 0)
	{
		this.guard = 0;
	}
	else
	{
		this.guard += add_;
	}
}

function GuardCrash_Param()
{
}

function SetTimeStop( time )
{
	if (time <= 0)
	{
		this.team.time_stop_count = 0;
	}
	else
	{
		this.team.time_stop_count = time;
		this.team.time_stop_mask = this.group | this.team.group_nonstop;
	}
}

function SetTeamTimeStop( time )
{
	if (time <= 0)
	{
		this.team.time_stop_count = 0;
	}
	else
	{
		this.team.time_stop_count = time;
		this.team.time_stop_mask = this.team.group_team | this.team.group_nonstop;
	}
}

function SetTimeSlow( x_ )
{
	this.team.slow_count = x_;
}

function GetDamageReset()
{
	if (this.event_getAttack)
	{
		if (this.event_getAttack.call(this))
		{
			this.event_getAttack = null;
		}
	}

	this.rx = 0,00000000.0;
	this.ry = 0,00000000.0;
	this.rz = 0,00000000.0;
	this.FitBoxfromSprite();
	this.freeMap = false;
	this.collisionFree = false;
	this.afterImage = null;
}

function GetGuardReset()
{
	if (this.event_getAttack)
	{
		if (this.event_getAttack.call(this))
		{
			this.event_getAttack = null;
		}
	}

	this.rx = 0,00000000.0;
	this.ry = 0,00000000.0;
	this.rz = 0,00000000.0;
	this.FitBoxfromSprite();
	this.freeMap = false;
	this.collisionFree = false;
	this.afterImage = null;
}

function SetRecoverFrame( t )
{
	if (t < 0)
	{
		this.recover = -t.tointeger();
	}
	else if (this.team.combo_stun >= 100)
	{
		this.recover = 0;
	}
	else
	{
		this.recover = (t * this.team.damage_scale).tointeger();
	}
}

function KnockBackTarget( dir_ )
{
	local _frame_data = this.GetKeyFrameData();

	if (this.atkOwner)
	{
		this.target.damageTarget = this.atkOwner.weakref();
	}
	else
	{
		this.target.damageTarget = this.weakref();
	}

	local _min_scale = 0,10000000.0;

	if (_frame_data.flagAttack & 256)
	{
		_min_scale = 0,20000000.0;
	}

	if (_frame_data.flagAttack & 512)
	{
		_min_scale = 0,25000000.0;
	}

	local dam_ = this.target.team.SetComboDamage.call(this.target.team, this, _frame_data.damagePoint, _min_scale);
	this.team.AddSP(_frame_data.addSP);
	this.target.team.AddSP(dam_ * 0,10000000.0);

	if (this.flagAttack & 2097152)
	{
		this.target.SetRecoverFrame.call(this.target, -_frame_data.recover);
	}
	else
	{
		this.target.SetRecoverFrame.call(this.target, _frame_data.recover);
	}

	if (this.target.team.combo_stun < 100 && this.target.team.combo_stun + _frame_data.addStan >= 100)
	{
		local t_ = {};
		t_.num <- 3;
		local dam_ = this.target.team.combo_damage;

		while (dam_ > 0)
		{
			if (dam_ >= 5000)
			{
				dam_ = dam_ - 1000;
				t_.num++;
			}
			else if (dam_ >= 3000)
			{
				dam_ = dam_ - 500;
				t_.num++;
			}
			else if (dam_ >= 1000)
			{
				dam_ = dam_ - 250;
				t_.num++;
			}
			else
			{
				dam_ = 0;
				t_.num++;
			}
		}

		this.PlaySE(842);
		local t = {};
		this.target.SetFreeObject(this.target.x, this.target.y, this.direction, this.target.Occult_PowerCreatePoint, t_);
		this.SetEffect(this.target.x, this.target.y, this.direction, ::actor.effect_class.EF_StanStar, {}, this.target.weakref());
	}

	this.target.team.combo_stun += _frame_data.addStan;

	if (this.target.team.combo_stun >= 100)
	{
		this.target.team.combo_stun = 100;
		this.target.stanCount = 60;
	}

	if (this.target.team.combo_count == 0)
	{
		this.target.minRate = 1,00000000.0;
		this.target.team.SetDamageScale(_frame_data.firstRate * 0,00100000.0);
	}
	else
	{
		this.target.team.SetDamageScale(_frame_data.comboRate * 0,00100000.0);
	}

	local t_ = this.HitState();
	t_.damage = dam_;
	t_.direction = dir_;

	if (this.actorType & (1 | 4))
	{
		t_.knockFlag = 1;
	}
	else if (this.actorType & 2)
	{
		t_.knockFlag = 2;
	}
	else
	{
		t_.knockFlag = 0;
	}

	t_.atkRank = _frame_data.atkRank;
	t_.atkType = _frame_data.atkType;
	t_.hitVecX = _frame_data.hitVecX * 0,01000000.0;
	t_.hitVecY = _frame_data.hitVecY * 0,01000000.0;
	t_.grazeKnock = _frame_data.grazeKnock * 0,01000000.0;
	t_.stopVecX = _frame_data.stopVecX * 0,01000000.0;
	t_.stopVecY = _frame_data.stopVecY * 0,01000000.0;
	t_.recover = _frame_data.recover;
	t_.forceKnock = _frame_data.flagAttack & 2097152;
	this.target.damageStopTime = _frame_data.hitStopE;
	this.target.PlayerhitAction_Normal.call(this.target, t_);
}

function KnockBackSetValue( t_ )
{
	this.GetDamageReset();
	this.hitBackFlag = t_.knockFlag;
	this.forceKnock = t_.forceKnock;
	this.dashCount = 0;
	this.slideCount = 0;
	this.airSlide = false;
}

