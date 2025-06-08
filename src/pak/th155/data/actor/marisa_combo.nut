function Rush_AA()
{
	if (this.Cancel_Check(20) && this.Atk_RushA_Init(null))
	{
		this.combo_func = this.Rush_AAA;
		return true;
	}

	return false;
}

function Rush_AAA()
{
	if (this.Cancel_Check(30) && this.Atk_RushB_Init(null))
	{
		this.combo_func = this.Rush_Smash;
		return true;
	}

	return false;
}

function Rush_Smash()
{
	if (this.Cancel_Check(40))
	{
		if (this.command.rsv_y < 0)
		{
			if (this.Atk_RushC_Upper_Init(null))
			{
				this.combo_func = this.Rush_Skill_Strat;
				return true;
			}
		}
		else if (this.command.rsv_y > 0)
		{
			if (this.Atk_RushC_Under_Init(null))
			{
				this.combo_func = this.Rush_Skill_Miasma;
				return true;
			}
		}
		else if (this.Atk_RushC_Front_Init(null))
		{
			this.combo_func = this.Rush_Skill_Rayline;
			return true;
		}
	}

	return false;
}

function Rush_Far()
{
	if (this.command.rsv_y == 0 && this.command.rsv_x * this.direction <= 0)
	{
		if (this.Cancel_Check(40) && this.Atk_RushA_Far_Init(null))
		{
			this.combo_func = this.Rush_Shot_Front;
			return true;
		}
	}

	return false;
}

function Rush_Air()
{
	if (this.centerStop * this.centerStop >= 4 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction <= 0 && this.Cancel_Check(40) && this.Atk_RushA_Air_Init(null))
	{
		this.combo_func = this.Rush_Shot_Front_Air;
		return true;
	}

	return false;
}

function Rush_Upper()
{
	if (this.team.mp >= 200 && this.centerStop * this.centerStop >= 4 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.target.centerStop * this.centerStop <= 1)
			{
				if (this.Shot_Normal_Under_Air_Init(null))
				{
					return true;
				}
			}
			else if (this.Shot_Normal_Air_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Normal_Upper_Air_Init(null))
		{
			this.combo_func = this.Rush_Skill_Miasma;
			return true;
		}
	}

	return false;
}

function Rush_Under()
{
	if (this.team.mp >= 200 && this.centerStop * this.centerStop >= 4 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.target.centerStop * this.target.centerStop <= 1)
			{
				if (this.Shot_Normal_Under_Air_Init(null))
				{
					return true;
				}
			}
			else if (this.Shot_Normal_Air_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Normal_Under_Air_Init(null))
		{
			this.combo_func = this.Rush_Skill_Akuu;
			return true;
		}
	}

	return false;
}

function Rush_Front()
{
	if (this.team.mp >= 200 && this.centerStop * this.centerStop <= 1 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.Shot_Front_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Front_Init(null))
		{
			this.combo_func = this.Rush_Skill_Rayline;
			return true;
		}
	}

	return false;
}

function Rush_Shot_Front()
{
	if (this.team.mp >= 200 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.Shot_Front_Init(null))
			{
				this.combo_func = null;
				return true;
			}
		}
		else if (this.Shot_Front_Init(null))
		{
			this.combo_func = this.Rush_Skill_Rayline;
			return true;
		}
	}
}

function Rush_Shot_Upper_Air()
{
	if (this.team.mp >= 200 && this.centerStop * this.centerStop >= 4 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.Shot_Normal_Air_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Normal_Upper_Air_Init(null))
		{
			this.combo_func = this.Rush_Skill_Miasma;
			return true;
		}
	}
}

function Rush_Shot_Under_Air()
{
	if (this.team.mp >= 200 && this.centerStop * this.centerStop >= 4 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.Shot_Normal_Air_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Normal_Under_Air_Init(null))
		{
			this.combo_func = this.Rush_Skill_Aside;
			return true;
		}
	}
}

function Rush_Shot_Front_Air()
{
	if (this.centerStop * this.centerStop >= 4 && this.team.mp >= 200 && this.Cancel_Check(40))
	{
		if (this.hitResult & 8)
		{
			if (this.y < this.centerY)
			{
				if (this.Shot_Normal_Under_Air_Init(null))
				{
					return true;
				}
			}
			else if (this.Shot_Normal_Upper_Air_Init(null))
			{
				return true;
			}

			if (this.Shot_Normal_Air_Init(null))
			{
				return true;
			}
		}
		else if (this.Shot_Front_Air_Init(null))
		{
			this.combo_func = this.Rush_Skill_Rayline;
			return true;
		}
	}
}

function Rush_Skill_Miasma()
{
	if (this.team.mp >= 200)
	{
		if (this.Cancel_Check(50))
		{
			if (this.SP_B_Init(null))
			{
				this.combo_func = null;
				return true;
			}
		}
	}
}

function Rush_Skill_Rayline()
{
	if (this.team.mp >= 200)
	{
		if (this.hitResult & 8 && this.Cancel_Check(40))
		{
			if (this.centerStop * this.centerStop >= 4)
			{
				if (this.Shot_Front_Air_Init(null))
				{
					return true;
				}
			}
			else if (this.Shot_Front_Init(null))
			{
				return true;
			}
		}

		if (this.Cancel_Check(50))
		{
			if (this.centerStop * this.centerStop >= 4)
			{
				if (this.SP_A_Air_Init(null))
				{
					this.combo_func = null;
					return true;
				}
			}
			else if (this.SP_A_Init(null))
			{
				this.combo_func = null;
				return true;
			}
		}
	}
}

function Rush_Skill_Aside()
{
	if (this.team.mp >= 200)
	{
		if (this.centerStop * this.centerStop <= 1 && this.Cancel_Check(40))
		{
			if (this.hitResult & 8)
			{
				if (this.Shot_Normal_Init(null))
				{
					return true;
				}
			}
		}

		if (this.Cancel_Check(50))
		{
			if (this.SP_E_Init(null))
			{
				this.combo_func = null;
				return true;
			}
		}
	}
}

function Rush_Skill_Strat()
{
	if (this.team.mp >= 200)
	{
		if (this.Cancel_Check(40) && this.centerStop * this.centerStop >= 2)
		{
			if (this.hitResult & 8)
			{
				if (this.Shot_Normal_Init(null))
				{
					return true;
				}
			}
		}

		if (this.Cancel_Check(50))
		{
			if (this.centerStop * this.centerStop >= 2)
			{
				if (this.SP_D_Air_Init(null))
				{
					this.combo_func = null;
					return true;
				}
			}
			else if (this.SP_D_Init(null))
			{
				this.combo_func = null;
				return true;
			}
		}
	}
}

