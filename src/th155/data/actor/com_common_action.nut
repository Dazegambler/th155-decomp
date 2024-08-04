function CPU_Wait( wait_ )
{
	this.com_count[2] = wait_;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}
		};
	}
	else if (this.centerStop * this.centerStop <= 1 || this.com_count[2] > 0)
	{
		return true;
	}
}

function CPU_AtkStop( wait_ )
{
	this.com_count[3] = wait_;
	this.com_subState[3] = this.CPU_AtkStopUpdate;
}

function CPU_AtkStopUpdate()
{
	if (this.com_count[3] > 0)
	{
		return true;
	}
}

function CPU_MoveStop( wait_ )
{
	this.com_count[2] = -1000;
	this.com_subState[2] = this.CPU_MoveStopUpdate;
}

function CPU_MoveStopUpdate()
{
	if (this.com_count[2] > 0)
	{
		return true;
	}
}

function CPU_Walk( wait_, x_ )
{
	this.com_keyFlag.x = x_;
	this.com_count[2] = wait_;
	this.com_subState[2] = function ()
	{
		if (this.com_count[2] > 0)
		{
			return true;
		}

		if (this.com_rand[2] <= 1)
		{
			if (this.abs(this.targetDist) <= 75)
			{
				this.com_keyFlag.x *= -1;
				this.com_rand[2] = 100;
			}
		}

		if (this.com_rand[2] <= 2)
		{
			if (this.abs(this.targetDist) <= 75)
			{
				return true;
			}
		}

		this.input.x = this.com_keyFlag.x;
	};
}

function CPU_Slide( wait_, x_, y_ )
{
	this.com_keyFlag.x = x_;
	this.com_keyFlag.y = y_;
	this.com_count[2] = wait_;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}

			this.input.x = this.com_keyFlag.x;
			this.input.y = this.com_keyFlag.y;
		};
	}
	else
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}

			this.input.x = this.com_keyFlag.x;
			this.input.y = this.com_keyFlag.y;
			this.input.b4 = 3;
		};
	}
}

function CPU_DashFront( wait_ )
{
	this.com_count[2] = wait_;
	this.com_rand[2] = this.rand() % 10;
	this.com_aggro_stance = 60;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}

			local d_ = this.abs(this.targetDist);

			if (this.com_rand[2] <= 5)
			{
				if (this.abs(this.targetDist) <= 125)
				{
					this.com_aggro_stance = 60;
					return true;
				}
			}
			else if (this.abs(this.targetDist) <= 75)
			{
				this.CPU_DashBack.call(this, -30);
				return;
			}

			this.com_dash = 1,00000000.0;
			this.input.x = this.direction;
		};
	}
	else
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0 || this.centerStop * this.centerStop <= 1)
			{
				return true;
			}

			this.com_dash = 1,00000000.0;
			this.input.x = this.direction;
		};
	}
}

function CPU_DashFront_Aggro( wait_ )
{
	this.com_count[2] = wait_;
	this.com_rand[2] = this.rand() % 10;
	this.com_aggro_stance = 60;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}

			this.com_dash = 1,00000000.0;
			this.input.x = this.direction;
		};
	}
	else
	{
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0 || this.centerStop * this.centerStop <= 1)
			{
				return true;
			}

			this.com_dash = 1,00000000.0;
			this.input.x = this.direction;
		};
	}
}

function CPU_DashBack( wait_ )
{
	this.com_rand[2] = this.rand() % 10;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_count[2] = -15;
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0)
			{
				return true;
			}

			this.com_dash = -1,00000000.0;
			this.input.x = -this.direction;
		};
	}
	else
	{
		this.com_count[2] = wait_;
		this.com_subState[2] = function ()
		{
			if (this.com_count[2] > 0 || this.centerStop * this.centerStop <= 1)
			{
				return true;
			}

			this.com_dash = -1,00000000.0;
			this.input.x = -this.direction;
		};
	}
}

function CPU_SpellCall( wait_ )
{
	if (this.team.sp < this.team.sp_max || this.team.spell_active)
	{
		return true;
	}

	if (this.rand() % 100 > this.team.sp.tofloat() / this.team.sp_max2 * 50)
	{
		return true;
	}

	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0 || this.team.spell_active)
		{
			return true;
		}

		this.command.rsv_k12 = 4;
		this.command.rsv_x = 0;
		this.command.rsv_y = 0;
	};
}

function CPU_EscapeWall( wait_ )
{
	this.com_count[2] = wait_;
	this.com_rand[2] = this.rand() % 100;
	this.com_subState[2] = function ()
	{
		if (this.com_count[2] > 0 || this.com_enemyPos >= 20 || this.com_enemyPos <= 9 && this.target.IsAttack() == 1)
		{
			this.com_subState[2] = this.CPU_MoveBase;
			this.com_count[2] = 0;
			return;
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.com_enemyPos == 5 || this.com_enemyPos == 16 || this.com_enemyPos == 14)
			{
				if (this.com_rand[2] <= 49)
				{
					this.CPU_Slide.call(this, -10, 0, -10);
					return;
				}
				else
				{
					this.CPU_Slide.call(this, -10, 0, 10);
					return;
				}
			}

			if (this.com_enemyPos == 8 || this.com_enemyPos == 17 || this.com_enemyPos == 18 || this.com_enemyPos == 19)
			{
				if (this.com_rand[2] <= 33)
				{
					this.CPU_Slide.call(this, -10, 0, 10);
					return;
				}
				else
				{
					this.CPU_Slide.call(this, -10, this.direction, 10);
					return;
				}
			}

			if (this.com_enemyPos == 2 || this.com_enemyPos == 11 || this.com_enemyPos == 12 || this.com_enemyPos == 13)
			{
				if (this.com_rand[2] <= 33)
				{
					this.CPU_Slide.call(this, -20, 0, -10);
					return;
				}
				else
				{
					this.CPU_Slide.call(this, -20, this.direction, -10);
					return;
				}
			}
		}
		else if (this.com_enemyPos == 11 || this.com_enemyPos == 12 || this.com_enemyPos == 13 || this.com_enemyPos == 17 || this.com_enemyPos == 18 || this.com_enemyPos == 19)
		{
			this.CPU_DashFront.call(this, -30);
			return;
		}
	};
}

function CPU_Defence()
{
	if (this.com_guard_stance > 0)
	{
		this.com_guard_stance--;
	}

	this.com_rand_def = this.rand() % 10;

	if (this.IsGuard())
	{
	}
	else
	{
		this.autoBaria = 0;

		if (this.IsFree())
		{
			local r_ = this.targetDist * this.targetDist;
			local l_ = this.com_level;

			if (r_ >= 600 * 600)
			{
				l_ = l_ + 33;
			}

			if (r_ >= 200 * 200)
			{
				l_ = l_ + 25;
			}

			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.com_search[0] > 0)
				{
					if (r_ >= 350 * 350)
					{
						switch(this.com_rand_def)
						{
						case 0:
						case 1:
						case 2:
						case 3:
						case 4:
						case 5:
						case 6:
							if (this.com_search[1][2] == 0 || this.com_search[2][2] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUnder;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][1] == 0 || this.com_search[2][1] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUnderR;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][3] == 0 || this.com_search[2][3] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUnderL;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][6] == 0 || this.com_search[2][6] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUpper;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][7] == 0 || this.com_search[2][7] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUpperR;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][5] == 0 || this.com_search[2][5] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUpperL;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][0] > 0 && this.com_search[2][0] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_DashFront;
								this.com_guard_stance = this.com_count[0] = this.rand() % 10 - 30;
								return true;
							}

							if (this.com_search[1][0] > 0 && this.com_search[2][0] > 0)
							{
								this.com_subState[0] = this.CPU_Avoid_DashFront;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 60;
								return true;
							}

							break;

						default:
							if (this.direction == 1,00000000.0 && this.x > ::battle.corner_left + 180 || this.direction == -1,00000000.0 && this.x < ::battle.corner_right - 180)
							{
								if (this.com_search[1][this.direction == 1,00000000.0 ? 4 : 0] > 0 && this.com_search[2][this.direction == 1,00000000.0 ? 4 : 0] == 0)
								{
									this.com_subState[0] = this.CPU_Avoid_DashBack;
									this.com_guard_stance = this.com_count[0] = -10;
									return true;
								}
							}

							if (this.com_search[2][this.direction == 1,00000000.0 ? 0 : 4] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_DashFront;
								this.com_guard_stance = this.com_count[0] = this.rand() % 30 - 60;
								return true;
							}

							this.com_subState[0] = this.CPU_Avoid_DashFront;
							this.com_guard_stance = this.com_count[0] = this.rand() % 5 - 25;
							return true;
							break;
						}
					}
					else
					{
						switch(this.com_rand_def)
						{
						case 0:
						case 1:
						case 2:
						case 3:
						case 4:
						case 5:
						case 6:
							if (this.com_search[2][0] == 0 && this.com_rand_def <= 1)
							{
								this.com_subState[0] = this.CPU_Avoid_DashFront;
								this.com_guard_stance = this.com_count[0] = this.rand() % 20 - 30;
								return true;
							}

							if ((this.com_search[1][2] == 0 || this.com_search[2][2] == 0) && this.com_rand_def <= 3)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUnder;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.com_search[1][6] == 0 || this.com_search[2][6] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUpper;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							if (this.direction == 1,00000000.0)
							{
								if (this.com_search[1][5] == 0 || this.com_search[2][5] == 0)
								{
									this.com_subState[0] = this.CPU_Avoid_SlideUpperL;
									this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
									return true;
								}

								if (this.com_search[1][3] == 0 || this.com_search[2][3] == 0)
								{
									this.com_subState[0] = this.CPU_Avoid_SlideUnderL;
									this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
									return true;
								}
							}
							else
							{
								if (this.com_search[1][1] == 0 || this.com_search[2][1] == 0)
								{
									this.com_subState[0] = this.CPU_Avoid_SlideUpperR;
									this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
									return true;
								}

								if (this.com_search[1][7] == 0 || this.com_search[2][7] == 0)
								{
									this.com_subState[0] = this.CPU_Avoid_SlideUpperR;
									this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
									return true;
								}
							}

							if (this.com_search[1][3] == 0 || this.com_search[2][3] == 0)
							{
								this.com_subState[0] = this.CPU_Avoid_SlideUnderL;
								this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
								return true;
							}

							this.com_guard_stance = this.com_count[0] = this.rand() % 5 - 25;
							return true;
							break;

						default:
							this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
							return true;
							break;
						}
					}
				}
			}
			else if (r_ >= 300 * 300)
			{
				if (this.com_search[1][this.direction == 1,00000000.0 ? 0 : 4] > 0 && this.com_search[2][this.direction == 1,00000000.0 ? 0 : 4] == 0)
				{
					if (this.com_search[2][this.y <= this.centerY ? 1 : 7] == 0 && this.direction == 1,00000000.0 || this.com_search[2][this.y <= this.centerY ? 3 : 5] == 0 && this.direction == -1,00000000.0)
					{
						this.com_subState[0] = this.CPU_Avoid_FlightFront;
						this.com_guard_stance = this.com_count[0] = this.rand() % 30 - 60;
						return true;
					}
					else
					{
						this.com_subState[0] = this.CPU_Avoid_DashFront;
						this.com_guard_stance = this.com_count[0] = this.rand() % 10 - 20;
						return true;
					}
				}
			}
			else
			{
				switch(this.com_rand_def)
				{
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					if (this.com_search[1][this.direction == 1,00000000.0 ? 4 : 0] > 0 && this.com_search[2][this.direction == 1,00000000.0 ? 4 : 0] == 0)
					{
						if (this.com_search[2][this.y <= this.centerY ? 3 : 5] == 0 && this.direction == 1,00000000.0 || this.com_search[2][this.y <= this.centerY ? 1 : 7] == 0 && this.direction == -1,00000000.0)
						{
							this.com_subState[0] = this.CPU_Avoid_FlightBack;
							this.com_guard_stance = this.com_count[0] = this.rand() % 30 - 60;
							return true;
						}
						else
						{
							this.com_subState[0] = this.CPU_Avoid_DashBack;
							this.com_guard_stance = this.com_count[0] = this.rand() % 10 - 20;
							return true;
						}

						this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
					}

					break;

				default:
					if (this.com_search[1][this.direction == 1,00000000.0 ? 0 : 4] > 0 && this.com_search[2][this.direction == 1,00000000.0 ? 0 : 4] == 0)
					{
						if (this.com_search[2][this.y <= this.centerY ? 1 : 7] == 0 && this.direction == 1,00000000.0 || this.com_search[2][this.y <= this.centerY ? 3 : 5] == 0 && this.direction == -1,00000000.0)
						{
							this.com_subState[0] = this.CPU_Avoid_FlightFront;
							this.com_guard_stance = this.com_count[0] = this.rand() % 30 - 60;
							return true;
						}
						else
						{
							this.com_subState[0] = this.CPU_Avoid_DashFront;
							this.com_guard_stance = this.com_count[0] = this.rand() % 10 - 20;
							return true;
						}
					}

					this.com_guard_stance = this.com_count[0] = this.rand() % 15 - 10;
					break;
				}
			}
		}
	}
}

function CPU_Avoid_SlideUpper()
{
	this.input.x = 0;
	this.input.y = -10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_SlideUpperL()
{
	this.input.x = -10;
	this.input.y = -10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_SlideUpperR()
{
	this.input.x = 10;
	this.input.y = -10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_SlideUnder()
{
	this.input.x = 0;
	this.input.y = 10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_SlideUnderL()
{
	this.input.x = -10;
	this.input.y = 10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_SlideUnderR()
{
	this.input.x = 10;
	this.input.y = 10;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_DashFront()
{
	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.motion != 40 && this.motion != 41)
		{
			this.com_dash = 1,00000000.0;
		}
		else if (this.targetDist * this.targetDist <= 40000 && this.targetHeight * this.targetHeight <= 20000)
		{
			this.com_subState[0] = this.CPU_Defence;
			this.com_count[0] = 0;
			return;
		}
	}
	else if (this.motion != 42 && this.motion != 43)
	{
		this.com_dash = 1,00000000.0;
	}
	else if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[0] = this.CPU_Defence;
		this.com_count[0] = 0;
		return;
	}

	this.input.x = this.direction;

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
	}
}

function CPU_Avoid_DashBack()
{
	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.motion != 40 && this.motion != 41)
		{
			this.com_dash = -1,00000000.0;
		}
		else if (this.abs(this.targetDist) <= 100 && this.abs(this.targetHeight) <= 100)
		{
			if (this.com_rand_def <= 33)
			{
				this.input.y = -1;
			}

			if (this.com_rand_def >= 66)
			{
				this.input.y = 1;
			}

			return;
		}

		if (this.com_rand_def <= 40)
		{
			if (this.com_rand_def > 20)
			{
				this.input.y = 1;
			}
			else
			{
				this.input.y = -1;
			}
		}

		if (this.com_front > 0,00000000.0)
		{
			this.input.x = -20;
		}
		else
		{
			this.input.x = 20;
		}
	}
	else if (this.motion != 42 && this.motion != 43)
	{
		this.com_dash = -1,00000000.0;
	}
	else if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[0] = this.CPU_Defence;
		this.com_count[0] = 0;
		return;
	}

	if (this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
		this.com_rand_def = this.rand() % 100;
	}
}

function CPU_Avoid_FlightFront()
{
	if (this.centerStop * this.centerStop <= 1 || this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
		this.com_count[0] = 0;
		return;
	}

	this.input.b4 = 10;
	this.input.x = this.direction;
}

function CPU_Avoid_FlightBack()
{
	if (this.centerStop * this.centerStop <= 1 || this.com_count[0] > 0)
	{
		this.com_subState[0] = this.CPU_Defence;
		this.com_count[0] = 0;
		return;
	}

	this.input.b4 = 10;
	this.input.x = -this.direction;
}

