function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 2)
	{
		this.BeginBattle_Ichirin(null);
		return;
	}

	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.BeginBattleA(null);
		break;

	case 1:
		this.BeginBattleB(null);
		break;
	}
}

function Func_Win()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.WinA(null);
		break;

	case 1:
		this.WinC(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattleA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1990);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 60)
				{
					this.stateLabel = null;
					this.SetMotion(this.motion, 3);
				}
			};
		},
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 0);
	this.demoObject = [];
	this.flag1 = 0;
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.EndtoFreeMove();
			this.CommonBegin();
		}
	];
	this.stateLabel = function ()
	{
		if (this.demoObject.len() < 12)
		{
			if (this.count % 6 == 1)
			{
				local t_ = {};
				t_.stack <- this.demoObject.len() * 12;
				this.demoObject.append(this.SetFreeObject(this.x, ::battle.scroll_top - 10, this.direction, function ( t_ )
				{
					this.SetMotion(9001, 4);
					this.SetSpeed_XY(0,00000000.0, 5,00000000.0);
					this.func = function ()
					{
						this.SetSpeed_XY(-8,00000000.0 + this.rand() % 17, -8,00000000.0 - this.rand() % 11);
						this.stateLabel = function ()
						{
							this.count++;
							this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

							if (this.count >= 60)
							{
								this.alpha -= 0,05000000.0;

								if (this.alpha <= 0,00000000.0)
								{
									this.ReleaseActor();
								}
							}
						};
					};
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

						if (this.y + this.va.y >= this.owner.y + 50 - this.initTable.stack)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.Warp(this.owner.x, this.owner.y + 50 - this.initTable.stack);
							this.PlaySE(1992);
							this.stateLabel = null;
						}
					};
				}, t_).weakref());
			}
		}
		else
		{
			this.flag1++;

			if (this.flag1 >= 50)
			{
				::camera.shake_radius = 1,50000000.0;
				this.count = 0;
				this.PlaySE(1993);
				this.SetMotion(this.motion, 1);

				foreach( a in this.demoObject )
				{
					a.func();
				}

				this.stateLabel = function ()
				{
					if (this.count >= 60)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = null;
					}
				};
			}
		}
	};
}

function BeginBattle_Ichirin( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.direction *= -1,00000000.0;
	this.team.slave.BeginBattle_Slave(null);
	this.Warp(::battle.start_x[this.team.index], this.y);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				if (this.count == 94)
				{
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
					this.PlaySE(807);
				}

				this.VX_Brake(0,25000000.0);

				if (this.va.x > 0,00000000.0 && this.x > ::battle.start_x[this.team.index] || this.va.x < 0 && this.x < ::battle.start_x[this.team.index])
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.CommonBegin();
		}
	];
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9003, 0);
	this.Warp(::battle.start_x[this.team.index] - 167 * this.direction, this.y - 8);
	this.DrawActorPriority();
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				if (this.count == 95)
				{
					this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
				}

				this.VX_Brake(0,75000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.PlaySE(1991);
			this.SetSpeed_XY(0,00000000.0, 1,00000000.0);
			this.subState = function ()
			{
				if (this.y < this.flag1)
				{
					this.AddSpeed_XY(0,00000000.0, 0,02500000.0);
				}
				else
				{
					this.AddSpeed_XY(0,00000000.0, -0,02500000.0);
				}
			};
			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 120)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinC( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9012, 0);
	this.flag1 = 0;
	this.freeMap = true;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(0,00000000.0, 3,00000000.0 * this.cos(this.count * 6 * 0,01745329.0));

				if (this.count >= 60)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 45)
						{
							this.PlaySE(1994);
						}

						if (this.count <= 30)
						{
							this.AddSpeed_XY(-0,30000001.0 * this.direction, 0,02500000.0);
						}
						else
						{
							this.AddSpeed_XY(0,50000000.0 * this.direction, -0,34999999.0);
						}

						if (this.count == 90)
						{
							this.CommonWin();
						}
					};
				}
			};
		}
	];
}

function Lose( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.stateLabel = function ()
	{
		if (this.keyTake == 0)
		{
			this.count = 0;
		}
		else if (this.count == 60)
		{
			this.CommonLose();
		}
	};
}

function Stand_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.Stand;
	this.SetMotion(0, 0);
}

function Stand()
{
	this.GetFront();
	this.VX_Brake(0,80000001.0);
}

function MoveFront_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(6,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5,50000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,50000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,00000000.0;
	t_.back_rev <- -5,00000000.0;
	t_.v <- -18,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,50000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,00000000.0;
	t_.back_rev <- -5,00000000.0;
	t_.v <- -18,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,50000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,00000000.0;
	t_.back_rev <- -5,00000000.0;
	t_.v <- 18,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,50000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,00000000.0;
	t_.back_rev <- -5,00000000.0;
	t_.v <- 18,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = -7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 6,00000000.0;
	t_.addSpeed <- 0,40000001.0;
	t_.maxSpeed <- 15,00000000.0;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0,15000001.0;
	t_.maxSpeed <- 14,50000000.0;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-11,00000000.0 * this.direction, -4,50000000.0);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.y > this.centerY && this.va.y > 0,00000000.0)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2,50000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -10,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0,20000000.0;
	t_.maxSpeed <- 14,00000000.0;
	this.DashBack_Air_Common(t_);
}

function Atk_RushA_Init( t )
{
	this.Atk_Low_Init(t);
	this.SetMotion(1500, 0);
	this.atk_id = 1;
	this.SetSpeed_XY(8,00000000.0 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1802);
		}
	];
	return true;
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1800);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.Atk_Mid_Init(t);
	this.SetMotion(1600, 0);
	this.atk_id = 4;
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, null);
			this.PlaySE(1804);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);

				if (this.hitCount < 5)
				{
					this.HitCycleUpdate(5);
				}
			};
		},
		function ()
		{
			if (this.centerStop == 0)
			{
				this.VX_Brake(0,50000000.0);
			}
			else
			{
				this.VX_Brake(0,10000000.0);
			}
		}
	];
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1100, 0);
	this.flag1 = 0;
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(8,00000000.0 * this.direction, null);
			this.PlaySE(1804);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.hitCount < 3)
				{
					this.HitCycleUpdate(3);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	];
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1101, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
			return;
		}
	};
	this.SetMotion(1101, 0);
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1804);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1101, 4);
					this.GetFront();
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
					return;
				}

				if (this.hitCount < 3)
				{
					this.HitCycleUpdate(3);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1101, 4);
					this.GetFront();
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}
			};
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 10,00000000.0);
			this.centerStop = 2;
			this.PlaySE(1808);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.VY_Brake(0,60000002.0);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
		this.CenterUpdate(0,10000000.0, null);

		if (this.rand() % 3 == 1)
		{
			this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
		}
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1808);
		},
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-12,00000000.0 * this.direction, -9,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.va.x * this.direction > -1,00000000.0 ? 0,00000000.0 : 0,50000000.0 * this.direction, this.va.y >= 0,00000000.0 ? 0,10000000.0 : 0,50000000.0);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);

		if (this.rand() % 3 == 1)
		{
			this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
		}
	};
	return true;
}

function Atk_HighUnderB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-12,00000000.0 * this.direction, -9,00000000.0);
			this.PlaySE(1808);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.va.x * this.direction > -1,00000000.0 ? 0,00000000.0 : 0,50000000.0 * this.direction, this.va.y >= 0,00000000.0 ? 0,10000000.0 : 0,50000000.0);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.rand() % 3 == 1)
		{
			this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
		}
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.y >= this.centerY)
	{
		this.SetMotion(1214, 0);
	}
	else
	{
		this.SetMotion(1211, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(1808);
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
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1810);
			this.centerStop = -2;
			this.SetSpeed_XY(5,00000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.rand() % 3 == 1)
				{
					this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(1811);
			this.HitTargetReset();
			this.SetSpeed_XY(3,59999990.0 * this.direction, 14,39999962.0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,40000001.0);

				if (this.y >= this.centerY)
				{
					this.centerStop = 1;
					this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,20000000.0);

						if (this.rand() % 3 == 1)
						{
							this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
						}

						this.CenterUpdate(this.baseGravity, null);
					};
				}

				if (this.rand() % 3 == 1)
				{
					this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1810);
			this.centerStop = -2;
			this.SetSpeed_XY(8,00000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.rand() % 3 == 1)
				{
					this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(1811);
			this.HitTargetReset();
			this.SetSpeed_XY(3,59999990.0 * this.direction, 14,39999962.0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,40000001.0);

				if (this.y >= this.centerY)
				{
					this.centerStop = 1;
					this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,20000000.0);

						if (this.rand() % 3 == 1)
						{
							this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
						}

						this.CenterUpdate(this.baseGravity, null);
					};
				}

				if (this.rand() % 3 == 1)
				{
					this.SetFreeObject(this.point0_x - 50 + this.rand() % 100, this.point0_y - 50 + this.rand() % 100, this.direction, this.owner.SPShot_E_Trail, {});
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.hitCount = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1806);
			this.SetSpeed_XY(-1,00000000.0 * this.direction, -4,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.hitCount < 4)
				{
					this.HitCycleUpdate(3);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1221, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1221, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1221, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 32;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1750, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.flag2 = 0;
	this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
			this.PlaySE(1814);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);
				this.VX_Brake(0,50000000.0);

				if (this.va.x * this.direction <= 8,00000000.0)
				{
					this.SetSpeed_XY(8,00000000.0 * this.direction, null);
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.SetMotion(this.motion, 3);
			this.PlaySE(1815);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
			};
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1760, 0);
	this.atk_id = 16;
	this.keyAction = [
		function ()
		{
			if (this.y <= this.centerY || this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(10,00000000.0 * this.direction, -3,00000000.0);
				this.centerStop = -3;
			}
			else
			{
				this.SetSpeed_XY(10,00000000.0 * this.direction, 3,00000000.0);
				this.centerStop = 3;
			}

			this.PlaySE(1855);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,40000001.0, 4,00000000.0);
				this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					return;
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1101, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
			return;
		}
	};
	return true;
}

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.flag2 = 0;
	this.keyAction = [
		function ()
		{
			if (this.y <= this.centerY || this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(10,00000000.0 * this.direction, -3,00000000.0);
				this.centerStop = -3;
			}
			else
			{
				this.SetSpeed_XY(10,00000000.0 * this.direction, 3,00000000.0);
				this.centerStop = 3;
			}

			this.PlaySE(1855);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,40000001.0, 4,00000000.0);
				this.VX_Brake(0,50000000.0, 4,00000000.0 * this.direction);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					return;
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			return;
		}
	};
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1300, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1818);
			this.SetSpeed_XY(12,00000000.0 * this.direction, 0,00000000.0);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.DashLow_Dish, {});
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
			};
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
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);

	if (this.dishLevel >= 3)
	{
		this.SetMotion(1311, 0);
	}

	this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(1820);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,50000000.0, 2,00000000.0 * this.direction);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Grab_Actor( t )
{
	this.target = this.initTable.pare.target.weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.target.Warp(this.initTable.pare.point0_x, this.initTable.pare.y);
	};
}

function Grab_Actor2( t )
{
	this.target = this.initTable.pare.target.weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.target.SetSpeed_XY((this.initTable.pare.point0_x - this.target.x) * 0,15000001.0, (this.initTable.pare.point0_y - this.target.y) * 0,15000001.0);
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1,00000000.0)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1,00000000.0)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(300, 2, -this.direction);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.flag2 = null;
	this.stateLabel = function ()
	{
		if (this.Atk_Grab_Hit_Update())
		{
			this.flag1.func[0].call(this.flag1);
			this.target.autoCamera = true;
			this.Grab_Blocked(null);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
			this.Atk_Throw(null);
		}
	];
}

function Atk_Throw( t )
{
	this.LabelClear();
	this.SetMotion(1802, 1);
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1857);
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(311, 0, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor2, {}, this.weakref()).weakref();
			this.flag2 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Grab_Cyclone, {}).weakref();
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			this.flag2.func();
			this.flag2 = null;
			this.flag1.func[0].call(this.flag1);
			this.PlaySE(1858);
			::camera.shake_radius = 3,00000000.0;
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;
			this.HitReset();
			this.hitResult = 1;
			this.target.team.regain_life -= ((this.target.team.regain_life - this.target.team.life) * 0,50000000.0).tointeger();
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
			};
		}
	];
}

function Shot_Normal_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.flag1 = 0;
	this.flag2 = null;
	this.flag3 = 0,00000000.0;
	this.flag4 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func[0].call(this.flag2);
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.count >= 10 && this.count % 4 == 2 && this.flag1 < 3)
				{
					if (this.flag4)
					{
						this.team.AddMP(-200, 90);
						this.flag4 = null;
					}

					this.PlaySE(1822);
					local t_ = {};
					t_.rot <- this.flag3;
					t_.v <- 9,00000000.0 - this.flag1;
					t_.type <- this.flag1;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.NormalShotSub, t_);
					this.flag1++;

					if (this.flag1 >= 5)
					{
						this.flag1 = 0;
					}
				}
			};
			local t_ = {};
			t_.rot <- this.flag3;
			t_.v <- 12,50000000.0;
			t_.type <- 4;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.NormalShot, t_).weakref();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1823);
			this.flag2.func[1].call(this.flag2);
			this.lavelClearEvent = null;
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.flag1 = 0;
	this.flag2 = null;
	this.flag3 = 0,00000000.0;
	this.flag4 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func[0].call(this.flag2);
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 10 && this.count % 4 == 2 && this.flag1 < 3)
				{
					this.PlaySE(1822);

					if (this.flag4)
					{
						this.team.AddMP(-200, 90);
						this.flag4 = null;
					}

					local t_ = {};
					t_.rot <- this.flag3;
					t_.v <- 9,00000000.0 - this.flag1;
					t_.type <- this.flag1;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.NormalShotSub, t_);
					this.flag1++;

					if (this.flag1 >= 5)
					{
						this.flag1 = 0;
					}
				}

				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
			local t_ = {};
			t_.rot <- this.flag3;
			t_.v <- 12,50000000.0;
			t_.type <- 4;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.NormalShot, t_).weakref();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		},
		function ()
		{
			this.PlaySE(1823);
			this.flag2.func[1].call(this.flag2);
			this.lavelClearEvent = null;
		},
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,10000000.0);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag3 = -40 * 0,01745329.0;
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag3 = -40 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag3 = 40 * 0,01745329.0;
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag3 = 40,00000000.0 * 0,01745329.0;
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = true;
	this.flag2 = [];
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,34999999.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1828);
			this.count = 0;
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {}).weakref();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);
				this.VX_Brake(0,01000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);
				this.VX_Brake(0,20000000.0);
			};
		},
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1829);
			this.flag2.func[0].call(this.flag2);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,10000000.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.Shot_Front_Init(t);
	this.AjustCenterStop();
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5,75000000.0;
	this.flag2.vy <- 3,50000000.0;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 75,00000000.0;

	if (t.ky == 0,00000000.0)
	{
		this.flag2 = 0,00000000.0;
	}
	else if (t.ky > 0,00000000.0)
	{
		this.flag2 = 25 * 0,01745329.0;
	}
	else
	{
		this.flag2 = -25 * 0,01745329.0;
	}

	this.flag4 = t.charge;
	this.SetMotion(2020, 0);
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,02500000.0);
		}

		this.CenterUpdate(0,10000000.0, null);
	};
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
				this.CenterUpdate(0,10000000.0, 0,75000000.0);
			};
			this.SetSpeed_XY(3,00000000.0 * this.direction, null);
			this.PlaySE(1956);
			local t_ = {};
			t_.vec <- this.flag1;
			t_.rot <- this.flag2;
			t_.charge <- this.flag4;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeRoot, t_, this.weakref());
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		}
	];
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.flag2.rot <- 0,00000000.0;
	this.flag2.dish <- [];
	local t_ = {};
	t_.rot <- 0;
	this.flag2.dish.append(this.SetFreeObject(this.x + 90 * this.direction, this.y, this.direction, this.Shot_Barrage_Option, t_).weakref());
	local t_ = {};
	t_.rot <- 90;
	this.flag2.dish.append(this.SetFreeObject(this.x, this.y + 90, this.direction, this.Shot_Barrage_Option, t_).weakref());
	local t_ = {};
	t_.rot <- 180;
	this.flag2.dish.append(this.SetFreeObject(this.x - 90 * this.direction, this.y, this.direction, this.Shot_Barrage_Option, t_).weakref());
	local t_ = {};
	t_.rot <- 270;
	this.flag2.dish.append(this.SetFreeObject(this.x, this.y - 90, this.direction, this.Shot_Barrage_Option, t_).weakref());
	this.subState = function ()
	{
		local c_ = this.count % 40;

		if (c_ == 11 || c_ == 14 || c_ == 17)
		{
			this.PlaySE(1853);

			foreach( a in this.flag2.dish )
			{
				a.func[1].call(a);
			}
		}
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2501, 0);

	if (this.brokenDish >= 4)
	{
		this.invin = 10;
		this.invinObject = 10;
	}

	if (this.brokenDish >= 7)
	{
		this.invin = 15;
		this.invinObject = 15;
	}

	if (this.brokenDish >= 10)
	{
		this.invin = 0;
		this.invinObject = 0;
	}

	this.PlaySE(1831);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.SetEffect(this.x, this.y - 30, this.direction, this.EF_ChargeO, {});
	this.PlaySE(1074);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,25000000.0, null);

			if (this.brokenDish == 0)
			{
				this.Okult_Miss(null);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			if (this.brokenDish == 9)
			{
				this.PlaySE(1836);
			}
			else
			{
				this.PlaySE(1833);
			}

			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Okult, {});
			this.hitResult = 1;
			this.brokenDish = 0;
			this.dish_guage.func[1].call(this.dish_guage, this.brokenDish);

			if (this.y <= this.centerY || this.centerStop * this.centerStop <= 1)
			{
				this.centerStop = -3;
				this.SetSpeed_XY(-10,00000000.0 * this.direction, -6,00000000.0);
			}
			else
			{
				this.centerStop = 3;
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 6,00000000.0);
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(0,30000001.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(this.va.x * this.direction < -2,00000000.0 ? 0,40000001.0 : 0,05000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Okult_Miss( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1832);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
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
	this.SetMotion(3000, 0);
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
		null
	];
	return true;
}

function SP_B_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_B_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.SetMotion(3010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.PlaySE(1903);
	this.flag2 = -60 * 0,01745329.0;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(1904);
			this.count = 0;
			local t_ = {};
			t_.rot <- this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.SetSpeed_Vec(-10,00000000.0, t_.rot, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,40000001.0);
				this.centerStop = 2;
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
	};
	return true;
}

function SP_B_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.SetMotion(3011, 0);
	this.count = 0;
	this.flag1 = 0;
	this.PlaySE(1903);
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.flag2 = -60 * 0,01745329.0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.PlaySE(1904);
			this.count = 0;
			local t_ = {};
			t_.rot <- this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.SetSpeed_Vec(-10,00000000.0, t_.rot, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,40000001.0);
				this.centerStop = 2;
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,10000000.0);
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.SetMotion(3020, 0);
	this.flag1 = 4,00000000.0;
	this.flag2 = 6;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,02500000.0);
		}

		this.CenterUpdate(0,10000000.0, 2,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(1907);
			local t_ = {};
			t_.scale <- this.flag1;
			t_.k <- this.flag2;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,02500000.0);
				}
			};
		}
	];
	return true;
}

function SP_D_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_D_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.hitCount = 0;
	this.atk_id = 8388608;
	this.SetMotion(3032, 0);
	this.count = 0;
	this.flag3 = this.y - 50;
	this.PlaySE(1910);
	this.SetSpeed_XY(-8,00000000.0 * this.direction, -0,75000000.0 * 15);
	this.centerStop = -2;
	this.keyAction = [
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.count = 0;
			this.PlaySE(1911);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(null, 0,00000000.0);
			this.lavelClearEvent = function ()
			{
				local t_ = {};
				t_.v <- this.va.x;
				t_.vy <- this.va.y;
				t_.type <- this.motion - 3030;
				t_.atk <- false;
				this.SetShot(this.x, this.y, this.direction, this.SPShot_D, t_);
			};
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,00000000.0, 0,00000000.0, 30,00000000.0, this.direction);

				if (this.hitResult & 1)
				{
					this.collisionFree = true;
				}

				if (this.count >= 45 || this.va.x * this.direction > 5,00000000.0 && this.IsWall(this.va.x) || this.hitResult && !(this.hitResult & 1))
				{
					this.lavelClearEvent = null;
					this.collisionFree = false;
					local t_ = {};
					t_.v <- this.va.x;
					t_.vy <- this.va.y;
					t_.type <- this.motion - 3030;
					t_.atk <- false;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_D, t_);
					this.SP_D_End(null);
					return;
					this.SetMotion(this.motion, 8);
					this.centerStop = -2;

					if (this.abs(this.y - this.centerY) <= 100 + 50)
					{
						this.SetSpeed_XY(-4,00000000.0 * this.direction, -10,00000000.0);
					}
					else if (this.y < this.centerY)
					{
						this.SetSpeed_XY(-4,00000000.0 * this.direction, -10,00000000.0);
					}
					else
					{
						this.SetSpeed_XY(-4,00000000.0 * this.direction, -18,50000000.0);
					}

					this.stateLabel = function ()
					{
						if (this.y < this.centerY)
						{
							this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
						}

						this.VX_Brake(0,10000000.0);

						if (this.va.y > 0 && this.y > this.centerY)
						{
							this.centerStop = 1;
							this.SetMotion(this.motion, 11);
							this.SetSpeed_XY(this.va.x * 0,50000000.0, 3,00000000.0);
							this.stateLabel = function ()
							{
								this.VX_Brake(0,50000000.0);
							};
						}
					};
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 1,00000000.0);

		if (this.count >= 15 || this.va.y > 0,00000000.0 && this.y >= this.flag3)
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
				this.Vec_Brake(2,00000000.0);
			};
		}
	};
	return true;
}

function SP_D_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitCount = 0;
	this.atk_id = 8388608;
	this.SetMotion(3035, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag3 = this.y;
	this.PlaySE(1910);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.flag2 = this.y <= this.centerY ? -1 : 1;
			this.count = 0;
			this.PlaySE(1911);
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.lavelClearEvent = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,00000000.0, 0,00000000.0, 12,00000000.0, this.direction);

				if (this.hitResult & 1)
				{
					this.collisionFree = true;
				}

				if (this.count >= 30)
				{
					this.lavelClearEvent = null;
					this.collisionFree = false;
					local t_ = {};
					t_.v <- this.va.x;
					t_.vy <- this.va.y;
					t_.type <- this.flag1;
					t_.atk <- false;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_D, t_);
					this.SetMotion(3035, 3);
					this.SetSpeed_XY(4,00000000.0 * this.direction, 2,00000000.0 * this.flag2);
					this.centerStop = 2 * this.flag2;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(3035, 8);
							this.stateLabel = function ()
							{
								this.VX_Brake(0,50000000.0);
							};
							return;
						}
					};
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			if (this.flag2 == 1)
			{
				this.SetMotion(3035, 6);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,50000000.0);
	};
	return true;
}

function SP_D_Hit( t )
{
	this.LabelClear();
	this.SetMotion(3031, 0);
	this.SetSpeed_XY(-5,00000000.0 * this.direction, -10,00000000.0);
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function SP_D_End( t )
{
	this.LabelClear();
	this.SetMotion(3038, 0);
	this.centerStop = -2;

	if (this.y <= this.centerY)
	{
		if (this.y < this.centerY - 125)
		{
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -6,00000000.0);
		}
		else
		{
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -10,00000000.0);
		}

		this.stateLabel = function ()
		{
			if (this.y < this.centerY)
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
			}

			this.VX_Brake(0,10000000.0);

			if (this.va.y > 0 && this.y >= this.centerY)
			{
				this.centerStop = 1;
				this.SetMotion(this.motion, 3);
				this.SetSpeed_XY(this.va.x * 0,50000000.0, 3,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
	}
	else
	{
		this.SetSpeed_XY(-6,00000000.0 * this.direction, -12,50000000.0);
		this.stateLabel = function ()
		{
			if (this.y < this.centerY + 50)
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
			}

			this.VX_Brake(0,10000000.0);

			if (this.va.y > 0 && this.y >= this.centerY)
			{
				this.centerStop = 1;
				this.SetMotion(this.motion, 3);
				this.SetSpeed_XY(this.va.x * 0,50000000.0, 3,00000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		};
	}
}

function SP_D_RideOffFront()
{
	this.LabelClear();
	this.SetMotion(3033, 0);
	this.SetSpeed_XY(10,00000000.0 * this.direction, -10,00000000.0);
	this.centerStop = -2;
	this.hitResult = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function SP_D_RideOffBack()
{
	this.LabelClear();
	this.SetMotion(3034, 0);
	this.SetSpeed_XY(-8,00000000.0 * this.direction, -10,00000000.0);
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16777216;
	this.SetMotion(3040, 0);
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.flag1 = 0,00000000.0;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.rot <- this.flag1;
			this.PlaySE(1913);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_E, t_);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.CenterUpdate(0,10000000.0, null);
		}
	};
	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 33554432;
	this.SetMotion(3050, 0);
	this.flag1 = 100 - this.dishLevel * 50;
	this.flag2 = -90 * 0,01745329.0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.SetSpeed_XY(15,00000000.0 * this.direction, -1,00000000.0);
	this.flag2 = -60 * 0,01745329.0;
	this.centerStop = -2;
	this.PlaySE(1916);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, this.va.y < 20 ? 1,50000000.0 : 0,00000000.0);
		this.VX_Brake(0,34999999.0);

		if (this.ground)
		{
			this.SetMotion(3050, 3);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = null;
		}
	};
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			::camera.shake_radius = 7,00000000.0;
			local t_ = {};
			t_.type <- 0;
			t_.rot <- this.flag2;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_F, t_);
			this.centerStop = -2;
			this.SetSpeed_Vec(33,00000000.0, this.flag2, this.direction);
			this.PlaySE(1917);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.y <= this.centerY)
				{
					this.Vec_Brake(2,50000000.0);

					if (this.va.LengthXY() < 9,00000000.0)
					{
						if (this.hitResult & 8)
						{
							this.count = 0;
							this.stateLabel = function ()
							{
								this.Vec_Brake(2,50000000.0);

								if (this.count == 5)
								{
									this.SetMotion(this.motion, 7);
									this.stateLabel = function ()
									{
									};
								}
							};
							return;
						}

						this.keyAction = this.EndtoFallLoop;
						this.PlaySE(1918);
						this.centerStop = -2;
						this.SetSpeed_XY(this.va.x, -9,00000000.0);
						this.SetMotion(this.motion, 6);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		}
	];
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.flag4 = null;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(1930);
			local list_ = [];
			local i = 0;
			local t_ = {};
			t_.rot <- 0;
			t_.rate <- this.atkRate_Pat;
			local core_ = this.SetShot(this.x, this.y, this.direction, this.SpellShot_A, t_);
			local sub_;

			for( i++; i < 5; i++ )
			{
				local t_ = {};
				t_.rot <- i * 72 * 0,01745329.0;
				t_.rate <- this.atkRate_Pat;
				sub_ = this.SetShot(this.x, this.y, this.direction, this.SpellShot_A_Sub, t_);
				sub_.hitOwner = core_.weakref();
			}

			this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_A2, {}).weakref();
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
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 50)
				{
					this.SetMotion(this.motion, 4);

					if (this.flag4)
					{
						this.flag4.func();
					}

					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.centerStop = -2;
			this.SetSpeed_Vec(17,50000000.0, -120 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(1,20000005.0, 1,00000000.0);
			};
			this.PlaySE(1932);
		},
		function ()
		{
			this.PlaySE(1933);
			this.hitResult = 1;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.team.spell_enable_end = false;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_);
			this.SetSpeed_Vec(6,00000000.0, -120 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,40000001.0);
			};
		}
	];
	return true;
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4020, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.UseSpellCard(60, -this.team.sp_max);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(1967);
			this.stateLabel = function ()
			{
				if (this.count >= 35)
				{
					this.SetSpeed_XY(0,00000000.0, -7,50000000.0);
					this.centerStop = -2;
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,30000001.0, 0,50000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(1958);
			this.hitResult = 1;
			this.team.spell_enable_end = false;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C, t_);
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = null;
	this.flag2 = this.Vector3();
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–Ž€‚ñ‚\x253c‚àˆê–‡‘«‚è‚\x255a‚¢I–");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();

				if (this.flag1)
				{
					this.flag1.func[3].call(this.flag1);
				}
			};
			this.flag2 = this.Vector3();
			this.GetPoint(0, this.flag2);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.flag2.x, this.flag2.y, this.direction, this.Climax_Well, t_).weakref();
			this.flag2.x -= this.x;
			this.flag2.y -= this.y;
			this.stateLabel = function ()
			{
				if (this.flag1)
				{
					this.flag1.x = this.x + this.flag2.x;
					this.flag1.y = this.y + this.flag2.y;
				}
			};
		},
		function ()
		{
			this.PlaySE(1837);
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.stateLabel = function ()
			{
				::camera.shake_radius = 1,50000000.0;

				if (this.flag1)
				{
					this.flag1.x = this.x + this.flag2.x;
					this.flag1.y = this.y + this.flag2.y;
				}

				if (this.hitResult & 1)
				{
					this.Spell_Climax_Hit(null);
					return;
				}

				if (this.count >= 120)
				{
					this.PlaySE(1842);

					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.lavelClearEvent = function ()
					{
						::battle.enableTimeUp = true;
						this.lastword.Deactivate();
					};
					this.SetMotion(4900, 3);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.PlaySE(1838);
	::battle.enableTimeUp = false;
	this.flag1.func[2].call(this.flag1);
	this.count = 0;
	this.flag2 = 2,00000000.0;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 120)
		{
			this.SetMotion(4901, 1);
		}

		if (this.count >= 160)
		{
			this.Spell_Climax_Finish(null);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(1839);
			this.subState = function ()
			{
				if (this.flag1)
				{
					this.flag2 += (25,00000000.0 - this.flag2) * 0,05000000.0;
					::camera.SetTarget(this.flag1.x + 25 * this.direction, this.flag1.y - 15, this.flag2, false);
				}
			};
		}
	];
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.count = 0;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			this.flag2 += (25,00000000.0 - this.flag2) * 0,05000000.0;
			::camera.SetTarget(this.flag1.x + 25 * this.direction, this.flag1.y - 15, this.flag2, false);
		}

		if (this.count == 10)
		{
			this.FadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 20);
		}

		if (this.count == 50)
		{
			if (this.flag1)
			{
				this.flag1.func[3].call(this.flag1);
			}

			this.EraceBackGround();
			this.FadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 1);
			this.SetMotion(4901, 3);
			this.team.target.DamageGrab_Common(308, 0, -this.direction);
			this.team.target.x = this.x;
			this.team.target.y = this.y;
			this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_HitSmash, {});
			this.flag3.Add(this.SetFreeObject(640 - 640 * this.direction, 0, this.direction, this.Climax_BackA, {}));
		}

		if (this.count == 90)
		{
			this.PlaySE(1840);
			this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
			::camera.shake_radius = 20,00000000.0;
			local t_ = {};
			t_.count <- 120;
			t_.priority <- 520;
			this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
			this.flag3.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.flag3.Add(this.SetFreeObject(640, 360, this.direction, this.Climax_CutA, {}));
			this.flag3.Add(this.SetFreeObject(640, 360, this.direction, this.Climax_CutB, {}));
			this.flag3.Add(this.SetFreeObject(640 - 260 * this.direction, 360 - 110, this.direction, this.Climax_HitEffect, {}));
			this.flag3.Add(this.SetFreeObject.call(this.team.target, 640 - 320 * this.direction, 200, this.direction, this.Climax_EnemyMove, {}));
		}

		if (this.count == 200)
		{
			this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 0);
			::camera.ResetTarget();
		}

		if (this.count == 202)
		{
			this.flag3.Foreach(function ()
			{
				if (this.func[0])
				{
					this.func[0].call(this);
				}
			});
			this.EraceBackGround(false);
			this.SetMotion(4901, 4);
			this.team.target.sx = this.team.target.sy = 1,00000000.0;
			this.team.target.freeMap = false;
			this.team.target.x = this.x - 100 * this.direction;
			this.team.target.y = ::battle.scroll_top - 200;
			::camera.ForceTarget();
			this.KnockBackTarget(this.direction);
			this.team.target.DrawActorPriority(190);
			this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 45);
			this.BackFadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 0);
		}

		if (this.count == 240)
		{
			::battle.enableTimeUp = true;
			this.SetMotion(4901, 5);
			this.stateLabel = null;
		}
	};
}

