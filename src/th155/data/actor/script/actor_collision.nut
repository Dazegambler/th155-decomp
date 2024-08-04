function FitBoxfromSprite()
{
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
}

function FitRotatefromVec()
{
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
}

function StoreActorData()
{
	this.temp_frame_data = this.GetKeyFrameData();
	this.temp_atk_data = ::battle.temp_actor_data[::battle.temp_actor_data_index++];
	this.temp_atk_data.direction = this.direction;
	this.temp_atk_data.attackLV = this.attackLV;
	this.temp_atk_data.atk_id = this.atk_id;
	this.temp_atk_data.disableGuard = false;
	this.attack_state = this.flagAttack & 16777216 ? 2 : 1;

	if (this.flagAttack & 16)
	{
		this.attack_state += 4;
	}
}

function StoreShotActorData()
{
	this.temp_frame_data = this.GetKeyFrameData();
	this.temp_atk_data = ::battle.temp_actor_data[::battle.temp_actor_data_index++];
	this.temp_atk_data.direction = this.direction;
	this.temp_atk_data.attackLV = this.attackLV;
	this.temp_atk_data.atk_id = this.atk_id;
	this.temp_atk_data.cancelCount = this.cancelCount;
	this.temp_atk_data.disableGuard = false;
	this.attack_state = this.flagAttack & 16777216 ? 2 : 1;

	if (this.flagAttack & 16)
	{
		this.attack_state += 4;
	}
}

function CalcContactTestParam()
{
	this.CalcContactTestHit();
	this.CalcContactTestGuard();
}

function CalcContactTestHit()
{
	this.catch_state = 0;

	if (this.flagState & 524288)
	{
		this.catch_state = 1;
	}

	if (this.flagState & 4194304)
	{
		this.catch_state = this.catch_state | 2;
	}

	this.graze_state = 0;

	if (this.flagState & 4096 || this.graze > 0)
	{
		this.graze_state = 2;
	}

	this.hit_state = 0;

	if (this.invinBoss)
	{
		return;
	}

	if (this.damageStopTime <= 0 && this.recover == 0 && this.stanBossCount == 0 && this.IsDamage() == 2)
	{
		return;
	}

	if (this.hitTarget == null)
	{
		return;
	}

	if (this.baria)
	{
		return;
	}

	if ((this.flagState & 65536) == 0 && !this.invinObject)
	{
		this.hit_state = this.hit_state | 2;
	}

	if ((this.flagState & 32768) == 0 && !this.invin)
	{
		this.hit_state = this.hit_state | 1;
	}

	if ((this.flagState & 8192) == 0 && !this.invinGrab)
	{
		this.hit_state = this.hit_state | 4;
	}
}

function CalcContactTestGuard()
{
	if (this.disableGuard || this.disableGuard || !(this.flagState & (16 | 2048)))
	{
		this.guard_state = 0;
		return;
	}

	if (this.IsGuard() > 0)
	{
		this.guard_state = 1;
		return;
	}

	if (this.flagState & 2048)
	{
		this.guard_state = 2;
		return;
	}

	if (this.autoGuard)
	{
		this.guard_state = 1;
		return;
	}

	if (this.cpuState)
	{
		this.guard_state = this.rand() % 100 <= this.com_guard_rate ? 1 : 0;
		return;
	}
	else
	{
		if (this.target.x == this.x)
		{
			if (this.direction > 0,00000000.0)
			{
				if (this.input.x < 0)
				{
					this.guard_state = 1;
					return;
				}
			}
			else if (this.input.x > 0)
			{
				this.guard_state = 1;
				return;
			}
		}
		else if (this.target.x > this.x)
		{
			if (this.input.x < 0)
			{
				this.guard_state = 1;
				return;
			}
		}
		else if (this.input.x > 0)
		{
			this.guard_state = 1;
			return;
		}

		if (this.autoGuardCount > 0)
		{
			if (this.input.x)
			{
				this.guard_state = 1;
				return;
			}
		}
	}

	this.guard_state = 0;
}

