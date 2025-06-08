function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel.call(this);
			}

			return true;
		}
		else
		{
			return false;
		}
	}

	if (::battle.state == 8)
	{
		if (this.IsDamage())
		{
			if (this.attackType[2] == 100 || this.attackType[2] == 102 || this.attackType[2] == 150 || this.attackType[2] == 160 || this.attackType[2] == 161 || this.attackType[2] == 162)
			{
				this.autoCount[2] = 0;
				this.preAutoCount[2] = 0;
				this.autoAttack[2] = null;
				this.autoFunc[2] = null;
				this.timeFunc[2] = null;
				this.attackType[2] = 0;
				this.autoCancelLevel[2] = 0;
				this.autoAttackTimes[2] = 0;
				this.autoTable[2] = {};
				this.sence[2].func[0].call(this.sence[2]);
			}
		}

		if (this.boss_cpu)
		{
			this.boss_cpu();
		}
		else if (this.cpuState)
		{
			this.cpuState();

			if (this.input && this.team.current == this)
			{
				this.Update_Input();
			}
		}
	}
	else
	{
	}

	if (this.team.combo_stun >= 100 || this.IsDamage() >= 2 || this.team.life <= 0)
	{
		this.autoCount = [
			0,
			0,
			0
		];
		this.preAutoCount = [
			0,
			0,
			0
		];
		this.autoAttack = [
			null,
			null,
			null
		];
		this.autoFunc = [
			null,
			null,
			null
		];
		this.timeFunc = [
			null,
			null,
			null
		];
		this.attackType = [
			0,
			0,
			0
		];
		this.autoCancelLevel = [
			0,
			0,
			0
		];
		this.autoAttackTimes = [
			0,
			0,
			0
		];
		this.autoTable = [
			{},
			{},
			{}
		];
		this.sence[0].func[0].call(this.sence[0]);
		this.sence[1].func[0].call(this.sence[1]);
		this.sence[2].func[0].call(this.sence[2]);
	}

	this.MainLoop();
	this.sneeze--;
	return true;
}

function Update_Input()
{
	if (this.AutoAttackCheck())
	{
		return;
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				this.SP_B_First_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_F_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				this.SP_E_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				local t_ = {};
				t_.force <- false;
				this.SP_D2_Init(t_);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x == 0)
			{
				this.SP_G_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0)
	{
		if (this.motion >= 1200 && this.motion <= 1299 && this.Cancel_Check(40))
		{
			if (this.command.rsv_y > 0)
			{
				this.Atk_HighUnder_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y < 0)
			{
				this.Atk_HighUpper_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.Atk_HighFront_Set(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 90)
	{
		if (this.team.current.target.invinGrab == 0 && !(this.target.flagState & 8192) && !this.target.IsDamage())
		{
			if (this.Cancel_Check(1))
			{
				this.Atk_Grab_Init(null);
				return true;
			}
		}
	}

	if (this.Input_CommonAttack())
	{
		return true;
	}

	this.InputMove();
}

