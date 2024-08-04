function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.AjustCenterStop();
	this.count = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1517);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
		},
		this.EndtoFreeMove,
		function ()
		{
			this.PlaySE(1518);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
		}
	];

	if (this.unzan)
	{
		this.SetMotion(3913, 0);
		this.SetSpeed_XY(12,00000000.0 * this.direction, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,05000000.0);
		};
	}
	else
	{
		this.SetMotion(3913, 3);
		this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,10000000.0);
		};
	}
}

function Team_Change_Attack_AirB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.AjustCenterStop();
	this.count = 0;

	if (this.unzan)
	{
		this.SetMotion(3914, 0);

		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			local v_ = this.va.y - 5,00000000.0;
			v_ = this.Math_MinMax(v_, -8,00000000.0, -2,00000000.0);
			this.SetSpeed_XY(12,00000000.0 * this.direction, v_);
		}
		else
		{
			this.centerStop = 2;
			local v_ = this.va.y + 5,00000000.0;
			v_ = this.Math_MinMax(v_, 2,00000000.0, 8,00000000.0);
			this.SetSpeed_XY(12,00000000.0 * this.direction, 4,00000000.0);
		}

		this.stateLabel = function ()
		{
			this.CenterUpdate(0,50000000.0, null);
			this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.GetFront();
				this.SetMotion(this.motion, 4);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
	}
	else
	{
		this.SetMotion(3914, 5);

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

		this.stateLabel = function ()
		{
			this.CenterUpdate(0,50000000.0, null);
			this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.GetFront();
				this.SetMotion(this.motion, 9);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(1502);
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.GetFront();
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove,
		function ()
		{
			this.PlaySE(1510);
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.GetFront();
					this.SetMotion(this.motion, 9);
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
		this.CenterUpdate(0,50000000.0, null);
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
	this.ResetSpeed();
	this.count = 0;
	this.flag1 = 0;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, 0,00000000.0);
		this.subState = function ()
		{
			this.VX_Brake(0,50000000.0, -2,00000000.0 * this.direction);
		};
		this.stateLabel = function ()
		{
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-8,00000000.0 * this.direction, 0,00000000.0);
		this.subState = function ()
		{
			this.CenterUpdate(0,25000000.0, 5,00000000.0);

			if (this.centerStop == 0)
			{
				this.VX_Brake(0,50000000.0, -2,00000000.0 * this.direction);
			}
			else
			{
				this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
			}
		};
		this.stateLabel = function ()
		{
			this.CenterUpdate(0,15000001.0, 3,00000000.0);
			this.VX_Brake(0,15000001.0, -2,00000000.0 * this.direction);
		};
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.flag1 <= 8 && this.count % 4 == 1)
				{
					this.PlaySE(1540);
					this.hitResult = 1;
					local t_ = {};
					t_.rot <- (4 - this.flag1) * 0,08726646.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					this.flag1++;
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
					this.VX_Brake(0,20000000.0);
				}
			};
		}
	];
}

function Team_Change_ShotFin( t, ky_ )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.team.current.Team_Change_ShotFinB(v_, ky_);
}

function Team_Change_ShotFinB( va_, ky_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.SetSpeed_XY(va_.x, va_.y);
	this.SetMotion(3930, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;

	if (ky_ < 0)
	{
		this.flag2 = -30 * 0,01745329.0;
	}

	if (ky_ > 0)
	{
		this.flag2 = 30 * 0,01745329.0;
	}

	this.keyAction = [
		function ()
		{
			if (this.owner.target)
			{
				this.flag1 = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
				this.flag1 = this.Math_MinMax(this.flag1, -45 * 0,01745329.0, 45 * 0,01745329.0);
			}

			this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
			this.hitResult = 1;
			this.PlaySE(1126);
			local t_ = {};
			t_.rot <- this.flag1 + this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChangeFin, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.CenterUpdate(0,10000000.0, 2,00000000.0);
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
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
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(v_.x * 0,50000000.0, v_.y * 0,50000000.0);
	this.AjustCenterStop();
	this.SetMotion(3950, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1100);
			this.hitResult = 1;

			for( local i = 0; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-6,00000000.0 + 4,00000000.0 * i) * 0,01745329.0;
				t_.take <- 0;
				this.SetShot(this.point0_x + (i * 20 - 50) * this.cos(t_.rot + 3,14159203.0 * 0,50000000.0) * this.direction, this.point0_y + (20 * i - 50) * this.sin(t_.rot + 3,14159203.0 * 0,50000000.0), this.direction, this.SPShot_A, t_);
			}
		},
		null,
		function ()
		{
			this.stateLabel = null;
		},
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, 2,00000000.0);
		this.VX_Brake(0,25000000.0);
	};
	return true;
}

function Team_Change_SpellCheck()
{
	if (!this.unzan)
	{
		return false;
	}

	return true;
}

function Team_Change_SpellB( t )
{
	if (this.Spell_A_Init(t))
	{
		this.keyAction[0] = function ()
		{
			this.UseChangeSpellCard(60, -this.team.sp);
		};
		return true;
	}

	return false;
}

