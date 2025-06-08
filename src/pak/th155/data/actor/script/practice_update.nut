function MainLoopFirst()
{
	this.targetDist = this.target.x - this.x;
	this.targetHeight = this.target.y - this.y;

	if (this.colorFunction)
	{
		this.colorFunction.call(this);
	}

	this.Practice_CommonUpdate();

	if (this.team.index == 0)
	{
		if (this.command && this == this.team.current)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}
	}
	else if (!this.cpuState)
	{
		if (::config.practice.player2 == 4 && this.command && this == this.team.current)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}
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

function CommonPracticeLoop()
{
	this.command.rsv_x = 0;
	this.command.rsv_y = 0;
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
	this.command.Clear();
}

function Practice_CommonUpdate()
{
	if (::config.practice.player2 >= 3)
	{
		this.disableGuard = 0;
		this.autoGuard = false;
		this.autoBaria = 0;

		if (::config.practice.player2 == 3)
		{
			if (!this.cpuState)
			{
				this.Run_Basic_Com();
			}

			switch(::config.practice.difficulty)
			{
			case 0:
				this.com_level = 0;
				break;

			case 1:
				this.com_level = 33;
				break;

			case 2:
				this.com_level = 66;
				break;

			case 3:
				this.com_level = 100;
				break;
			}
		}
		else if (this.cpuState)
		{
			this.Break_Basic_Com();
		}
	}
	else
	{
		if (::config.practice.guard_mode == 0 && ::config.practice.ex_guard_mode == 0)
		{
			this.disableGuard = -1;
		}
		else
		{
			this.disableGuard = 0;

			switch(::config.practice.ex_guard_mode)
			{
			case 0:
				this.autoBaria = 0;
				break;

			case 1:
				this.autoBaria = 1;
				break;

			case 2:
				if (this.autoBaria <= 1 || this.autoBaria >= 4)
				{
					this.autoBaria = 2;
				}

				break;
			}

			switch(::config.practice.guard_mode)
			{
			case 1:
				this.autoGuard = true;
				break;

			case 2:
				if (this.rand() % 100 < 50)
				{
					this.autoGuard = true;
				}
				else
				{
					this.autoGuard = false;
				}

				break;

			case 3:
				if (this.IsDamage() && this.autoGuard == false)
				{
					this.autoGuard = true;
				}

				if (this.IsGuard() && this.autoGuard)
				{
					this.autoGuard = false;
				}

				break;
			}
		}

		if (this.team.index == 1)
		{
			switch(::config.practice.player2)
			{
			case 0:
				if (this.cpuState)
				{
					this.Break_Basic_Com();
				}

				if (this.IsFree())
				{
					this.Practice_Com_Wait();
				}

				break;

			case 1:
				if (this.cpuState)
				{
					this.Break_Basic_Com();
				}

				if (this.IsFree())
				{
					this.Practice_Com_SlideUpper();
				}

				break;

			case 2:
				if (this.cpuState)
				{
					this.Break_Basic_Com();
				}

				if (this.IsFree())
				{
					this.Practice_Com_SlideUnder();
				}

				break;

			case 3:
				if (!this.cpuState)
				{
					this.Run_Basic_Com();
				}

				switch(::config.practice.difficulty)
				{
				case 0:
					this.com_level = 0;
					break;

				case 1:
					this.com_level = 33;
					break;

				case 2:
					this.com_level = 66;
					break;

				case 3:
					this.com_level = 100;
					break;
				}

				break;

			default:
				if (this.cpuState)
				{
					this.Break_Basic_Com();
				}

				break;
			}

			if (this.IsDamage() >= 2)
			{
				switch(::config.practice.recover_mode)
				{
				case 1:
					this.input.b0 = 1;

					if (this.direction > 0)
					{
						this.input.x = 1;
					}
					else
					{
						this.input.x = -1;
					}

					break;

				case 2:
					this.input.b0 = 1;

					if (this.direction < 0)
					{
						this.input.x = 1;
					}
					else
					{
						this.input.x = -1;
					}

					break;

				case 3:
					this.input.b0 = 1;

					if (this.rand() % 100 < 50)
					{
						this.input.x = 1;
					}
					else
					{
						this.input.x = -1;
					}

					break;
				}
			}
		}
	}

	if (::config.practice.counter_mode)
	{
		this.force_counter = 1;

		if (::config.practice.counter_mode == 2)
		{
			this.force_counter = this.rand() % 2;
		}
	}
	else
	{
		this.force_counter = 0;
	}
}

function Practice_Com_Wait()
{
	this.CommonPracticeLoop();

	if (::config.practice.position[1] > 0)
	{
		local pos_ = 1280 * (::config.practice.position[1] - 1) / 20;
		local dist_ = this.abs(pos_ - this.x);

		if (dist_ <= 30)
		{
			this.auto_pos = false;
		}
		else if (dist_ >= 90)
		{
			this.auto_pos = true;
		}

		if (this.auto_pos)
		{
			if (pos_ - this.x < 0)
			{
				this.input.x = -10;
			}
			else
			{
				this.input.x = 10;
			}
		}
		else
		{
			this.input.x = 0;
		}
	}
}

function Practice_Com_SlideUpper()
{
	this.CommonPracticeLoop();

	if (::config.practice.position[1] > 0)
	{
		local pos_ = 1280 * (::config.practice.position[1] - 1) / 20;
		local dist_ = this.abs(pos_ - this.x);

		if (dist_ <= 30)
		{
			this.auto_pos = false;
		}
		else if (dist_ >= 90)
		{
			this.auto_pos = true;
		}

		if (this.auto_pos)
		{
			if (pos_ - this.x < 0)
			{
				this.input.x = -10;
			}
			else
			{
				this.input.x = 10;
			}
		}
		else
		{
			this.input.x = 0;

			if (this.centerStop * this.centerStop <= 1)
			{
				this.input.y = -10;
			}
		}
	}
	else
	{
		this.input.x = 0;

		if (this.centerStop * this.centerStop <= 1)
		{
			this.input.y = -10;
		}
	}
}

function Practice_Com_SlideUnder()
{
	this.CommonPracticeLoop();

	if (::config.practice.position[1] > 0)
	{
		local pos_ = 1280 * (::config.practice.position[1] - 1) / 20;
		local dist_ = this.abs(pos_ - this.x);

		if (dist_ <= 30)
		{
			this.auto_pos = false;
		}
		else if (dist_ >= 90)
		{
			this.auto_pos = true;
		}

		if (this.auto_pos)
		{
			if (pos_ - this.x < 0)
			{
				this.input.x = -10;
			}
			else
			{
				this.input.x = 10;
			}
		}
		else
		{
			this.input.x = 0;

			if (this.centerStop * this.centerStop <= 1)
			{
				this.input.y = 10;
			}
		}
	}
	else
	{
		this.input.x = 0;

		if (this.centerStop * this.centerStop <= 1)
		{
			this.input.y = 10;
		}
	}
}

