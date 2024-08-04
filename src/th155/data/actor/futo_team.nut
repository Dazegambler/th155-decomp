function Team_FreeChangeAction()
{
}

function Team_Change_AttackB( t_ )
{
	this.LabelClear();
	this.HitReset();
	this.ResetSpeed();
	this.cpuState = null;
	this.SetMotion(3913, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1844);
		},
		function ()
		{
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
				this.VX_Brake(0,75000000.0);
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
			this.PlaySE(1846);
		},
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
	this.flag2 = [];
	this.flag3 = 3;
	this.flag4 = this.Vector3();
	this.subState = function ()
	{
		this.CenterUpdate(0,10000000.0, 2,00000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,50000000.0, -1,50000000.0 * this.direction);
		}
	};

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3920, 0);
		this.SetSpeed_XY(-10,00000000.0 * this.direction, this.va.y * 0,10000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,15000001.0, -1,00000000.0 * this.direction);
		};
	}
	else
	{
		this.SetMotion(3921, 0);
		this.SetSpeed_XY(-10,00000000.0 * this.direction, this.va.y * 0,10000000.0);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0,10000000.0, 1,50000000.0);
			this.VX_Brake(0,15000001.0, -1,00000000.0 * this.direction);
		};
	}

	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag1 = this.Math_MinMax(this.flag1, -0,78539813.0, 0,78539813.0);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.flag3 >= -5 && this.count % 3 == 1)
				{
					if (this.flag3 == 0)
					{
						local t_ = {};
						t_.v <- 9,00000000.0 + this.flag3 * 1,00000000.0;
						t_.rot <- this.flag1;
						t_.type <- true;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					}
					else if (this.flag3 == -5)
					{
						local t_ = {};
						t_.v <- 9,00000000.0 + this.flag3 * 1,00000000.0;
						t_.rot <- this.flag1 + this.flag3 * 0,10471975.0;
						t_.type <- true;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
						local t_ = {};
						t_.v <- 9,00000000.0 + this.flag3 * 1,00000000.0;
						t_.rot <- this.flag1 - this.flag3 * 0,10471975.0;
						t_.type <- true;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					}
					else
					{
						local t_ = {};
						t_.v <- 9,00000000.0 + this.flag3 * 1,00000000.0;
						t_.rot <- this.flag1 + this.flag3 * 0,10471975.0;
						t_.type <- false;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
						local t_ = {};
						t_.v <- 9,00000000.0 + this.flag3 * 1,00000000.0;
						t_.rot <- this.flag1 - this.flag3 * 0,10471975.0;
						t_.type <- false;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Change, t_);
					}

					this.flag3--;
					this.PlaySE(1849);
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
			if (this.target)
			{
				this.flag1 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
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
	this.flag1 = this.Vector3();

	if (this.dish.len() > 0)
	{
		this.flag1.x = this.dish[this.dish.len() - 1].x;
		this.flag1.y = this.dish[this.dish.len() - 1].y;
		this.flag2 = this.dish[this.dish.len() - 1].weakref();
	}
	else
	{
		this.flag1.x = this.x;
		this.flag1.y = this.centerY;
		this.flag2 = null;
	}

	this.flag3 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.SetMotion(3950, 1);
	this.hitCount = 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1900);
		},
		function ()
		{
			this.team.AddMP(-200, 120);
			this.Warp(this.flag1.x, ::battle.scroll_top - 180);
			this.SetSpeed_XY(0,00000000.0, 30,00000000.0);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				if (this.y > this.flag1.y + 50 || this.ground)
				{
					this.SetMotion(3005, 0);
					this.SetSpeed_XY(0,00000000.0, 20,00000000.0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,50000000.0);

						if (this.va.y < 0,25000000.0)
						{
							this.SetSpeed_XY(0,00000000.0, 0,25000000.0);
						}
					};
					this.keyAction = [
						function ()
						{
							this.stateLabel = function ()
							{
							};
						},
						function ()
						{
							this.Team_Change_ChangeSkillEnd(null);
						}
					];
					return;
				}

				if (this.abs(this.flag1.x - this.x) <= 100 && this.abs(this.flag1.y - this.y) <= 20)
				{
					local c_ = false;

					if (this.flag2 == null)
					{
						c_ = true;
					}

					for( local i = 0; i < this.dish.len(); i++ )
					{
						if (this.dish[i] == this.flag2)
						{
							c_ = true;
							break;
						}
					}

					if (c_)
					{
						this.HitTargetReset();
						this.SetMotion(this.motion, 3);
						this.SetSpeed_XY(0,00000000.0, 15,00000000.0);
						this.PlaySE(1901);

						if (this.flag2)
						{
							this.SPShot_A.call(this.flag2, null);
						}

						local t_ = {};
						t_.type <- 3;

						if (this.motion >= 3001)
						{
							t_.type = 4;
						}

						this.SetShot(this.x, this.y, this.direction, this.SPShot_A_Tornade, t_);
						this.count = 0;
						this.hitResult = 1;
						this.stateLabel = function ()
						{
							if (this.motion >= 3001 && this.count % 2 == 0)
							{
								this.SetFreeObject(this.x, this.y + 50,00000000.0, this.direction, this.owner.SPShot_A_Spin, {});
							}

							if (this.va.y <= 0,00000000.0)
							{
								this.AddSpeed_XY(0,00000000.0, -0,50000000.0);

								if (this.va.y <= -3,50000000.0)
								{
									this.SetSpeed_XY(0,00000000.0, -3,50000000.0);
								}
							}
							else
							{
								this.Vec_Brake(1,50000000.0);
							}

							if (this.count >= 20)
							{
								this.centerStop = -2;
								this.SetMotion(this.motion, 4);
								this.SetSpeed_XY(0,00000000.0, -15,00000000.0);
								this.stateLabel = function ()
								{
									this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
								};
							}
						};
					}
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.Team_Change_ChangeSkillEnd(null);
		}
	];
	return true;
}

function Team_Change_SpellB( t )
{
	this.Spell_B_Init(t);
	this.keyAction[0] = function ()
	{
		this.UseChangeSpellCard(60, -this.team.sp);
		this.centerStop = -2;
		this.SetSpeed_Vec(17,50000000.0, -120 * 0,01745329.0, this.direction);
		this.stateLabel = function ()
		{
			this.Vec_Brake(1,20000005.0, 1,00000000.0);
		};
		this.PlaySE(1932);
	};
	return true;
}

