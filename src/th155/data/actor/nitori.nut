function Func_BeginBattle()
{
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
		this.WinB(null);
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
	this.demoObject = [];
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2390);
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(2391);
			this.stateLabel = function ()
			{
				if (this.count >= 6)
				{
					if (this.flag1 <= 1)
					{
						this.flag1++;
						this.SetMotion(this.motion, 0);
						this.count = 0;
						this.stateLabel = null;
					}
					else
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = null;
					}
				}
			};
		},
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
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
	this.LabelClear();
	this.Warp(this.x - 500 * this.direction, this.y);
	this.keyAction = [
		null,
		function ()
		{
			this.flag1 = this.Vector3();

			if (this.team.index == 0)
			{
				this.flag1.x = ::battle.start_x[0];
				this.flag1.y = ::battle.start_y[0];
			}
			else
			{
				this.flag1.x = ::battle.start_x[1];
				this.flag1.y = ::battle.start_y[1];
			}

			this.centerStop = -2;
			this.SetSpeed_XY(0,00000000.0, -8,00000000.0);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((this.flag1.x - this.x) * 0,05000000.0, null);
				this.AddSpeed_XY(0,00000000.0, 0,30000001.0);

				if (this.y >= this.centerY)
				{
					this.centerStop = 2;
					this.SetSpeed_XY(0,00000000.0, this.va.y * 0,25000000.0);
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = null;
				}
			};
			this.demoObject.append(this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
			{
				this.SetMotion(9001, 5);
				this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, -0,10000000.0);

					if (this.IsScreen(300,00000000.0))
					{
						this.ReleaseActor();
					}
				};
			}, {}).weakref());
		},
		null,
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.PlaySE(2397);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.abs(640 - this.x) <= 100)
				{
					this.SetMotion(this.motion, 1);
					this.stateLabel = null;
				}
			};
		}
	};
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.Warp(this.team.master.x - 30 * this.direction, this.y);
	this.func = function ()
	{
		this.SetMotion(9002, 1);
		this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(2,00000000.0);
		};
	};
	this.keyAction = [
		null,
		null,
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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2392);

			for( local i = 0; i < 3; i++ )
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WinA_FireCore, {});
			}
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 30 || this.count == 75 || this.count == 110)
				{
					this.PlaySE(2393);
					this.SetFreeObject(this.x + 100 - this.rand() % 200, this.y - 150 - this.rand() % 75, this.direction, this.WinA_FireWork, {});
				}

				if (this.count == 90)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (::battle.state == 32 && this.count % 26 == 1)
				{
					this.PlaySE(2396);
				}

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
	this.keyAction = [
		function ()
		{
			this.PlaySE(2392);

			for( local i = 0; i < 3; i++ )
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.WinA_FireCore, {});
			}
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 30 || this.count == 75 || this.count == 110)
				{
					this.PlaySE(2393);
					this.SetFreeObject(this.x + 100 - this.rand() % 200, this.y - 150 - this.rand() % 75, this.direction, this.WinA_FireWork, {});
				}

				if (this.count == 90)
				{
					this.CommonWin();
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
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(2394);
			this.stateLabel = function ()
			{
				if (this.count % 7 == 1)
				{
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.LoseA_SmokeA, {});
				}

				if (this.count >= 90)
				{
					this.PlaySE(2395);
					this.SetMotion(this.motion, 2);
					this.SetSpeed_Vec(30, -75 * 0,01745329.0, this.direction);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.LoseA_SmokeB, {});

						if (this.count == 60)
						{
							this.CommonLose();
							this.stateLabel = null;
						}
					};
				}
			};
		}
	];
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
	this.SetSpeed_XY(5,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5,00000000.0 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- this.baseSlideSpeed;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -16,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 16,00000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -16,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 16,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- 16,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 16,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 8,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- 16,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 16,00000000.0;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 6,00000000.0;
	this.flag5.vy = 6,25000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -6,00000000.0;
	this.flag5.vy = 6,25000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = -7,00000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 7,00000000.0;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 5,00000000.0;
	t_.addSpeed <- 0,20000000.0;
	t_.maxSpeed <- 11,50000000.0;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 6,50000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 90;
	t_.addSpeed <- 0,25000000.0;
	t_.maxSpeed <- 9,00000000.0;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10,00000000.0 * this.direction, -5,00000000.0);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.y > this.centerY && this.va.y > 0,00000000.0)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 1,50000000.0);
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
	t_.speed <- -7,50000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0,25000000.0;
	t_.maxSpeed <- 9,00000000.0;
	this.DashBack_Air_Common(t_);
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AAA;
	this.SetSpeed_XY(this.va.x, this.va.y * 0,85000002.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(4,00000000.0 * this.direction, null);
			this.PlaySE(2210);
		},
		function ()
		{
			this.SetSpeed_XY(4,00000000.0 * this.direction, null);
			this.HitTargetReset();
			this.PlaySE(2212);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
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
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2214);
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
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
	this.Atk_RushA_Init(t);
	this.atk_id = 4;
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.SetMotion(1100, 0);
	this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2214);
			this.SetSpeed_XY(6,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,05000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.SetMotion(1101, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2210);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(2212);
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
			this.SetMotion(1101, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
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
	this.centerStop = -2;
	this.SetSpeed_XY(4,00000000.0 * this.direction, -9,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2225);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 10,00000000.0);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.HitCycleUpdate(5);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VY_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,05000000.0);
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
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
			this.PlaySE(2225);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 10,00000000.0);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.HitCycleUpdate(5);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VY_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);
	this.SetSpeed_XY(this.va.x * 0,75000000.0, this.va.y * 0,25000000.0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2218);
			this.count = 0;
		},
		null,
		function ()
		{
		},
		function ()
		{
			this.AjustCenterStop();
		},
		function ()
		{
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1211, 5);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.centerStop = 2;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 9,00000000.0);
	this.hitCount = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.flag2 = 0;
	this.keyAction = [
		function ()
		{
			this.flag2 = 0;
			this.centerStop = -2;
			this.SetSpeed_XY(8,00000000.0 * this.direction, -8,00000000.0);
			this.PlaySE(2220);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,20000000.0 * this.direction, -0,20000000.0);

				if (this.hitResult && this.hitCount <= 4)
				{
					this.flag2++;

					if (this.flag2 >= 5)
					{
						this.flag2 = 0;
						this.HitTargetReset();
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				this.VX_Brake(0,25000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
		this.CenterUpdate(0,25000000.0, 6,00000000.0);
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
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.centerStop = 2;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 9,00000000.0);
	this.keyAction = [
		function ()
		{
			this.flag2 = 0;
			this.centerStop = -2;

			if (this.centerY - this.y >= 50,00000000.0)
			{
				this.SetSpeed_XY(3,00000000.0 * this.direction, -3,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(6,00000000.0 * this.direction, -6,00000000.0);
			}

			this.PlaySE(2220);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,20000000.0 * this.direction, -0,20000000.0);

				if (this.hitCount <= 4)
				{
					this.HitCycleUpdate(5);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
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

function Atk_HighUpper_Air_Init( t )
{
	if (this.y >= this.centerY)
	{
		this.Atk_HighUpperB_Air_Init(t);
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2216);
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
			this.SetMotion(1221, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighUpperB_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1222, 0);
	this.hitCount = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(6,00000000.0 * this.direction, -6,00000000.0);
			this.PlaySE(2220);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,20000000.0 * this.direction, -0,20000000.0);

				if (this.hitCount <= 3)
				{
					this.HitCycleUpdate(3);
				}

				if (this.y < this.centerY)
				{
					this.SetMotion(1222, 3);
					this.SetSpeed_XY(5,00000000.0 * this.direction, -5,00000000.0);
					this.stateLabel = function ()
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.VX_Brake(0,50000000.0);
						}
					};
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.atk_id = 32;
	this.SetMotion(1730, 0);
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1740, 0);
	this.atk_id = 2048;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.PlaySE(2222);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2223);
			this.SetSpeed_XY(-6,00000000.0 * this.direction, null);
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

function Atk_RushA_Air_Init( t )
{
	this.Atk_HighFront_Air_Init(t);
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1101, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
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
	this.PlaySE(2222);
	this.keyAction = [
		function ()
		{
			this.AjustCenterStop();
			this.PlaySE(2223);
			this.SetSpeed_XY(-9,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, -3,00000000.0 * this.direction);
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1231, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
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
			this.SetMotion(1231, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
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
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2216);
			this.SetSpeed_XY(7,50000000.0 * this.direction, null);
		},
		function ()
		{
			this.HitTargetReset();
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
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
	this.flag1 = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2227);
			this.centerStop = -2;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(4);
				this.AddSpeed_XY(0,75000000.0 * this.direction, -0,64999998.0);

				if (this.abs(this.va.x * this.direction) >= 8,00000000.0)
				{
					this.SetSpeed_XY(8,00000000.0 * this.direction, null);
				}

				if (this.va.y <= -9,00000000.0)
				{
					this.SetSpeed_XY(null, -9,00000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,50000000.0);
				this.VX_Brake(0,30000001.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,30000001.0);
			};
		}
	];
	this.stateLabel = function ()
	{
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
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.initTable.pare.point0_y - (this.target.point0_y - this.target.y));
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 120 && this.direction == 1,00000000.0)
	{
		this.Warp(::battle.corner_right - 120, this.y);
	}

	if (this.x < ::battle.corner_left + 120 && this.direction == -1,00000000.0)
	{
		this.Warp(::battle.corner_left + 120, this.y);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(301, 0, -this.direction);
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
	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;
			this.target.DamageGrab_Common(302, 1, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor2, {}, this.weakref()).weakref();
			this.target.Warp(this.x + 129 * this.direction - (this.target.point0_x - this.target.x), this.y - 10 - (this.target.point0_y - this.target.y));
		},
		function ()
		{
			this.target.DamageGrab_Common(303, 1, this.direction);
		},
		function ()
		{
			this.target.DamageGrab_Common(304, 1, -this.direction);
		},
		function ()
		{
			this.PlaySE(2234);
			this.target.Warp(this.x + 181 * this.direction, this.y - 35);
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;
			this.flag1.func[0].call(this.flag1);
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
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
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
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-6,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(-0,52359873.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
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
	this.SetMotion(2003, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,33000001.0, this.va.y * 0,33000001.0);
	this.AjustCenterStop();
	this.flag2 = this.y <= this.centerY ? -1 : 1;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-4,50000000.0 * this.direction, 2,00000000.0 * this.flag2);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(-0,52359873.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.Shot_Normal_Init(t);
	this.SetMotion(2001, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-6,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(-1,04719746.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.SetMotion(2004, 0);
	this.flag2 = this.y <= this.centerY ? -1 : 1;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-4,50000000.0 * this.direction, 2,00000000.0 * this.flag2);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(-1,04719746.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 4,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.Shot_Normal_Init(t);
	this.SetMotion(2002, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-6,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(0,26179937.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.SetMotion(2005, 0);
	this.flag2 = this.y <= this.centerY ? -1 : 1;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-4,50000000.0 * this.direction, 2,00000000.0 * this.flag2);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
			this.team.AddMP(-200, 90);
			this.PlaySE(2229);
			this.vec.x = 10,00000000.0;
			this.vec.y = 0,00000000.0;
			this.vec.RotateByRadian(0,26179937.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
			this.vec.RotateByRadian(0,13962634.0);
			local t = {};
			t.x <- this.vec.x * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			local t = {};
			t.x <- (this.vec.x + 2,00000000.0) * this.direction;
			t.y <- this.vec.y;
			this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Normal, t);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
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
	this.flag1 = 0;
	this.flag2 = 0;
	this.PlaySE(2231);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag2 = this.Math_MinMax(this.flag2, -30 * 0,01745329.0, -20 * 0,01745329.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.count % 4 == 1)
				{
					this.SetSpeed_XY(-2,00000000.0 * this.direction, null);
					this.PlaySE(2232);
					local t = {};
					t.rot <- this.flag2 + (10 - this.rand() % 21) * 0,01745329.0;
					t.vec <- 37,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
					this.flag1++;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(-6,50000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;

	if (this.y < this.centerY)
	{
		this.SetMotion(2012, 0);
	}
	else
	{
		this.SetMotion(2011, 0);
	}

	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,33000001.0, this.va.y * 0,33000001.0);
	this.AjustCenterStop();
	this.PlaySE(2231);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;

			if (this.motion == 2012)
			{
				this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag2 = this.Math_MinMax(this.flag2, 0,34906584.0, 0,52359873.0);
			}
			else
			{
				this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag2 = this.Math_MinMax(this.flag2, -30 * 0,01745329.0, -20 * 0,01745329.0);
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,34999999.0);
				}

				if (this.count % 4 == 1)
				{
					this.SetSpeed_XY(-2,00000000.0 * this.direction, this.va.y * 0,80000001.0);
					this.PlaySE(2232);
					local t = {};
					t.rot <- this.flag2 + (10 - this.rand() % 21) * 0,01745329.0;
					t.vec <- 37,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
					this.flag1++;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(-8,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
				this.CenterUpdate(0,20000000.0, null);

				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 4,50000000.0;
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
	this.SetMotion(2020, 0);
	this.GetFront();
	this.count = 0;
	this.flag1 = 0;

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
	this.SetSpeed_XY(this.Math_MinMax(this.va.x, -8,00000000.0, 8,00000000.0), this.va.y * 0,25000000.0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 2,00000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,05000000.0);
		}
	};
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			if (this.count % 4 == 1 && this.flag1 < 5)
			{
				this.hitResult = 1;
				this.flag1++;

				if (this.flag4)
				{
					local t_ = {};
					t_.rot <- this.flag2;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull, t_);
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeFull, t_);
				}
				else
				{
					local t_ = {};
					t_.rot <- this.flag2 - 0,17453292.0;
					local a_ = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
					local b_ = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Charge, t_);
					local t_ = {};
					t_.rot <- this.flag2 + 0,17453292.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_, a_);
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Charge, t_, b_);
				}
			}

			this.CenterUpdate(0,10000000.0, 2,00000000.0);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.VX_Brake(0,50000000.0);
			}
			else
			{
				this.VX_Brake(0,15000001.0);
			}

			if (this.count >= 30)
			{
				if (this.flag4)
				{
					local t_ = {};
					t_.rot <- 0,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 23,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull_B, t_);
					local t_ = {};
					t_.rot <- 0,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 25,00000000.0;
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeFull_B, t_);
					local t_ = {};
					t_.rot <- 15,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 23,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull_B, t_);
					local t_ = {};
					t_.rot <- 15,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 25,00000000.0;
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeFull_B, t_);
					local t_ = {};
					t_.rot <- -15,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 23,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull_B, t_);
					local t_ = {};
					t_.rot <- -15,00000000.0 * 0,01745329.0 + this.flag2;
					t_.v <- 25,00000000.0;
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeFull_B, t_);
				}
				else
				{
					local t_ = {};
					t_.rot <- this.flag2 + 0,26179937.0;
					local a_ = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeB, t_).weakref();
					local b_ = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeB, t_).weakref();
					local t_ = {};
					t_.rot <- this.flag2 - 0,26179937.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeB, t_, a_);
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_ChargeB, t_, b_);
				}

				this.count = 0;
				::camera.shake_radius = 3,00000000.0;

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetSpeed_XY(-11,50000000.0 * this.direction, 0,00000000.0);
				}
				else if (this.y <= this.centerY)
				{
					this.SetSpeed_XY(-11,50000000.0 * this.direction, -3,00000000.0);
					this.centerStop = -3;
				}
				else
				{
					this.SetSpeed_XY(-11,50000000.0 * this.direction, 3,00000000.0);
					this.centerStop = 3;
				}

				this.stateLabel = function ()
				{
					if (this.count >= 20)
					{
						this.SetMotion(this.motion, 2);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,34999999.0);
							this.CenterUpdate(0,20000000.0, 6,00000000.0);
						};
					}

					this.VX_Brake(0,34999999.0);
					this.CenterUpdate(0,10000000.0, 6,00000000.0);
				};
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(2272);
			this.func();
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
	this.flag2.vx <- 4,00000000.0;
	this.flag2.vy <- 3,00000000.0;
	this.flag2.rot <- 0,00000000.0;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			local c_ = this.count % 3;

			if (c_ == 1)
			{
				this.PlaySE(2229);
				local t_ = {};
				t_.v <- 15,00000000.0;
				t_.rot <- -1,04719746.0 + 1,04719746.0 * this.sin(this.count * 0,06981317.0);
				this.SetShot(this.x + 80 * this.cos(t_.rot) * this.direction, this.y - 40 + 80 * this.sin(t_.rot), this.direction, this.Shot_Barrage, t_).weakref();
				local t_ = {};
				t_.v <- 15,00000000.0;
				t_.rot <- -1,04719746.0 + 1,04719746.0 * this.sin(this.count * 0,06981317.0 + 3,14159203.0);
				this.SetShot(this.x + 80 * this.cos(t_.rot) * this.direction, this.y - 40 + 80 * this.sin(t_.rot), this.direction, this.Shot_Barrage, t_).weakref();
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
	this.SetMotion(2500, 0);
	this.flag1 = 200;

	if (t.k * this.direction > 0)
	{
		this.flag1 = 500;
	}

	if (t.k * this.direction < 0)
	{
		this.flag1 = -200;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2274);
			this.team.AddMP(-200, 120);
			this.count = 0;

			if (this.robo == null)
			{
				local x_ = this.x + this.flag1 * this.direction;

				if (this.direction == 1,00000000.0)
				{
					x_ = this.Math_MinMax(x_, ::battle.scroll_left, ::battle.scroll_right - 200);
				}
				else
				{
					x_ = this.Math_MinMax(x_, ::battle.scroll_left + 200, ::battle.scroll_right);
				}

				this.robo = this.SetShot(x_, ::battle.scroll_bottom + 500, this.direction, this.Occult_Robo, {}).weakref();
				this.occult = 1;
			}

			this.stateLabel = function ()
			{
				if (this.count >= 25)
				{
					this.SetMotion(2500, 2);
					this.stateLabel = null;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,05000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function OkultB_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.flag1 = 0;

	if (t.k > 0)
	{
		this.flag1 = 1;
	}

	if (t.k < 0)
	{
		this.flag1 = -1;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2274);
			this.team.AddMP(-200, 120);

			if (this.robo && this.occult == 1)
			{
				if (this.flag1 * this.robo.direction < 0)
				{
					this.robo.func[5].call(this.robo);
					return;
				}
				else
				{
					this.robo.func[4].call(this.robo);
					return;
				}
			}
		},
		function ()
		{
		}
	];
	return true;
}

function OkultC_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.DelOccultAura();
			this.hitResult = 1;
			this.PlaySE(2274);
			this.team.AddMP(-200, 120);

			if (this.robo && this.occult == 1)
			{
				this.robo.func[1].call(this.robo);
				return;
			}
		},
		function ()
		{
		}
	];
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.SetMotion(3000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0,50000000.0))
				{
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);
					};
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
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.PlaySE(2250);
			local t_ = {};
			t_.x <- 200,00000000.0;
			t_.y <- 0,00000000.0;
			t_.fall <- true;
			t_.scale <- 2,00000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, t_);
			local t_ = {};
			t_.type <- 7;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A_Fire, t_);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, 8,00000000.0);
			this.centerStop = 2;
			this.func[0].call(this);
		},
		function ()
		{
			this.func[1].call(this);
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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag2 = 0;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.flag1 = function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);

				if (this.count % 4 == 1 && this.flag2 < 3)
				{
					this.flag2++;
					this.PlaySE(2255);
					local t_ = {};
					t_.rot <- (90 + 20,00000000.0 * this.flag2) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B2, t_);
					local t_ = {};
					t_.rot <- -(90 + 20,00000000.0 * this.flag2) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B2, t_);
				}
			};
		};
	}
	else if (this.y <= this.centerY)
	{
		this.flag1 = function ()
		{
			this.centerStop = -2;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);

				if (this.count % 6 == 1 && this.flag2 < 5)
				{
					this.flag2++;
					local t_ = {};
					t_.rot <- 15,00000000.0 * 0,01745329.0;
					this.PlaySE(2255);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
				}
			};
		};
	}
	else
	{
		this.flag1 = function ()
		{
			this.count = 0;
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);

				if (this.count % 6 == 1 && this.flag2 < 5)
				{
					this.flag2++;
					this.PlaySE(2255);
					local t_ = {};
					t_.rot <- -15,00000000.0 * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
				}
			};
		};
	}

	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2254);
			this.count = 0;
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.flag1();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,20000000.0);
	};
	return true;
}

function SP_B2_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3012, 0);
	this.atk_id = 2097152;
	this.count = 0;
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,50000000.0 * this.direction, null, 7,00000000.0 * this.direction, null);

				if (this.abs(this.va.x) >= 7,00000000.0)
				{
					if (this.count % 10 == 0 && this.flag1 <= 5)
					{
						this.flag1++;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, {});
					}
				}

				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,25000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.count = 0;
	this.flag1 = null;
	this.flag2 = false;
	this.flag3 = 0,00000000.0;
	this.flag4 = this.Vector3();
	this.flag5 = {};
	this.flag5.rot <- 2,00000000.0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1 || this.centerStop * this.centerStop > 1 && this.y > this.centerY)
	{
		this.SetMotion(3020, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(2257);
				local t_ = {};
				t_.vec <- 30,00000000.0;
				t_.rot <- 0,00000000.0;
				t_.rockCount <- 15;
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_).weakref();
				this.stateLabel = function ()
				{
					if (this.flag2)
					{
						this.PlaySE(2259);
						this.count = 0;
						this.SetMotion(this.motion, 2);
						this.stateLabel = function ()
						{
							this.flag4.x = (this.flag1.x - this.point0_x) * this.direction;
							this.flag4.y = this.flag1.y - this.point0_y;

							if (this.flag4.LengthXY() <= 100,00000000.0 && this.count > 23 || this.count >= 30)
							{
								this.flag4.Normalize();
								this.SetSpeed_XY(30,00000000.0 * this.flag4.x * this.direction, 30,00000000.0 * this.flag4.y);
								this.SetMotion(this.motion, 4);

								if (this.va.y > 0)
								{
									this.centerStop = 2;
								}
								else
								{
									this.centerStop = -2;
								}

								this.stateLabel = function ()
								{
									this.VX_Brake(3,00000000.0);
								};
								return;
							}
							else
							{
								this.flag4.Normalize();
								this.flag3 += 6,00000000.0;

								if (this.flag3 > 20,00000000.0)
								{
									this.flag3 = 20,00000000.0;
								}

								this.Warp(this.x + this.flag3 * this.flag4.x * this.direction, this.y + this.flag3 * this.flag4.y);

								if (this.flag3 * this.flag4.y > 0)
								{
									this.centerStop = 2;
								}
								else
								{
									this.centerStop = -2;
								}
							}
						};
						return;
					}
				};
			},
			this.EndtoFreeMove,
			null,
			null,
			function ()
			{
				this.stateLabel = function ()
				{
				};
			}
		];
	}
	else
	{
		this.SetMotion(3021, 0);
		this.airWire = true;
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(2257);
				local t_ = {};
				t_.vec <- 45,00000000.0;
				t_.rot <- 0,00000000.0;
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C2, t_).weakref();
				this.stateLabel = function ()
				{
					if (this.flag2)
					{
						this.PlaySE(2259);
						this.count = 0;
						this.SetMotion(this.motion, 2);
						this.flag4.x = this.x + 250,00000000.0 * this.direction;
						this.flag4.y = this.y;
						this.flag3 = 3,14159203.0;
						this.centerStop = 2;
						this.stateLabel = function ()
						{
							if (this.count == 8)
							{
								this.SetMotion(3021, 4);
							}

							if (this.count == 18)
							{
								this.SetMotion(3021, 5);
							}

							this.flag3 -= this.flag5.rot * 0,01745329.0;

							if (this.cos(this.flag3) >= 0,00000000.0)
							{
								this.flag5.rot -= 0,15000001.0;
							}
							else
							{
								this.flag5.rot += 0,25000000.0;
							}

							this.Warp(this.flag4.x + 250 * this.cos(this.flag3) * this.direction, this.flag4.y + 250 * this.sin(this.flag3));

							if (this.count >= 30)
							{
								this.centerStop = -2;
								this.SetSpeed_XY(7,50000000.0 * this.direction, -10,00000000.0);
								this.SetMotion(3021, 6);
								this.stateLabel = function ()
								{
									this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
									this.VX_Brake(0,25000000.0);
								};
							}
						};
						return;
					}
				};
			},
			this.EndtoFreeMove,
			null,
			null,
			null,
			null,
			this.EndtoFreeMove
		];
	}

	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3030, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.flag1 = {};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2261);
			this.flag1.v <- 25,00000000.0;
			this.flag1.rot <- this.atan2(this.target.y - this.point0_y, this.target.x - this.point0_x);
			this.flag1.rot = this.Math_MinMax(this.flag1.rot, -60 * 0,01745329.0, 60 * 0,01745329.0);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D, this.flag1);
		},
		null,
		function ()
		{
			this.VX_Brake(0,50000000.0);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,05000000.0);
		this.CenterUpdate(0,10000000.0, null);
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8388608;
	this.SetMotion(3040, 0);
	this.count = 0;
	this.flag3 = 0;
	this.flag5 = {};
	this.flag5.type <- 3;
	this.flag5.vec <- 15,00000000.0;
	this.flag5.push <- -1;
	this.flag5.rush <- t.rush;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.func = function ()
	{
		this.HitTargetReset();
		this.SetMotion(3040, 4);
		this.stateLabel = function ()
		{
			if (this.centerStop == 0)
			{
				this.VX_Brake(0,05000000.0);
			}
			else
			{
				this.VX_Brake(0,00500000.0);
			}

			this.CenterUpdate(0,10000000.0, null);
		};
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2264);
		},
		function ()
		{
			this.HitTargetReset();

			if (this.flag5.push <= 0)
			{
				this.func();
			}
			else
			{
				this.flag3++;

				if (this.flag3 > 2)
				{
					this.flag5.vec = 35,00000000.0;
				}

				if (this.flag3 > 4)
				{
					this.flag5.vec = 45,00000000.0;
				}

				this.PlaySE(2264);
				this.count = 0;
				this.stateLabel = function ()
				{
					if ((this.input.b2 == 1 || this.flag5.rush && this.input.b0 == 1) && this.flag3 <= 5 && ::battle.state == 8)
					{
						this.flag5.push = 15;
					}

					this.flag5.push--;

					if (this.centerStop == 0 || this.flag3 <= 0)
					{
						this.VX_Brake(0,05000000.0);
					}
					else
					{
						this.VX_Brake(0,00500000.0);
					}

					this.CenterUpdate(0,10000000.0, null);

					if (this.count == 16)
					{
						if (this.flag5.push <= 0)
						{
							this.func();
						}
						else
						{
							this.flag3++;

							if (this.flag3 > 2)
							{
								this.flag5.vec = 35,00000000.0;
							}

							if (this.flag3 > 4)
							{
								this.flag5.vec = 45,00000000.0;
							}

							this.PlaySE(2264);
							this.SetMotion(3040, this.keyTake);
							this.HitTargetReset();
							this.count = 0;
						}
					}
				};
			}
		},
		function ()
		{
			this.HitTargetReset();

			if (this.flag3 <= 0)
			{
				this.func();
			}
			else
			{
				this.flag3--;
				this.PlaySE(2264);
			}

			this.count = 0;
		},
		function ()
		{
			this.HitTargetReset();

			if (this.flag3 <= 0)
			{
				this.func();
			}
			else
			{
				this.flag3--;
				this.PlaySE(2264);
			}
		},
		function ()
		{
			this.PlaySE(2265);
			this.hitResult = 1;
			local t_ = {};
			t_.rot <- -22,50000000.0 * 0,01745329.0;
			t_.v <- this.flag5.vec;
			t_.keyTake <- this.flag5.type;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_E, t_);
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,05000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.input.b2 == 1 || this.flag5.rush && this.input.b0 == 1)
		{
			this.flag5.push = 15;
		}

		this.flag5.push--;

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,10000000.0);
		}

		this.CenterUpdate(0,10000000.0, null);
	};
	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 16777216;
	this.SetMotion(3050, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 10,00000000.0;
	this.flag2 = -10,00000000.0;

	if (t.k * this.direction > 0)
	{
		this.flag1 = 16,50000000.0;
		this.flag2 = -12,50000000.0;
	}

	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2269);
			local t_ = {};
			t_.x <- this.flag1;
			t_.y <- this.flag2;
			t_.fire <- true;
			t_.exp <- true;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F, t_);
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
					this.VX_Brake(0,20000000.0);
				}
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
			this.VX_Brake(0,20000000.0);
		}

		this.CenterUpdate(0,10000000.0, null);
	};
	return true;
}

function SP_G_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3060, 0);
	this.flag2 = true;
	this.GetFront();
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.Math_MinMax(this.va.x, -8,00000000.0, 8,00000000.0), this.va.y * 0,25000000.0);
	this.stateLabel = function ()
	{
		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,05000000.0);
		}

		this.CenterUpdate(0,10000000.0, 2,00000000.0);
	};
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			if (this.count % 4 == 1 && this.flag1 < 5)
			{
				this.hitResult = 1;
				this.flag1++;
				local t_ = {};
				t_.rot <- 0,00000000.0 * 0,01745329.0;
				t_.fuel <- this.flag2;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_G, t_);
				this.SetShot(this.point1_x, this.point1_y, this.direction, this.SPShot_G, t_);
			}

			if (this.centerStop == 0)
			{
				this.VX_Brake(0,50000000.0);
			}
			else
			{
				this.VX_Brake(0,05000000.0);
			}

			this.CenterUpdate(0,10000000.0, 2,00000000.0);

			if (this.count >= 30)
			{
				local t_ = {};
				t_.rot <- 0,00000000.0 * 0,01745329.0;
				t_.fuel <- this.flag2;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_G2, t_);
				this.SetShot(this.point1_x, this.point1_y, this.direction, this.SPShot_G2, t_);
				this.count = 0;
				::camera.shake_radius = 3,00000000.0;
				this.SetSpeed_XY(-11,50000000.0 * this.direction, -3,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					if (this.count >= 20)
					{
						this.SetMotion(this.motion, 2);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,34999999.0);
							this.CenterUpdate(0,10000000.0, 6,00000000.0);
						};
					}

					this.VX_Brake(0,34999999.0);
					this.CenterUpdate(0,10000000.0, 6,00000000.0);
				};
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(2272);
			this.func();
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
	return true;
}

function SP_Dorill_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 33554432;
	this.SetMotion(3070, 0);
	this.flag1 = true;
	this.flag2 = 0;
	this.SetSpeed_XY(-5,00000000.0 * this.direction, 0,00000000.0);
	this.func = function ()
	{
		this.count = 0;
		this.stateLabel = function ()
		{
			this.HitCycleUpdate(3);

			if (this.count == 20)
			{
				this.HitTargetReset();

				if (this.flag2 == 1)
				{
					this.SetMotion(3070, 5);
				}
				else
				{
					this.SetMotion(3070, 4);
				}

				this.stateLabel = function ()
				{
				};
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2287);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.input.b2 == 0 || ::battle.state != 8)
				{
					this.flag1 = false;
				}

				if (this.count == 30)
				{
					this.PlaySE(2291);
					this.flag2 = 1;
				}

				if (this.count >= 4 && !this.flag1)
				{
					this.SetMotion(3070, 2);

					if (this.flag2)
					{
						this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
					}
					else
					{
						this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
					}

					this.PlaySE(2288);
					this.count = 0;
					this.team.AddMP(-200, 120);
					this.stateLabel = function ()
					{
						this.HitCycleUpdate(3);

						if (this.hitResult & 1)
						{
							this.func();
							return;
						}

						if (this.count == 35)
						{
							this.HitTargetReset();

							if (this.flag2 == 1)
							{
								this.SetMotion(3070, 5);
							}
							else
							{
								this.SetMotion(3070, 4);
							}

							this.stateLabel = function ()
							{
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
			this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(3070, 6);
		},
		function ()
		{
			this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.input.b2 == 0)
		{
			this.flag1 = false;
		}

		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4000, 0);
	this.atk_id = 67108864;
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.team.spell_enable_end = false;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2300);
			this.count = 0;
			this.flag1 = 0;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_A, t_);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);

				if (this.VY_Brake(0,15000001.0))
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,10000000.0);
						this.CenterUpdate(0,10000000.0, 2,00000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 2,00000000.0);
	};
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.atk_id = 67108864;
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(2304);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag5 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 90)
				{
					this.SetMotion(4010, 3);
					this.hitResult = 1;
					this.PlaySE(2305);

					if (this.flag5)
					{
						this.flag5.func[1].call(this.flag5);
					}

					this.SetSpeed_XY(-7,50000000.0 * this.direction, null);
					this.centerStop = 2;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
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
	};
	return true;
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4020, 0);
	this.atk_id = 67108864;
	this.option = [];
	this.func = function ()
	{
		this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_C_Flash, {});
		this.SetMotion(4020, 2);
		::camera.shake_radius = 5,00000000.0;
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.PlaySE(2310);
		this.stateLabel = function ()
		{
			this.Vec_Brake(0,50000000.0);

			if (this.count >= 60)
			{
				this.SetMotion(4020, 3);
				local t_ = {};
				t_.type <- 0;
				t_.point <- 0;
				local t2_ = {};
				t2_.type <- 1;
				t2_.point <- 1;
				this.option = [
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellC_Fire, t_).weakref(),
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellC_Fire, t2_).weakref()
				];
				this.count = 0;

				if (this.input.y > 0)
				{
					this.flag1 = 25,00000000.0;
				}

				if (this.input.y < 0)
				{
					this.flag1 = 15,00000000.0;
				}

				if (this.input.y == 0)
				{
					this.flag1 = 20,00000000.0;
				}

				this.SetSpeed_XY(5,00000000.0 * this.direction, this.flag1);
				this.PlaySE(2311);
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(4);
					this.AddSpeed_XY(0,50000000.0 * this.direction, -0,80000001.0);

					if (this.va.y < -4,00000000.0)
					{
						this.HitReset();
						this.PlaySE(2313);

						foreach( a in this.option )
						{
							a.func();
						}

						if (this.input.y > 0)
						{
							this.flag1 = -0,25000000.0;
						}

						if (this.input.y < 0)
						{
							this.flag1 = -1,00000000.0;
						}

						if (this.input.y == 0)
						{
							this.flag1 = -0,60000002.0;
						}

						this.freeMap = true;
						this.stateLabel = function ()
						{
							this.HitCycleUpdate(4);
							this.AddSpeed_XY(2,50000000.0 * this.direction, this.flag1);

							if (this.direction == -1,00000000.0 && this.x < -640 || this.direction == 1,00000000.0 && this.x > 1920)
							{
								this.Spell_C_End(null);
								return;
							}

							if (this.hitResult & 1)
							{
								this.count = 0;
								this.SetMotion(4020, 4);
								this.hitCount = 0;
								this.flag2 = this.Vector3();
								this.flag3 = 0;
								this.Vec_Brake(200, 3,00000000.0);
								this.stateLabel = function ()
								{
									if (this.hitTarget.len() == 0)
									{
										this.flag3++;
									}
									else
									{
										this.flag3 = 0;
									}

									this.HitCycleUpdate(4);

									if (this.hitCount > 15 || this.flag3 >= 10)
									{
										this.HitReset();
										this.SetMotion(4020, 5);
										this.AddSpeed_Vec(70, null, 70, this.direction);
										this.stateLabel = function ()
										{
											if (this.direction == -1,00000000.0 && this.x < -640 || this.direction == 1,00000000.0 && this.x > 1920)
											{
												this.Spell_C_End(null);
												return;
											}
										};
									}
								};
							}
						};
						return;
					}
				};
			}
		};
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetFreeObject(this.x - 1280 * this.direction, this.y, this.direction, this.SpellShot_C_Wing, {});
			this.PlaySE(2309);
			this.UseSpellCard(60, -this.team.sp_max);
			this.centerStop = -2;
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function Spell_C_End( t )
{
	this.option = null;
	this.rz = 0,00000000.0;
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4020, 6);
	this.freeMap = false;
	this.Warp(this.x, -120);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.centerStop = -2;
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 60)
		{
			this.EndtoFreeMove();
		}
	};
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = null;
	this.flag2 = null;
	this.flag4 = false;
	this.flag5 = {};
	this.flag5.mist <- null;
	this.flag5.back <- null;
	this.flag5.mask <- null;
	this.flag5.shot <- 0;
	this.flag5.bullet <- ::manbow.Actor2DProcGroup();
	this.flag5.nessy <- null;
	this.flag5.shadow <- null;
	this.flag5.shot <- 0;
	this.subState = function ()
	{
		this.flag5.bullet.Foreach(function ()
		{
			if (this.hitResult & 1)
			{
				this.owner.flag4 = true;
			}
		});

		if (this.flag4 && (this.target.team.master.damageTarget && this.target.team.master.damageTarget.flag3 == "sp" || this.target.team.slave.damageTarget && this.target.team.slave.damageTarget.flag3 == "sp"))
		{
			this.target.attackTarget = this.weakref();
			this.target.enableStandUp = false;
			this.subState = function ()
			{
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–ƒlƒXŒ\x256c‚\x2550¡‚\x2592‚\x2592‚\x2554‚ ‚éI–");
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
			this.PlaySE(2350);
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(2352);
			this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.Climax_MaskFlash, {}), this, 0, 0);
			this.flag5.mask = this.SetFreeObjectStencil(this.x, this.y + 256, this.direction, this.Climax_Mask, {}).weakref();
			this.flag5.mist = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Climax_Mist, {}).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 10)
				{
					::camera.SetTarget(640, 360, 1,00000000.0, false);
					this.count = 0;
					this.flag5.back = this.SetFreeObject(640, 360, 1,00000000.0, this.Climax_BackA, {}).weakref();
					this.SetMotion(4900, 3);
					this.flag5.mask.ReleaseActor();
					this.flag5.mask = null;
					this.stateLabel = function ()
					{
						if (this.count == 20)
						{
							this.PlaySE(2279);
							local t_ = {};
							t_.rate <- this.atkRate_Pat;
							this.flag5.shadow = this.SetFreeObject(640 + 180 * this.direction, 360, this.direction, this.Climax_NessyShadow, t_).weakref();
							this.flag5.mist.func[1].call(this.flag5.mist);
							this.count = 0;
							::camera.shake_radius = 8,00000000.0 - this.flag5.shot * 0,60000002.0;
							this.stateLabel = function ()
							{
								this.subState();

								if (this.count % 8 == 1 && this.flag5.shot < 6)
								{
									if (this.flag5.shadow)
									{
										this.flag5.bullet.Add(this.flag5.shadow.func[1].call(this.flag5.shadow, this.flag5.shot));
									}

									this.flag5.shot++;
								}

								if (this.flag5.shot >= 6 && this.flag4 && this.target.attackTarget == this)
								{
									this.Spell_Climax_Hit(null);
									return;
								}

								if (this.count == 110)
								{
								}

								if (this.count == 140)
								{
									if (this.flag5.shadow)
									{
										this.flag5.shadow.func[0].call(this.flag5.shadow);
									}

									this.flag5.back.func[0].call(this.flag5.back);
									this.SetMotion(4900, 4);
									this.Warp(this.x, -120);
									this.centerStop = -2;
									this.count = 0;
									::camera.ResetTarget();
									this.stateLabel = function ()
									{
										if (this.centerStop * this.centerStop <= 1)
										{
											this.stateLabel = function ()
											{
												this.VX_Brake(0,50000000.0);
											};
											this.SetMotion(4900, 5);
										}
									};
								}
							};
						}
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
	this.SetMotion(4900, 3);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag5.nessy = this.SetFreeObject(this.flag5.shadow.point0_x, this.flag5.shadow.point0_y, this.direction, this.Climax_Nessy, {}).weakref();

	if (this.flag5.shadow)
	{
		this.flag5.shadow.func[0].call(this.flag5.shadow);
	}

	this.count = 0;
	this.flag5.zoom <- 1,00000000.0;
	this.flag5.zoomBack <- null;
	this.flag5.face <- null;
	this.flag5.beem <- null;
	this.cameraPos.x = 640;
	this.cameraPos.y = 360;
	this.EraceBackGround(true);
	::battle.enableTimeUp = false;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.PlaySE(2282);
			this.flag5.nessy.func[0].call(this.flag5.nessy);
			this.flag5.back.func[0].call(this.flag5.back);
			this.autoCamera = false;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag5.face = this.SetFreeObject(640 + 640 * this.direction, 0, this.direction, this.Climax_Face, t_).weakref();
		}

		if (this.count == 320)
		{
			this.flag5.face.func[0].call(this.flag5.face);
			this.Spell_Climax_Finish(null);
		}
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.EraceBackGround(false);
	this.target.attackTarget = null;
	this.target.enableStandUp = true;
	this.autoCamera = true;
	this.freeMap = false;
	this.SetMotion(4902, 4);
	this.Warp(this.x, -120);
	this.centerStop = -2;
	this.count = 0;
	::camera.ResetTarget();
	this.BackFadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
	this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 30);
	this.KnockBackTarget(-this.direction);
	this.PlaySE(2285);
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			::battle.enableTimeUp = true;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			this.SetMotion(4900, 5);
		}
	};
}

