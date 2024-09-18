function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 0)
	{
		this.BeginBattle_Reimu(null);
		return;
	}

	this.BeginBattle(null);
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
		this.WinB(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattle( t )
{
	local r_ = this.rand() % 2;

	if (r_ == 0)
	{
		this.BeginBattleA(null);
	}
	else
	{
		this.BeginBattleB(null);
		  // [020]  OP_JMP            0      0    0    0
	}
}

function BeginBattleA( t )
{
	this.LabelClear();
	this.Warp(this.x - 400 * this.direction, ::battle.scroll_top - 200);
	this.SetSpeed_XY(15.00000000 * this.direction, 22.00000000);
	this.count = 0;

	if (this.eagle)
	{
		this.eagle.Eagle_BeginBattle(null);
	}

	this.flag1 = this.Vector3();
	this.flag1.x = ::battle.start_x[this.team.index];
	this.flag1.y = ::battle.start_y[this.team.index];
	this.SetMotion(9000, 0);
	this.centerStop = -3;
	this.centerStopCheck = -1;
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.PlaySE(3039);
		}

		this.VX_Brake(this.va.x * this.direction > 3.00000000 ? 0.50000000 : 0.02500000);
		this.VY_Brake(this.va.y > 1.50000000 ? 0.50000000 : 0.02500000);

		if (this.count >= 120)
		{
			if (this.eagle)
			{
				this.eagle.Eagle_Wait(null);
			}

			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(null, -4.50000000);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.x = this.flag1.x;
					this.count = 0;
					this.SetSpeed_XY(0.00000000, null);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);

						if (this.count >= 60)
						{
							this.CommonBegin();
							this.LabelClear();
							this.stateLabel = this.Stand;
						}
					};
				}
			};
		}
	};
}

function BeginBattleB( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 6);
	this.demoObject = [];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.demoObject.append(this.SetFreeObjectStencil(this.x - 550 * this.direction, this.y - 10, this.direction, this.BeginBattleB_Object, {}).weakref());
		}
	};
}

function BeginBattleB_Fall( t )
{
	this.SetMotion(9001, 3);
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0.00000000, null);
		this.x = ::battle.start_x[this.team.index];
		this.CommonBegin();
		this.SetMotion(0, 0);
		this.LabelClear();
		this.stateLabel = this.Stand;
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y > this.centerY)
		{
			this.centerStop = 1;
			this.SetSpeed_XY(null, 3.00000000);
			this.count = 0;
			this.SetMotion(9001, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
}

function BeginBattle_Reimu( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9002, 0);
	this.demoObject = [];
	this.team.slave.BeginBattle_Slave(null);
	this.DrawActorPriority();
	this.keyAction = [
		null,
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

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.Warp(this.x + 45 * this.direction, this.y + 5);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
}

function WinA( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(9010, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.CommonWin();
		}
	};
}

function WinB( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(9011, 0);
	this.flag1 = this.rand() % 2;
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.SetMotion(9011, 1 + this.flag1 * 2);
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.CommonWin();
		}
	};
}

function Lose( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(9020, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.eagle.Eagle_Lose(null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
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

function MoveFront_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(4.75000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-4.75000000 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -14.00000000;
	t_.v2 <- -4.00000000;
	t_.v3 <- 14.00000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -14.00000000;
	t_.v2 <- -4.00000000;
	t_.v3 <- 14.00000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 14.00000000;
	t_.v2 <- 4.00000000;
	t_.v3 <- 14.00000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 14.00000000;
	t_.v2 <- 4.00000000;
	t_.v3 <- 14.00000000;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = -7.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = 7.50000000;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 5.00000000;
	t_.addSpeed <- 0.30000001;
	t_.maxSpeed <- 14.00000000;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7.25000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 75;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 12.00000000;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-9.50000000 * this.direction, -5.00000000);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.44999999);

		if (this.y > this.centerY && this.va.y > 0.00000000)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2.50000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -7.25000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 75;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 12.00000000;
	this.DashBack_Air_Common(t_);
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3000);
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
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
			this.PlaySE(3000);
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(7.00000000 * this.direction, null);
			this.PlaySE(3002);
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
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			if (this.va.x * this.direction >= 0.00000000)
			{
				this.SetSpeed_XY(7.00000000 * this.direction, null);
			}

			this.PlaySE(3002);
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
	this.SetMotion(1110, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3004);
		},
		null,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(1110, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3010);
			this.SetSpeed_XY(-10.00000000 * this.direction, -10.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
				this.AddSpeed_XY(0.00000000, 0.50000000);
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
		this.Vec_Brake(0.50000000);
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.flag1 = true;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3010);
			this.SetSpeed_XY(-7.00000000 * this.direction, -8.50000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
				this.AddSpeed_XY(0.00000000, 0.50000000);
			};
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

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1211, 0);
	this.atk_id = 1024;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1211, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};

	if (this.y <= this.centerY)
	{
		this.keyAction = [
			function ()
			{
				this.PlaySE(3017);
				this.centerStop = -2;
				this.SetSpeed_XY(-10.00000000 * this.direction, -7.50000000);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.50000000);
					this.VX_Brake(0.25000000);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0.75000000);
					}
				};
			}
		];
	}
	else
	{
		this.keyAction = [
			function ()
			{
				this.PlaySE(3017);
				this.centerStop = -2;
				this.SetSpeed_XY(-10.00000000 * this.direction, -12.50000000);
				this.stateLabel = function ()
				{
					if (this.y < this.centerY)
					{
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0.00000000, 0.50000000);
							this.VX_Brake(0.25000000);

							if (this.y <= this.centerY && this.va.y > 0)
							{
								this.SetMotion(this.motion, 3);
								this.centerStop = 1;
								this.stateLabel = function ()
								{
									this.VX_Brake(0.75000000);
								};
							}
						};
					}

					this.AddSpeed_XY(0.00000000, 0.50000000);
					this.VX_Brake(0.25000000);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 3);
						this.centerStop = 1;
						this.stateLabel = function ()
						{
							this.VX_Brake(0.75000000);
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
						this.VX_Brake(0.75000000);
					}
				};
			}
		];
	}

	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.hitCount = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3008);
			this.SetSpeed_XY(10.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.60000002);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000, 2.00000000);
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.hitCount = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3008);
			this.SetSpeed_XY(-2.50000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.60000002);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.hitCount = 0;

	if (this.y > this.centerY)
	{
		this.SetMotion(1222, 0);
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.34999999, 3.00000000);
			this.VX_Brake(0.05000000);
		};
	}
	else
	{
		this.SetMotion(1221, 0);
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.15000001, 3.00000000);
			this.VX_Brake(0.05000000);

			if (this.subState())
			{
				return;
			}
		};
	}

	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3015);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.15000001, 3.00000000);

				if (this.subState())
				{
					return;
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 32;
	this.flag1 = false;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighUnder_Init(t);
	this.SetMotion(1740, 0);
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
	this.flag1 = true;
	this.subState = function ()
	{
		if (this.input.b1 <= 0)
		{
			this.flag1 = false;
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3006);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
			this.PlaySE(3012);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.30000001, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
		},
		function ()
		{
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 3);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
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
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3012);
		},
		function ()
		{
			this.HitTargetReset();
		},
		function ()
		{
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.30000001, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1300, 0);
	this.atk_id = 4096;
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.00000000 * this.direction, null);
			this.PlaySE(3019);
			this.stateLabel = function ()
			{
				if (this.hitCount <= 2)
				{
					this.HitCycleUpdate(3);
				}

				this.VX_Brake(0.75000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.10000000);
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1310, 0);
	this.atk_id = 8192;
	this.centerStop = -2;
	this.SetSpeed_XY(8.00000000 * this.direction, -8.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3010);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.15000001);
				this.AddSpeed_XY(0.00000000, 0.40000001);

				if (this.va.y > 0.00000000 && this.y >= this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(1310, 2);
					this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.15000001);
		this.AddSpeed_XY(0.00000000, 0.40000001);
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

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1.00000000)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1.00000000)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.target.DamageGrab_Common(301, 2, -this.direction);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
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
	this.target.DamageGrab_Common(302, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.target.autoCamera = true;
		},
		function ()
		{
			this.flag1.func[0].call(this.flag1);
			this.target.Warp(this.point0_x, this.point0_y);
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;
			this.HitReset();
			this.hitResult = 1;
			this.target.team.regain_life -= ((this.target.team.regain_life - this.target.team.life) * 0.50000000).tointeger();
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
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
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- 0.00000000;
			t.flag1 <- 1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2003, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- 0.00000000;
			t.flag1 <- 1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2002, 0);
	this.count = 0;
	this.flag1 = 0;
	this.PlaySE(3023);
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- -50.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2005, 0);
	this.count = 0;
	this.flag1 = 0;
	this.PlaySE(3023);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2005, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- -50.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.PlaySE(3023);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- 50.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2004, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.75000000);
	this.AjustCenterStop();
	this.PlaySE(3023);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3021);
			local t = {};
			t.rot <- 50.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.VX_Brake(0.10000000);
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.40000001, 1.00000000);
		this.subState();
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.flag1 = null;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.flag2 = this.Vector3();
			this.GetPoint(0, this.flag2);
			this.flag1 = this.SetShot(this.flag2.x, this.flag2.y, this.direction, this.Shot_Front, {}).weakref();
			this.flag2.x -= this.x;
			this.flag2.y -= this.y;
			this.PlaySE(3024);
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[1].call(this.flag1);
				}
			};
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);

				if (this.count >= 40)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.lavelClearEvent = null;
					this.SetMotion(2010, 3);
					this.stateLabel = null;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.flag1 = null;
	this.SetMotion(2011, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.flag2 = this.Vector3();
			this.GetPoint(0, this.flag2);
			this.flag1 = this.SetShot(this.flag2.x, this.flag2.y, this.direction, this.Shot_Front, {}).weakref();
			this.flag2.x -= this.x;
			this.flag2.y -= this.y;
			this.PlaySE(3024);
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[1].call(this.flag1);
				}
			};
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, null);
				this.VX_Brake(0.50000000);

				if (this.count >= 40)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.lavelClearEvent = null;
					this.SetMotion(2011, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.10000000, null);
						this.subState();
					};
					return;
				}
			};
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
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);
		this.subState();
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5.00000000;
	this.flag2.vy <- 3.00000000;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.count = 0;
	this.flag1 = null;
	this.flag2 = this.Vector3();
	this.flag2.x = t.kx;
	this.flag2.y = t.ky;
	this.flag3 = true;
	this.flag4 = this.Vector3();
	this.flag5 = t.charge;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.GetPoint(0, this.flag4);
			this.PlaySE(3027);
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.v <- 20.00000000;
			t_.charge <- this.flag5;
			this.flag1 = this.SetShot(this.flag4.x, this.flag4.y, this.direction, this.Shot_Charge, t_).weakref();
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.25000000, 1.00000000);

				if (this.flag1)
				{
					this.GetPoint(0, this.flag4);
					this.flag1.SetSpeed_XY((this.flag4.x - this.flag1.x) * 0.50000000, (this.flag4.y - this.flag1.y) * 0.50000000);
				}
			};
		},
		function ()
		{
			this.PlaySE(3026);
			this.centerStop = -2;
			this.SetSpeed_XY(-8.00000000 * this.direction, -3.00000000);

			if (this.flag1)
			{
				this.flag1.initTable.rot = 0.00000000;
				this.flag1.initTable.v = 20.00000000;

				if (this.flag2.x * this.direction > 0)
				{
					this.flag1.initTable.v = 25.00000000;
				}

				if (this.flag2.x * this.direction < 0)
				{
					this.flag1.initTable.v = 15.00000000;
				}

				if (this.flag2.y < 0)
				{
					this.flag1.initTable.rot = -30.00000000 * 0.01745329;
				}

				if (this.flag2.y > 0)
				{
					this.flag1.initTable.rot = 30.00000000 * 0.01745329;
				}

				this.flag1.func[1].call(this.flag1);
				this.flag1 = null;
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
				this.AddSpeed_XY(0.00000000, 0.20000000);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 1.50000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.15000001);
		}
	};
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 90 == 11)
			{
				this.PlaySE(3027);
				local t_ = {};
				t_.rot <- (15 - this.rand() % 90) * 0.01745329;
				this.SetShot(this.x, this.y, this.direction, this.Shot_Barrage_Core, t_);
			}

			if (this.count % 90 == 56)
			{
				this.PlaySE(3027);
				local t_ = {};
				t_.rot <- (15 - this.rand() % 90) * 0.01745329;
				this.SetShot(this.x, this.y, -this.direction, this.Shot_Barrage_Core, t_);
			}
		}
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2500, 0);
	this.flag1 = null;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop > 1)
	{
		this.AjustCenterStop();
	}

	this.func = [
		function ()
		{
			this.SetMotion(2500, 3);
			this.stateLabel = null;
		}
	];
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.PlaySE(3059);
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Okult, {}).weakref();
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag1)
				{
					if (this.flag1.hitResult & 1)
					{
						this.Okult_Catch_Init(null);
						return;
					}

					if (this.count >= 20 && (this.input.b0 == 0 || this.input.b1 == 0 || ::battle.state != 8) || this.flag1.cancelCount <= 0 || this.flag1.hitCount > 0 || this.count > 60 || this.flag1.va.x > 0.00000000 && this.flag1.x > ::battle.scroll_right || this.flag1.va.x < 0.00000000 && this.flag1.x < ::battle.scroll_left)
					{
						this.flag1.func[2].call(this.flag1);
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

function Okult_Catch_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2501, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1.func[1].call(this.flag1);
	this.count = 0;
	this.stateLabel = function ()
	{
	};
	this.func = [
		function ()
		{
			this.SetMotion(2501, 1);
			this.target.DamageGrab_Common(300, 1, this.target.direction);
			this.target.SetParent(this, this.point0_x - this.x, this.point0_y - this.y);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.target.SetParent(this, 53 * this.direction, -12);
		},
		function ()
		{
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.target.SetParent(this, 0, 0);
			this.hitResult = 1;
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(3061);
			this.target.SetParent(null, 0, 0);
			this.target.freeMap = false;
			this.target.x = this.x + 100 * this.direction;
			this.target.y = this.y;
			this.stateLabel = null;
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
		}
	];
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 1048576;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3000, 0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(3033);
			this.SetShotStencil(this.x - 200 * this.direction, this.y - 10, this.direction, this.SPShot_A_Tiger, {});
			this.stateLabel = function ()
			{
			};
		}
	];
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3010, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.eagle.Eagle_Catch(null);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.abs(this.eagle.x - this.x) <= 25 && this.abs(this.eagle.y - (this.y - 85)) <= 25)
				{
					this.SP_B2_Init(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = null;
			this.eagle.Eagle_Wait(null);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
		this.CenterUpdate(0.10000000, 1.00000000);
	};
	return true;
}

function SP_B2_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3011, 0);
	this.PlaySE(3039);
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.centerStop = -2;
	this.count = 0;
	this.team.AddMP(-200, 120);
	this.flag1 = false;
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			local t_ = 0;

			if (this.input.x > 0)
			{
				t_ = 1.00000000;
			}

			if (this.input.x < 0)
			{
				t_ = -1.00000000;
			}

			if (t_)
			{
				this.AddSpeed_XY(t_, null, t_ > 0 ? 6.00000000 : -6.00000000, null);
			}
			else
			{
				this.VX_Brake(0.75000000, this.va.x <= 0.00000000 ? -2.00000000 : 2.00000000);
			}
		}
		else if (this.VX_Brake(0.75000000, -6.00000000 * this.direction))
		{
			this.flag1 = true;
		}

		this.SetSpeed_XY(null, (200 - this.y) * 0.05000000);
		this.eagle.x = this.x;
		this.eagle.y = this.y - 105;

		if (this.y < this.centerY)
		{
			if (this.input.b0 > 0)
			{
				this.SP_B3_Init(null);
				return;
			}

			if (this.input.b1 > 0)
			{
				this.SP_B4_Init(null);
				return;
			}
		}

		if (this.count >= 120 || this.count >= 15 && (this.input.y > 0 || ::battle.state != 8))
		{
			this.count = 0;
			this.eagle.Eagle_Wait(null);
			local x_ = this.va.x;

			if (this.input.x)
			{
				x_ = this.input.x * this.direction > 0 ? 4.50000000 * this.direction : -6.50000000 * this.direction;
			}

			this.SetSpeed_XY(x_, 0.00000000);
			this.AjustCenterStop();
			this.SetMotion(3011, 1);
			this.stateLabel = function ()
			{
				if (this.count >= 8)
				{
					this.EndtoFallLoop();
					return;
				}
			};
		}
	};
	return true;
}

function SP_B3_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.SetMotion(3012, 0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3043);
			this.SetSpeed_XY(15.00000000 * this.direction, 17.50000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.eagle.x = this.x;
				this.eagle.y = this.y - 85;
				this.VX_Brake(0.20000000);
				this.AddSpeed_XY(0.00000000, -1.00000000);

				if (this.count == 26)
				{
					this.SetMotion(3012, 3);
					this.eagle.Eagle_Wait(null);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.20000000);
						this.AddSpeed_XY(0.00000000, 0.30000001);
					};
				}
			};
		},
		null,
		null
	];
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -2.00000000 ? 0.15000001 : 0.01000000);
		this.SetSpeed_XY(null, (200 - this.y) * 0.05000000);
		this.eagle.x = this.x;
		this.eagle.y = this.y - 85;
	};
	return true;
}

function SP_B4_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3013, 0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.eagle.Eagle_PreAssult(null);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
			this.count = 0;
			local t_ = {};
			t_.direction <- this.direction;

			if (this.mark.len() > 0)
			{
				this.eagle.Eagle_MarkAssult(t_);
			}
			else
			{
				this.eagle.Eagle_Assult(t_);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -3.00000000 ? 0.50000000 : 0.02500000);
				this.AddSpeed_XY(0.00000000, this.va.y < -1.00000000 ? 0.50000000 : 0.10000000);
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -2.00000000 ? 0.15000001 : 0.01000000);
		this.SetSpeed_XY(null, (200 - this.y) * 0.05000000);
		local pos_ = this.Vector3();
		this.GetPoint(0, pos_);
		this.eagle.x = pos_.x;
		this.eagle.y = pos_.y;
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.SetMotion(3020, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = true;
	this.flag2 = null;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.flag3 = 2.00000000;
	this.flag4 = 0;
	this.flag5 = t.rush;
	this.subState = function ()
	{
		if (this.flag5)
		{
			if (this.input.b0 == 0 || ::battle.state != 8)
			{
				this.flag1 = false;
			}
		}
		else if (this.input.b2 == 0 || ::battle.state != 8)
		{
			this.flag1 = false;
		}
	};
	this.keyAction = [
		function ()
		{
			this.flag2 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SP_C_Spark, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}
			};
			this.flag2.SetParent(this, this.flag2.x - this.x, this.flag2.y - this.y);
			this.count = 0;
			this.PlaySE(3030);
			this.stateLabel = function ()
			{
				this.subState();
				this.CenterUpdate(0.20000000, 2.50000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(1.00000000);
				}

				if (!this.flag1 && this.count >= 5 || this.count >= 120)
				{
					this.flag2.func[0].call(this.flag2);

					if (this.flag4 > 0)
					{
						this.SetMotion(3021, 2);
					}
					else
					{
						this.SetMotion(3020, 2);
					}

					this.stateLabel = function ()
					{
						this.CenterUpdate(0.20000000, 2.50000000);
						this.VX_Brake(0.50000000);
					};
					return;
				}

				if (this.count >= 10)
				{
					if (this.count % 20 == 1)
					{
						this.flag3 += 0.10000000;
					}

					if (this.count == 30 || this.count == 60)
					{
						this.flag4++;
						this.PlaySE(3030);
						local t_ = {};
						t_.scale <- 64 + 64 * this.flag4;
						this.SetFreeObjectDynamic(this.x - 55 * this.direction, this.y - 58, this.direction, this.SP_C_SparkCharge, t_);
					}
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-7.50000000 * this.direction, 0.00000000);
			this.PlaySE(3031);
			local t_ = {};
			t_.scale <- this.flag3;
			t_.num <- this.flag4;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.CenterUpdate(0.20000000, 2.50000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(1.00000000);
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3030, 0);
	this.keyAction = [
		function ()
		{
			if (!this.ball)
			{
				this.team.AddMP(-200, 120);
			}

			this.PlaySE(3033);

			if (this.ball)
			{
				local y_ = this.ball.va.y;
				local i = 0;
				local yb_ = 0;

				while (i < 12)
				{
					i++;
					y_ = y_ + (y_ < 0.00000000 ? 0.66000003 : 0.25000000);
					yb_ = yb_ + y_;
				}

				y_ = this.ball.y + y_ + 200;
				y_ = this.Math_MinMax(y_, this.centerY - 200, this.centerY + 300);
				local d_ = 1.00000000;

				if (this.ball.x > this.target.x)
				{
					d_ = -1.00000000;
				}

				this.SetShotStencil(this.ball.x + this.ball.va.x * 15, y_, d_, this.SPShot_D, {});
			}
			else
			{
				this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.SPShot_D, {});
			}

			this.stateLabel = function ()
			{
			};
		}
	];
	return true;
}

function SP_D_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.25000000);
	this.SetMotion(3031, 0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			if (!this.ball)
			{
				this.team.AddMP(-200, 120);
			}

			this.PlaySE(3033);
			this.seals = true;

			if (this.ball)
			{
				local y_ = this.ball.va.y;
				local i = 0;
				local yb_ = 0;

				while (i < 12)
				{
					i++;
					y_ = y_ + (y_ < 0.00000000 ? 0.66000003 : 0.25000000);
					yb_ = yb_ + y_;
				}

				y_ = this.ball.y + y_ + 200;
				y_ = this.Math_MinMax(y_, this.centerY - 200, this.centerY + 300);
				local d_ = 1.00000000;

				if (this.ball.x > this.target.x)
				{
					d_ = -1.00000000;
				}

				this.SetShotStencil(this.ball.x + this.ball.va.x * 15, y_, d_, this.SPShot_D, {});
			}
			else
			{
				this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.SPShot_D, {});
			}
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 16777216;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3040, 0);
	this.AjustCenterStop();
	this.flag2 = this.SetShot(this.x + 60 * this.direction, this.y - 20, this.direction, this.SPShot_E_Dragon, {}).weakref();
	this.PlaySE(3033);
	this.PlaySE(3045);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);

			if (this.flag2)
			{
				this.flag2.func[1].call(this.flag2);
			}

			this.stateLabel = function ()
			{
			};
		},
		null,
		function ()
		{
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
	this.AjustCenterStop();
	this.count = 0;
	this.ResetSpeed();
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(3069);
			this.flag1 = this.SetShotDynamic(this.point0_x, this.point0_y, this.direction, this.Spell_A_Net, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
		},
		function ()
		{
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1 && this.target.team.life > 0)
				{
					this.lavelClearEvent = null;
					this.Spell_A_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1 && this.target.team.life > 0)
				{
					this.lavelClearEvent = null;
					this.Spell_A_Hit(null);
					return;
				}

				if (this.count >= 25)
				{
					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.lavelClearEvent = null;
					this.SetMotion(4000, 5);
					this.stateLabel = null;
				}
			};
		}
	];
	return true;
}

function Spell_A_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4001, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.target.DamageGrab_Common(311, 0, -this.direction);
	this.flag2 = this.Vector3();
	this.flag2.x = -175;
	this.flag3 = this.Vector3();
	this.flag4 = this.SetFreeObject(this.target.x, this.target.y, -this.direction, this.Spell_A_HitCapture, {}).weakref();
	this.flag5 = this.Vector3();
	this.GetPoint(0, this.flag5);
	this.target.freeMap = true;
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.y;
	this.stateLabel = function ()
	{
		this.target.x += (this.point0_x - this.target.x) * 0.10000000;
		this.target.y += (this.point0_y - this.target.y) * 0.10000000;
		this.SetFreeObject(this.target.x + 35 - this.rand() % 70, this.target.y + 35 - this.rand() % 71, -this.direction, this.Spell_A_CapNet, {});

		if (this.count >= 40)
		{
			if (this.flag4)
			{
				this.flag4.func[0].call(this.flag4);
			}

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.count = 0;
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.SetMotion(4001, 1);
			this.PlaySE(3071);
			this.stateLabel = function ()
			{
				this.GetPoint(0, this.flag5);
				this.target.x = this.flag5.x;
				this.target.y = this.flag5.y;

				if (this.keyTake == 2)
				{
					::camera.shake_radius = 2.00000000;

					if (this.count % 6 == 1)
					{
						this.SetFreeObjectDynamic(this.point0_x, this.point0_y, this.direction, this.Spell_A_HitSpinEffect, {});
					}
				}

				if (this.count >= 90)
				{
					this.count = 0;
					this.SetMotion(4001, 3);
					this.target.cameraPos.x = this.x + 200 * this.direction;
					this.target.cameraPos.y = this.y;
					this.stateLabel = function ()
					{
						this.GetPoint(0, this.flag5);
						this.target.x = this.flag5.x;
						this.target.y = this.flag5.y;
					};
				}
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.target.cameraPos.x = this.target.x;
			this.target.cameraPos.y = this.y;
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(3073);
			this.GetPoint(0, this.flag5);
			this.target.x = this.flag5.x;
			this.target.y = this.flag5.y;
			this.target.freeMap = false;
			this.target.autoCamera = true;
			this.KnockBackTarget(this.direction);
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				return;

				if (this.flag4.x >= 1260 && this.direction == -1.00000000 || this.flag4.x < 20 && this.direction == 1.00000000)
				{
					this.flag4.SetMotion(4009, 1);
					::camera.shake_radius = 25.00000000;
					this.target.DamageGrab_Common(310, 0, this.direction);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count >= 40)
						{
							this.KnockBackTarget(this.direction);

							if (this.flag4)
							{
								this.flag4.ReleaseActor();
							}

							this.SetMotion(4001, 5);
							this.stateLabel = null;
						}
					};
				}
			};
		}
	];
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = this.Vector3();
	this.flag5 = null;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		null,
		function ()
		{
			this.hitResult = 1;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.PlaySE(3050);
			this.flag5 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				if (this.flag5)
				{
					this.GetPoint(0, this.flag1);
					this.flag5.x = this.flag1.x;
					this.flag5.y = this.flag1.y;
				}

				this.Vec_Brake(1.00000000, 1.00000000);
			};
		},
		function ()
		{
			this.stateLabel = null;
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
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = null;
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			this.flag1.x = this.point0_x;
			this.flag1.y = this.point0_y;
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3074);
			this.UseSpellCard(60, -this.team.sp_max);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C, t_).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(3075);
			this.flag1.func[1].call(this.flag1);
			this.flag1 = null;
			this.lavelClearEvent = null;
			this.SetSpeed_XY(-17.50000000 * this.direction, 0.00000000);
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 2.00000000);
				this.VX_Brake(this.va.x * this.direction < -2.00000000 ? 1.00000000 : 0.01000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
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
	this.SetMotion(4904, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = {};
	this.flag1.vortex <- null;
	this.flag1.arm <- null;
	this.flag2 = 6;
	this.subState = function ()
	{
		if (this.flag1.vortex && this.flag1.vortex.hitResult & 1)
		{
			this.Spell_Climax_Hit(null);
			return true;
		}

		this.flag2--;

		if (this.flag2 <= 0)
		{
			this.SetFreeObjectDynamic(this.x, this.y + 128 - this.rand() % 128, this.direction, this.Climax_VortexA, {}).weakref();
			this.flag2 = 4 + this.rand() % 4;
		}
	};
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–‰Ž‚\x2560Žè‚æI“G‚\x2261ˆ¬‚è‚\x252c‚\x2558‚\x2563I–");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(3052);
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.count == 5)
				{
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.flag1.vortex = this.SetShot(this.x, this.y, this.direction, this.Climax_VortexC, t_).weakref();
					this.flag1.vortex.SetParent(this, 0, 0);
				}

				if (this.count >= 60)
				{
					this.count = 0;
					this.SetMotion(4904, 4);
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						if (this.count >= 120)
						{
							this.SetMotion(4904, 5);
							this.flag1.vortex.func[0].call(this.flag1.vortex);
							this.count = 0;
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		}
	];
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4905, 0);
	this.target.freeMap = true;
	::battle.enableTimeUp = false;
	this.autoCamera = false;
	this.target.DamageGrab_Common(311, 0, -this.direction);
	this.target.SetSpeed_XY(0.00000000, 0.00000000);
	this.cameraPos.x = this.x;
	this.cameraPos.y = this.y;
	::camera.SetTarget(this.cameraPos.x, this.cameraPos.y, 2.00000000, false);
	this.flag2 = this.Vector3();
	this.flag2.x = 1.00000000;
	this.flag3 = 100;
	this.flag4 = 0;
	this.flag5 = 0.00000000;
	this.count = 0;
	this.subState = function ()
	{
		local x_ = (this.x + this.flag2.x * this.flag3 * this.direction - this.target.x) * 0.15000001;
		this.target.x += x_;
		this.target.y += (this.y + this.flag2.y * this.flag3 * 0.25000000 + this.flag4 - this.target.y) * 0.15000001;

		if (this.target.y < this.flag4 + this.y)
		{
			this.target.DrawActorPriority(170);
		}
		else
		{
			this.target.DrawActorPriority(210);
		}

		this.target.direction = x_ > 0.00000000 ? -1.00000000 : 1.00000000;
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.count++;
		this.flag3 = 500 + 60.00000000 * this.sin(this.count * 2 * 0.01745329);
		this.cameraPos.x = this.x;
		this.cameraPos.y = this.y;
		::camera.SetTarget(this.cameraPos.x, this.cameraPos.y, 2.00000000, false);
		this.flag2.RotateByDegree(15.00000000);
		this.flag4 -= 0.25000000;
		::camera.shake_radius = 1.50000000;

		if (this.count % 3 == 0)
		{
			this.SetFreeObjectDynamic(this.x, this.y + 128 - this.rand() % 128, this.direction, this.Climax_VortexA, {}).weakref();
		}

		if (this.count >= 150)
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();
				::camera.shake_radius = 2.00000000;
				this.cameraPos.x = this.x;
				this.cameraPos.y -= 0.25000000;
				::camera.SetTarget(this.cameraPos.x, this.cameraPos.y, 2.00000000, false);
				this.flag5 -= 0.20000000;
				this.flag4 += this.flag5;
				this.flag3 *= 0.99000001;
				this.flag2.RotateByDegree(20.00000000);

				if (this.count % 3 == 0)
				{
					this.SetFreeObjectDynamic(this.x, this.y + 128 - this.rand() % 128, this.direction, this.Climax_VortexA, {}).weakref();
				}

				if (this.count >= 60)
				{
					this.PlaySE(3054);
					this.flag1.vortex.func[0].call(this.flag1.vortex);
					this.SetMotion(4905, 1);
					this.flag1.arm = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_Arm, {}).weakref();
					this.flag1.arm.SetParent(this, this.flag1.arm.x - this.x, this.flag1.arm.y - this.y);
					this.count = 0;
					::camera.shake_radius = 10.00000000;
					this.stateLabel = function ()
					{
						this.subState();
						this.cameraPos.x = this.x;
						this.cameraPos.y -= 0.25000000;
						::camera.SetTarget(this.cameraPos.x, this.cameraPos.y, 2.00000000, false);
						this.flag5 -= 1.50000000;
						this.flag4 += this.flag5;
						this.flag3 *= 0.89999998;
						this.flag2.RotateByDegree(45.00000000);

						if (this.count == 60)
						{
							this.flag1.arm.func[0].call(this.flag1.arm);
							this.Spell_Climax_FinishB(null);
							return;
						}
					};
				}
			};
		}
	};
}

function Spell_Climax_FinishB( t )
{
	this.LabelReset();
	this.HitReset();
	this.ResetSpeed();
	this.count = 0;
	this.flag5 = null;
	this.flag4 = null;
	this.flag3 = this.Vector3();
	this.flag2 = 2.00000000;
	this.flag1 = {};
	this.flag1.addY <- 0.00000000;
	this.flag3.x = this.x;
	this.flag3.y = this.y - 60;
	this.count = 0;
	this.FadeOut(0.00000000, 0.00000000, 0.00000000, 30);
	this.stateLabel = function ()
	{
		this.target.y -= 40;
		this.flag3.y -= 25;
		::camera.SetTarget(this.flag3.x, this.flag3.y, this.flag2, false);

		if (this.count == 30)
		{
			this.PlaySE(3062);
			this.EraceBackGround(true);
			this.SetMotion(4905, 3);
			::camera.SetTarget(640, 360, 1.00000000, true);
			this.flag5 = this.SetFreeObject(640, 360, 1.00000000, this.Climax_FaceB, {}).weakref();
			this.flag5.sx = this.flag5.sy = 3.00000000;
			this.FadeIn(0.00000000, 0.00000000, 0.00000000, 10);
			this.count = 0;
			this.subState = function ()
			{
				local s_ = (1.00000000 - this.flag5.sx) * 0.20000000;

				if (s_ > -0.00025000)
				{
					s_ = 0.00250000;
					this.subState = function ()
					{
						this.flag5.sx = this.flag5.sy -= 0.00025000;
						this.flag5.y += 0.40000001;
						this.flag5.x -= 0.10000000;
					};
				}

				this.flag5.sx = this.flag5.sy += s_;
				this.flag5.x -= 2.00000000 * this.sin(20 * 0.01745329);
				this.flag5.y += 0.50000000 * this.cos(20 * 0.01745329);
			};
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 30)
				{
					this.flag5.func[0].call(this.flag5);
				}

				if (this.count == 170)
				{
					this.flag5.func[1].call(this.flag5);
					this.subState = function ()
					{
						local s_ = (1.00000000 - this.flag5.sx) * 0.10000000;

						if (s_ > -0.00025000)
						{
							s_ = 0.00025000;
						}

						this.flag5.sx = this.flag5.sy *= 1.01999998;
						this.flag5.x -= this.flag1.addY * this.sin(20 * 0.01745329) * this.flag5.sx;
						this.flag5.y += this.flag1.addY * this.cos(20 * 0.01745329) * this.flag5.sx;
						this.flag1.addY += 0.85000002;
					};
				}

				if (this.count == 170 + 20)
				{
					this.FadeOut(1.00000000, 1.00000000, 1.00000000, 30);
				}

				if (this.count == 170 + 50)
				{
					this.flag5.func[2].call(this.flag5);
					this.Spell_Climax_FinishB2(null);
				}
			};
		}
	};
}

function Spell_Climax_FinishB2( t )
{
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 20);
	this.SetMotion(4905, 3);
	this.target.DamageGrab_Common(308, 0, -this.direction);
	this.target.x = 640;
	this.target.y = -300;
	::camera.SetTarget(640, 360, 2.00000000, true);
	this.flag5 = {};
	this.flag5.back <- this.SetFreeObject(640, 0, this.direction, this.Spell_Climax_BackB, {}).weakref();
	this.flag5.arm <- null;
	local t_ = {};
	t_.motion <- 311;
	t_.keyTake <- 1;
	this.flag5.enemy <- this.target.SetFreeObject(640, -300, -1.00000000, this.DummyPlayer, t_).weakref();
	this.count = 0;
	this.flag4 = 0;
	this.stateLabel = function ()
	{
		this.flag5.back.y += (360 - this.flag5.back.y) * 0.10000000;
		this.flag5.enemy.y = this.flag5.back.y - 68 + this.flag4;
		this.flag4 += 0.50000000;

		if (this.count == 70)
		{
			this.flag5.arm = this.SetFreeObject(640, 360, 1.00000000, this.Climax_FinishArm, {}).weakref();
		}

		if (this.count == 100)
		{
			::camera.shake_radius = 10.00000000;
			this.flag5.arm.func[1].call(this.flag5.arm);
			this.KnockBackTarget(-this.direction);
			this.flag5.enemy.SetMotion(308, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 20)
				{
					this.FadeOut(1.00000000, 1.00000000, 1.00000000, 10);
				}

				if (this.count == 30)
				{
					this.PlaySE(3063);
				}

				if (this.count == 100)
				{
					this.target.freeMap = false;
					this.freeMap = false;
					this.target.team.master.enableKO = true;

					if (this.target.team.slave)
					{
						this.target.team.slave.enableKO = true;
					}

					this.target.autoCamera = true;
					this.autoCamera = true;
					::battle.enableTimeUp = true;
					this.SetMotion(4905, 4);
					this.FadeIn(1.00000000, 1.00000000, 1.00000000, 60);
					this.BackFadeIn(1.00000000, 1.00000000, 1.00000000, 60);
					this.KnockBackTarget(-this.direction);
					this.target.y = -1200;
					this.stateLabel = null;
					::camera.ResetTarget();
					this.EraceBackGround(false);
					this.target.DrawActorPriority(190);
					this.DrawActorPriority(190);
					this.flag5.enemy.ReleaseActor();
					this.flag5.arm.ReleaseActor();
					this.flag5.back.ReleaseActor();
				}
			};
		}
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelClear();
	this.FadeOut(0.00000000, 0.00000000, 0.00000000, 40);
	this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 40);
	this.HitReset();
	this.ResetSpeed();
	this.count = 0;
	this.target.freeMap = false;
	this.freeMap = false;
	this.target.DamageGrab_Common(308, 0, -this.direction);
	this.flag2 = 2.00000000;
	this.flag3 = this.Vector3();
	this.flag3.x = this.x;
	this.flag3.y = this.y - 40;
	this.stateLabel = function ()
	{
		this.flag2 += (4.00000000 - this.flag2) * 0.05000000;
		this.flag3.y += (0 - this.flag3.y) * 0.10000000;
		::camera.SetTarget(this.flag3.x, this.flag3.y, this.flag2, false);

		if (this.count == 60)
		{
			this.flag2 = 1.00000000;
			::graphics.ShowBackground(false);
			this.target.Warp(640, this.centerY);
			this.Warp(640, this.centerY);
			this.SetMotion(4902, 0);
			::camera.SetTarget(640, 360, 1.00000000, true);
			this.FadeIn(0.00000000, 0.00000000, 0.00000000, 20);
			this.flag5 = this.SetFreeObject(640, 360, this.direction, this.Climax_FaceA, {}).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 220)
				{
					this.Spell_Climax_Finish2();
				}
			};
		}
	};
}

function Spell_Climax_Finish2()
{
	this.count = 0;

	if (this.flag5)
	{
		this.flag5.func[0].call(this.flag5);
	}

	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 15);
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.Spell_Climax_Finish3();
		}
	};
}

function Spell_Climax_Finish3()
{
	this.count = 0;
	this.SetMotion(4902, 1);

	if (this.flag5)
	{
		this.flag5.func[1].call(this.flag5);
	}

	this.FadeOut(1.00000000, 1.00000000, 1.00000000, 10);
	::camera.SetTarget(640, 360, 1.00000000, true);
	this.flag2 = 2.00000000;
	this.flag3 = this.Vector3();
	this.flag3.x = 40;
	this.flag3.y = 360;
	this.flag4 = this.Vector3();
	this.flag4.y = -15.50000000;
	this.stateLabel = function ()
	{
		if (this.count == 10 && this.flag5)
		{
			this.flag5.func[2].call(this.flag5);
		}

		if (this.count == 30)
		{
			this.FadeIn(1.00000000, 1.00000000, 1.00000000, 20);
			this.target.DamageGrab_Common(304, 1, -this.direction);
			this.target.x = 640;
			this.target.y = 300;
			this.flag2 = 6.00000000;
			::camera.SetTarget(640, 360, this.flag2, true);
			this.flag5 = this.SetFreeObject(640, 360, this.direction, this.Spell_Climax_BackA, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.target.y -= this.flag4.y * 0.20000000;
				this.flag5.y += this.flag4.y * 0.50000000;
				this.flag4.y += 0.50000000;

				if (this.flag4.y > -1.00000000)
				{
					this.flag4.y = -1.00000000;
				}

				this.flag2 += (2.00000000 - this.flag2) * 0.07500000;
				::camera.SetTarget(640, 360, this.flag2, true);

				if (this.count == 90)
				{
					this.KnockBackTarget(-this.direction);
					this.target.DamageGrab_Common(301, 0, -this.direction);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 10)
						{
							this.FadeOut(1.00000000, 1.00000000, 1.00000000, 10);
						}

						if (this.count == 70)
						{
							::graphics.ShowBackground(true);
							this.target.freeMap = true;
							this.freeMap = true;
							this.target.team.master.enableKO = true;

							if (this.target.team.slave)
							{
								this.target.team.slave.enableKO = true;
							}

							this.target.autoCamera = true;
							this.flag5.ReleaseActor();
							this.SetMotion(4902, 2);
							this.FadeIn(1.00000000, 1.00000000, 1.00000000, 60);
							this.BackFadeIn(1.00000000, 1.00000000, 1.00000000, 60);
							this.KnockBackTarget(-this.direction);
							this.target.y = -1200;
							this.stateLabel = null;
							::camera.ResetTarget();
						}
					};
				}
			};
		}
	};
}

