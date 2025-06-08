function CPU_Update_VS()
{
	this.CommonCpuLoop(null);
	this.CPU_EnemySearch(150, 300);
	this.CPU_CommonUpdate();
}

function CPU_PracticeUpdate()
{
	this.CommonCpuLoop(null);
	this.CPU_EnemySearch(150, 300);
	this.CPU_CommonUpdate_Arcade();
}

function CPU_ArcadeUpdate()
{
	this.CommonCpuLoop(null);
	this.CPU_EnemySearch(150, 300);
	this.CPU_CommonUpdate_Arcade();
}

function MainLoopFirst()
{
	this.targetDist = this.target.x - this.x;
	this.targetHeight = this.target.y - this.y;

	if (this.colorFunction)
	{
		this.colorFunction.call(this);
	}

	if (this.spellBackTime > 0)
	{
		this.spellBackTime--;
	}

	if (this.disableDash > 0)
	{
		this.disableDash--;
	}

	if (this.autoGuardCount > 0)
	{
		this.autoGuardCount--;
	}

	if (this.forceBariaCount > 0)
	{
		this.forceBariaCount--;
	}

	if (this.disableGuard > 0)
	{
		this.disableGuard--;
	}

	this.team_update.call(this.team);

	if (this.IsGuard() == 3)
	{
		if (this.input.x * this.direction <= 0.00000000 && this.input.y == 0 && this.input.b4 == 1 || this.autoBaria == 1 || this.autoBaria == 2)
		{
			local t_ = {};
			t_.atkRank <- this.flag1;
			t_.atk <- this.flag2;
			this.BariaGuard_Input(t_);
		}
	}

	if (this.damageStopTime > 0)
	{
		this.damageStopTime--;
		this.hitStopTime = 0;
		return false;
	}

	if (this.hitStopTime > 0)
	{
		this.hitStopTime--;
		return false;
	}

	return true;
}

function CommonCpuLoop( t )
{
	this.command.rsv_k0 = 0;
	this.command.rsv_k1 = 0;
	this.command.rsv_k2 = 0;
	this.command.rsv_k3 = 0;
	this.command.rsv_k3_r = 0;
	this.command.rsv_k4 = 0;
	this.command.rsv_k5 = 0;
	this.command.rsv_k01 = 0;
	this.command.rsv_k12 = 0;
	this.command.rsv_k23 = 0;
	this.input.b0 = 0;
	this.input.b1 = 0;
	this.input.b2 = 0;
	this.input.b3 = 0;
	this.input.b4 = 0;
	this.input.b5 = 0;
	this.input.x = 0;
	this.input.y = 0;
	this.com_dash = 0.00000000;
	this.com_command = 0;

	foreach( val, a in this.com_count )
	{
		this.com_count[val]++;
	}

	if (this.com_aggro_stance > 0)
	{
		this.com_aggro_stance--;
	}
}

function CPU_CommonUpdate()
{
	this.com_senser.Update();
	this.com_search[0] = this.com_senser.GetCenter();

	for( local i = 0; i < 8; i++ )
	{
		this.com_search[1][i] = this.com_senser.GetInner(i);
	}

	for( local i = 0; i < 8; i++ )
	{
		this.com_search[2][i] = this.com_senser.GetOuter(i);
	}

	if (this.IsGuard() || this.IsDamage())
	{
		this.com_subState = [
			this.CPU_Defence,
			null,
			this.CPU_MoveBase,
			this.CPU_AttackBase
		];
		this.com_count = [
			0,
			0,
			0,
			0
		];
		this.com_search = [
			this.array(1, 0),
			this.array(8, 0),
			this.array(8, 0)
		];
		this.com_aggro_stance = 0;
	}

	if (this.target.IsDamage())
	{
		this.com_aggro_stance = 180;
	}

	if (this.target.IsGuard())
	{
		if (this.com_aggro_stance <= 0)
		{
			this.com_aggro_stance = 60;
		}
	}

	if (this.com_stackState.len() > 0)
	{
		this.com_subState = [
			this.CPU_Defence,
			null,
			this.CPU_MoveBase,
			this.CPU_AttackBase
		];

		if (this.com_stackState[0].state.call(this, this.com_stackState[0].table))
		{
			this.com_stackState.remove(0);
		}
	}
	else
	{
		if (this.COM_StackBase())
		{
			return;
		}

		this.com_sleep--;

		if (this.com_sleep > 0)
		{
			return;
		}

		if (this.com_sleep <= -60)
		{
			if (this.rand() % 80 >= this.com_level)
			{
				this.com_sleep = 30 + this.rand() % 15;
			}
			else
			{
				this.com_sleep = 0;
			}
		}

		if (this.com_subState[0])
		{
			if (this.com_subState[0].call(this))
			{
				this.com_subState[1] = null;
				this.com_subState[2] = this.CPU_MoveBase;
				this.com_subState[3] = null;
			}
		}

		if (this.com_guard_stance <= 0)
		{
			if (this.com_subState[1])
			{
				if (this.com_subState[1].call(this))
				{
					this.com_subState[1] = null;
				}
			}
			else
			{
				if (this.com_subState[2])
				{
					if (this.com_subState[2].call(this))
					{
						this.com_subState[2] = this.CPU_MoveBase;
					}
				}

				if (this.com_subState[3])
				{
					if (this.com_subState[3].call(this))
					{
						this.com_subState[3] = this.CPU_AttackBase;
					}
				}
			}
		}
		else if (this.com_subState[2])
		{
			if (this.com_subState[2].call(this))
			{
				this.com_subState[2] = this.CPU_MoveBase;
			}
		}
	}
}

function COM_StackBase()
{
}

