function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3913, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(17,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0, 6,00000000.0 * this.direction);
			};
			this.PlaySE(2417);
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);

		if (this.count == 8)
		{
			this.SetMotion(3913, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		}
	};
}

function Team_Change_Attack_AirB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3914, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.PlaySE(2425);

	if (this.y < this.centerY)
	{
		this.centerStop = -2;
		local v_ = this.va.y - 5,00000000.0;
		v_ = this.Math_MinMax(v_, -8,00000000.0, -2,00000000.0);
		this.SetSpeed_XY(15,00000000.0 * this.direction, v_);
	}
	else
	{
		this.centerStop = 2;
		local v_ = this.va.y + 5,00000000.0;
		v_ = this.Math_MinMax(v_, 2,00000000.0, 8,00000000.0);
		this.SetSpeed_XY(15,00000000.0 * this.direction, 4,00000000.0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(2405);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.GetFront();
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,40000001.0, null);
		this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
}

function Team_Change_ShotB( va_ )
{
	this.LabelClear();
	this.HitReset();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, this.y < this.centerY ? -3,00000000.0 : 3,00000000.0);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0,15000001.0, 3,00000000.0);
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}

	this.count = 0;
	this.flag1 = 90 * 0,01745329.0;
	this.flag2 = 0;
	this.flag3 = 0,00000000.0;
	this.subState = function ()
	{
		this.CenterUpdate(0,15000001.0, 3,00000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0, -3,00000000.0 * this.direction);
		}
		else
		{
			this.VX_Brake(0,15000001.0, -3,00000000.0 * this.direction);
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			}

			this.count = 0;
			this.flag3 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag3 = this.Math_MinMax(this.flag3, -0,78539813.0, 0,78539813.0);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 4 == 1)
				{
					this.hitResult = 1;
					this.flag2++;
					this.PlaySE(2420);
					local t_ = {};
					t_.rot <- this.flag1 + this.flag3;
					t_.keyTake <- this.flag2 % 2;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					this.flag1 *= -0,89999998.0;
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,15000001.0, -1,00000000.0 * this.direction);
				}
			};
		}
	];
}

function Team_Change_ShotFin( t )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.team.current.Team_Change_ShotFinB(v_);
}

function Team_Change_ShotFinB( va_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.SetSpeed_XY(va_.x, va_.y);
	this.SetMotion(3930, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.centerStop * this.centerStop >= 4 && this.y > this.centerY;
	this.keyAction = [
		function ()
		{
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -25 * 0,01745329.0, 25 * 0,01745329.0);
			}

			if (this.flag2)
			{
				this.centerStop = 3;
				this.SetSpeed_XY(-19,50000000.0 * this.direction, 3,00000000.0);
			}
			else
			{
				this.centerStop = -3;
				this.SetSpeed_XY(-19,50000000.0 * this.direction, -6,00000000.0);
			}

			this.hitResult = 1;
			this.PlaySE(2420);
			local t_ = {};
			t_.rot <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChangeFin_Core, t_);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0,75000000.0, 5,00000000.0))
				{
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);

						if (this.centerStop == 0)
						{
							this.VX_Brake(0,50000000.0);
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);
	};
}

function Team_Change_Skill_FrontB( t, v_ )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3950, 0);
	this.SetSpeed_XY(v_.x * 0,00000000.0, v_.y * 0,00000000.0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 4;
	this.flag4 = null;
	this.stateLabel = function ()
	{
		if (this.hitResult)
		{
			this.flag2++;

			if (this.flag2 >= 5 && this.flag3 >= 1)
			{
				this.flag3--;
				this.HitTargetReset();
				this.flag2 = 0;
			}
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_Vec(17,00000000.0, 0,00000000.0, this.direction);
			this.PlaySE(1300);
			this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.SP_A_Bloom, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag4)
				{
					this.flag4.func();
				}
			};
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,75000000.0, 3,00000000.0 * this.direction);
				}
			};
		},
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
	return true;
}

function Team_Change_SpellB( t )
{
	this.Spell_A_Init(t);
	this.keyAction[0] = function ()
	{
		this.UseChangeSpellCard(60, -this.team.sp);
	};
	return true;
}

