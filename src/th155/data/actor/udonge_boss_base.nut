function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel();
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
		if (this.skillE_air && this.motion != 3040 && this.centerStop * this.centerStop <= 1)
		{
			this.skillE_air = false;
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

	this.MainLoop();
	return true;
}

function Update_Input()
{
	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				if (this.centerStop * this.centerStop >= 4)
				{
					local tab_ = {};
					tab_.rush <- false;

					if (this.SP_C_Air_Init(tab_))
					{
						this.command.ResetReserve();
						return true;
					}
				}
				else
				{
					local tab_ = {};
					tab_.rush <- false;

					if (this.SP_C_Init(tab_))
					{
						this.command.ResetReserve();
						return true;
					}
				}
			}

			if (this.command.rsv_y > 0)
			{
				if (this.SP_D_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					if (this.SP_A_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x * this.direction < 0)
				{
					if (this.centerStop * this.centerStop >= 4)
					{
						if (this.SP_B_Air_Init(null))
						{
							this.command.ResetReserve();
							return true;
						}
					}
					else if (this.SP_B_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x == 0 && this.skillE_air == false)
				{
					if (this.centerStop * this.centerStop >= 4)
					{
						if (this.SP_E_Init(null))
						{
							this.command.ResetReserve();
							return true;
						}
					}
					else if (this.SP_E_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 60)
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

function UdongeColorUpdate()
{
	if (this.team.current == this)
	{
		if (this.life > 0)
		{
			if (this.hide)
			{
				this.masterAlpha = 0;
			}
			else if (this.vision)
			{
				this.masterAlpha = 0,50000000.0;
			}
			else
			{
				local c_ = false;

				if (this.motion == 41 && (this.keyTake == 1 || this.keyTake == 2))
				{
					this.masterAlpha -= 0,15000001.0;

					if (this.masterAlpha <= 0)
					{
						this.masterAlpha = 0;
					}

					c_ = true;
				}

				if (this.motion == 40)
				{
					if (this.keyTake == 3)
					{
						this.masterAlpha -= 0,10000000.0;

						if (this.masterAlpha <= 0,00000000.0)
						{
							this.masterAlpha = 0,00000000.0;
						}

						c_ = true;
					}

					if (this.keyTake == 4)
					{
						this.masterAlpha += 0,05000000.0;

						if (this.masterAlpha >= 0,50000000.0)
						{
							this.masterAlpha = 0,50000000.0;
						}

						c_ = true;
					}
				}

				if (!c_)
				{
					if (this.masterAlpha >= 0,94999999.0)
					{
						this.masterAlpha = 1,00000000.0;
					}
					else
					{
						this.masterAlpha += 0,10000000.0;
					}
				}
			}
		}
		else if (this.masterAlpha >= 0,94999999.0)
		{
			this.masterAlpha = 1,00000000.0;
		}
		else
		{
			this.masterAlpha += 0,10000000.0;
		}

		this.masterBlue = this.masterGreen = this.masterAlpha;
	}

	this.CommonColorUpdate();
}

function Input_CommonAttack()
{
	if (this.team.mp >= 200)
	{
		if (this.input.b1 >= 12 && this.input.b1 <= 20)
		{
			if (this.Cancel_Check(40, 200, 0, true) || this.motion >= 2000 && this.motion <= 2019)
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					local t_ = {};
					t_.ky <- this.input.y;
					t_.kx <- this.input.x;
					this.Shot_Charge_Init(t_);
					this.command.ResetReserve();
					return true;
				}
				else
				{
					local t_ = {};
					t_.ky <- this.input.y;
					t_.kx <- this.input.x;
					this.Shot_Charge_Air_Init(t_);
					this.command.ResetReserve();
					return true;
				}
			}
		}
	}

	if (this.command.rsv_k1)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.motion == 40 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
			{
				if (this.Cancel_Check(30))
				{
					if (this.keyTake <= 4)
					{
						if (this.keyTake >= 3)
						{
							if (this.GetFront())
							{
								this.Atk_HighDash_R_Init(null);
								this.command.ResetReserve();
								return true;
							}
							else
							{
								this.Atk_HighDash_Init(null);
								this.command.ResetReserve();
								return true;
							}
						}

						this.Atk_HighDash_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}

		if (this.team.mp > 0)
		{
			if (this.flagState & 1024 || this.Cancel_Check(45, 200, 0, false))
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.cancelLV <= 45)
					{
						if (this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
						{
							this.Shot_Front_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}

					if (this.cancelLV <= 40)
					{
						if (this.command.rsv_y > 0)
						{
							this.Shot_Normal_Under_Init(null);
							this.command.ResetReserve();
							return true;
						}

						if (this.command.rsv_y < 0)
						{
							this.Shot_Normal_Upper_Init(null);
							this.command.ResetReserve();
							return true;
						}

						this.Shot_Normal_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
				else
				{
					if (this.cancelLV <= 45)
					{
						if (this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
						{
							this.Shot_Front_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}

					if (this.cancelLV <= 40)
					{
						if (this.command.rsv_y > 0)
						{
							this.Shot_Normal_Under_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}

						if (this.command.rsv_y < 0)
						{
							this.Shot_Normal_Upper_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}

						this.Shot_Normal_Air_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
			}

			if (this.command.Check(this.BB))
			{
				if (this.Cancel_Check(50, 200, 0, true) && this.motion >= 2000 && this.motion <= 2019)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						local t_ = {};
						t_.ky <- this.input.y;
						t_.kx <- this.input.x;
						this.Shot_Burrage_Init(t_);
						this.command.ResetReserve();
						return true;
					}
					else
					{
						local t_ = {};
						t_.ky <- this.input.y;
						t_.kx <- this.input.x;
						this.Shot_Burrage_Init(t_);
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}
	}

	if (this.combo_func && this.flagState & 512)
	{
		if (this.command.rsv_k0)
		{
			if (this.combo_func())
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.motion == 40)
			{
				if (this.Cancel_Check(30))
				{
					if (this.keyTake <= 4)
					{
						if (this.command.rsv_x * this.direction > 0)
						{
							if (this.keyTake >= 3)
							{
								if (this.GetFront())
								{
									this.Atk_LowDash_R_Init(null);
									this.command.ResetReserve();
									return true;
								}
								else
								{
									this.Atk_LowDash_Init(null);
									this.command.ResetReserve();
									return true;
								}
							}

							this.Atk_LowDash_Init(null);
							this.command.ResetReserve();
							return true;
						}
						else if (this.Cancel_Check(10))
						{
							if (this.command.rsv_x * this.direction == 0 && this.command.rsv_y == 0)
							{
								this.Atk_Mid_Init(null);
								this.command.ResetReserve();
								return true;
							}
						}
					}
					else if (this.Cancel_Check(10))
					{
						if (this.command.rsv_x * this.direction == 0 && this.command.rsv_y == 0)
						{
							this.Atk_Mid_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}
				}
			}

			if (this.Cancel_Check(30))
			{
				if (this.command.rsv_y > 0)
				{
					this.Atk_HighUnder_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y < 0)
				{
					this.Atk_HighUpper_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x * this.direction > 0)
				{
					this.Atk_HighFront_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.Cancel_Check(10))
			{
				if (this.command.rsv_x * this.direction < 0 || this.atkRange > this.abs(this.target.x - this.x))
				{
					this.Atk_Low_Init(null);
					this.command.ResetReserve();
					return true;
				}
				else
				{
					this.Atk_Mid_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}
		}
		else
		{
			if (this.Cancel_Check(30))
			{
				if (this.command.rsv_y > 0)
				{
					this.Atk_HighUnder_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y < 0)
				{
					this.Atk_HighUpper_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x * this.direction > 0)
				{
					this.Atk_HighFront_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.Cancel_Check(20))
			{
				this.Atk_Mid_Air_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

