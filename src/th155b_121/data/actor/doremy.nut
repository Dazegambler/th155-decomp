function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 14)
	{
		this.BeginBattle_Udonge(null);
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
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4068);
		},
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

function BeginBattleB_Sheep( t )
{
	this.SetMotion(9001, 4);
	this.DrawActorPriority(180);
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y >= this.owner.centerY)
		{
			this.PlaySE(4069);
			this.Warp(this.x, this.owner.centerY);
			this.SetSpeed_XY(8.00000000 * this.direction, -10.00000000);
		}
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(4.00000000 * this.direction, -10.00000000);
	this.Warp(640 - 900 * this.direction, this.centerY);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 0);
	this.demoObject = [];
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

	this.keyAction = [
		function ()
		{
			this.PlaySE(4068);
		},
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.func = function ()
	{
		local t_ = {};
		t_.v <- this.Vector3();
		t_.v.x = this.va.x;
		t_.v.y = this.va.y;
		this.demoObject = [
			this.SetFreeObject(this.x, this.y, this.direction, this.BeginBattleB_Sheep, t_).weakref()
		];
		this.SetMotion(9001, 1);
		this.centerStop = -2;
		this.SetSpeed_XY((this.flag1.x - this.x) * 0.10000000, -6.50000000);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.25000000);
			this.SetSpeed_XY((this.flag1.x - this.x) * 0.05000000, this.va.y);

			if (this.va.y > 0 && this.y >= this.centerY)
			{
				this.SetMotion(9001, 3);
				this.SetSpeed_XY(0.00000000, 3.00000000);
				this.centerStop = 1;
				this.Warp(this.flag1.x, this.flag1.y);
				this.stateLabel = function ()
				{
				};
			}
		};
	};
	this.count = 0;
	this.keyAction = [
		null,
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
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y >= this.centerY)
		{
			this.PlaySE(4069);
			this.Warp(this.x, this.centerY);
			this.SetSpeed_XY(this.va.x, -10.00000000);
		}

		if (this.count == 125)
		{
			this.func();
		}
	};
}

function BeginBattle_Udonge( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9005, 0);
	this.count = 0;
	this.Warp(this.x, this.y - 40);
	this.demoObject = [];
	this.team.slave.BeginBattle_Slave(t);
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(0.00000000 * this.direction, -4.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);

				if (this.y > this.centerY)
				{
					this.SetMotion(this.motion, 3);
					this.Warp(::battle.start_x[this.team.index], this.centerY);
					this.SetSpeed_XY(0.00000000, 3.00000000);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		this.CommonBegin
	];
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			this.SetMotion(9005, 1);
			this.stateLabel = null;
		}
	};
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9005, 0);
	this.count = 0;
	this.Warp(this.x - 35 * this.direction, this.y - 40);
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			::camera.Shake(6.00000000);
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	};
}

function WinA( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.count = 0;
	this.PlaySE(4070);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 120)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinB_Back( t )
{
	this.DrawBackActorPriority(80);
	this.SetMotion(9011, 4);
	this.sx = this.sy = 1.75000000;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		local s_ = (1.33000004 - this.sx) * 0.10000000;
		this.sx = this.sy += s_;
		this.SetSpeed_XY(0.00000000, -0.05000000 * this.sx);
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.demoObject = [
		null
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4071);
			this.demoObject[0] = this.SetFreeObject(640, 360, 1.00000000, this.WinB_Back, {}).weakref();
			this.count = 0;
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 30);
			this.stateLabel = function ()
			{
				if (this.count == 120)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function Lose( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.CommonLose();
		}
	];
	this.stateLabel = function ()
	{
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
	this.SetSpeed_XY(5.00000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5.00000000 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- -13.50000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 13.50000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- -13.50000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 13.50000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- 13.50000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 13.50000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- 13.50000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 13.50000000;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 5.00000000;
	this.flag5.vy = 5.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -5.00000000;
	this.flag5.vy = 5.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = -6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 5.00000000;
	t_.addSpeed <- 0.33000001;
	t_.maxSpeed <- 12.00000000;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 10.00000000;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

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
	t_.speed <- -6.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 12.50000000;
	this.DashBack_Air_Common(t_);
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.85000002);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4000);
		}
	];
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.85000002);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4000);
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
		this.VX_Brake(0.75000000);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.PlaySE(4002);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
			};
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, null);
			this.PlaySE(4002);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
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
	this.SetMotion(1110, 0);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.PlaySE(4004);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- i * 45;
				this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Mukon_AirAtk, t_));
			}

			this.lavelClearEvent = function ()
			{
				this.flag1.Foreach(function ()
				{
					this.func[0].call(this);
				});
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
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
		},
		this.EndtoFreeMove,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
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
	this.SetSpeed_XY(9.00000000 * this.direction, -12.50000000);
	this.centerStop = -2;
	this.Warp(this.x, this.centerY);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4010);
		},
		null,
		function ()
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Mukon_Sprash, {});
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000, 6.00000000 * this.direction);
		this.AddSpeed_XY(0.00000000, 1.10000002);

		if (this.va.y > 0.00000000 && this.y >= this.centerY)
		{
			this.PlaySE(4011);
			this.HitTargetReset();
			this.SetMotion(1210, 2);
			this.SetSpeed_XY(this.va.x, 3.00000000);
			this.Warp(this.x, this.centerY);
			this.centerStop = 1;
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
	this.SetSpeed_XY(12.50000000 * this.direction, -12.50000000);
	this.centerStop = -2;
	this.Warp(this.x, this.centerY);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4010);
		},
		null,
		function ()
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Mukon_Sprash, {});
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000, 6.00000000 * this.direction);
		this.AddSpeed_XY(0.00000000, 1.10000002);

		if (this.va.y > 0.00000000 && this.y >= this.centerY)
		{
			this.PlaySE(4011);
			this.HitTargetReset();
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(this.va.x, 3.00000000);
			this.Warp(this.x, this.centerY);
			this.centerStop = 1;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitCount = 0;
	this.atk_id = 1024;

	if (this.y < this.centerY)
	{
		this.SetMotion(1211, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(4010);
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(4011);
				this.HitTargetReset();
				this.centerStop = -3;
				this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.75000000, null);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 5);
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
			this.CenterUpdate(0.75000000, null);

			if (this.hitCount <= 2)
			{
				this.HitCycleUpdate(5);
			}

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(this.motion, 2);
				this.SetSpeed_XY(this.va.x, 3.00000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(1.50000000);
				};
			}
		};
	}
	else
	{
		this.SetMotion(1212, 0);
		this.SetSpeed_XY(null, -4.00000000);
		this.keyAction = [
			function ()
			{
				this.PlaySE(4010);
			},
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.HitTargetReset();
				this.centerStop = -3;
				this.SetSpeed_XY(7.50000000 * this.direction, -17.50000000);
				this.stateLabel = function ()
				{
					if (this.y < this.centerY)
					{
						this.CenterUpdate(1.50000000, null);
					}

					if (this.y > this.centerY && this.va.y > 0)
					{
						this.SetSpeed_XY(0.00000000, 0.00000000);
						this.SetMotion(this.motion, 5);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			null,
			function ()
			{
				this.PlaySE(4011);
				this.HitTargetReset();
				this.centerStop = -3;
				this.SetSpeed_XY(10.00000000 * this.direction, -22.50000000);
				this.stateLabel = function ()
				{
					if (this.y < this.centerY)
					{
						this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
						this.SetMotion(this.motion, 7);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.75000000, null);

							if (this.y > this.centerY && this.va.y > 0)
							{
								this.SetMotion(this.motion, 8);
								this.stateLabel = function ()
								{
									this.VX_Brake(0.50000000);
								};
							}
						};
					}
				};
			},
			null,
			this.EndtoFallLoop
		];
		this.stateLabel = function ()
		{
			if (this.hitCount <= 2)
			{
				this.HitCycleUpdate(5);
			}

			this.AddSpeed_XY(null, 1.25000000);

			if (this.ground)
			{
				this.SetMotion(this.motion, 5);
				this.SetSpeed_XY(0.00000000, 0.00000000);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(null, 0.33000001);
					this.VX_Brake(1.50000000);
				};
			}
		};
	}

	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4012);
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4012);
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);

	if (this.centerStop * this.centerStop >= 2 && this.y > this.centerY)
	{
		this.keyAction = [
			function ()
			{
				this.centerStop = -2;
				this.PlaySE(4012);
				this.SetSpeed_XY(7.00000000 * this.direction, -15.00000000);
				this.SetFreeObject(this.x - 30 * this.direction, this.y + 50, this.direction, this.Hammock, {});
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000, 4.00000000 * this.direction);
					this.AddSpeed_XY(0.00000000, this.y < this.centerY ? 0.75000000 : 0.15000001);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, this.baseSlideSpeed);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			function ()
			{
				this.AjustCenterStop();
				this.EndtoFreeMove();
			},
			this.EndtoFreeMove
		];
	}
	else
	{
		this.keyAction = [
			function ()
			{
				this.centerStop = -2;
				this.PlaySE(4012);
				this.SetSpeed_XY(12.00000000 * this.direction, -9.50000000);
				this.SetFreeObject(this.x - 30 * this.direction, this.y + 50, this.direction, this.Hammock, {});
				this.stateLabel = function ()
				{
					this.VX_Brake(0.50000000, 4.00000000 * this.direction);
					this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 0.75000000 : 0.50000000);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, this.baseSlideSpeed);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			this.EndtoFreeMove,
			this.EndtoFreeMove
		];
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0.30000001, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.75000000);
		}
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1730, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(7.50000000 * this.direction, 0.00000000);
			this.PlaySE(4016);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 2.00000000 ? 0.75000000 : 0.20000000, 0.00000000);
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
		this.VX_Brake(0.75000000);
	};
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
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
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(7.50000000 * this.direction, 0.00000000);
			this.PlaySE(4016);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 2.00000000 ? 0.75000000 : 0.20000000, 0.00000000);
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
		this.VX_Brake(0.75000000);
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
			this.PlaySE(4016);
			this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, 5.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.combo_func = null;
					this.SetMotion(this.motion, 3);
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
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
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
			this.keyAction = this.EndtoFreeMove;
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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
			this.PlaySE(4016);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, 5.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
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
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.25000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
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
	this.atk_id = 4096;
	this.SetSpeed_XY(8.00000000 * this.direction, null);
	this.hitCount = 0;
	this.stateLabel = function ()
	{
	};
	this.SetMotion(1300, 0);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- i * 45;
				this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Mukon_AirDash, t_));
			}

			this.lavelClearEvent = function ()
			{
				this.flag1.Foreach(function ()
				{
					this.func[0].call(this);
				});
			};
			this.PlaySE(4018);
			this.stateLabel = function ()
			{
				if (this.hitCount <= 4)
				{
					this.HitCycleUpdate(2);
				}
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.60000002);
			};
		},
		null,
		this.EndtoFreeMove
	];
	return true;
}

function Atk_HighDash_Splash( t )
{
	this.SetMotion(1310, 5);
	this.keyAction = this.ReleaseActor;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);
	this.SetSpeed_XY(8.00000000 * this.direction, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4020);
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(8);
				this.AddSpeed_XY(1.50000000 * this.direction, 0.00000000);

				if (this.va.x > 15.00000000 * this.direction)
				{
					this.stateLabel = function ()
					{
						this.HitCycleUpdate(8);
						this.VX_Brake(0.50000000, 12.50000000 * this.direction);
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
				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Atk_HighDash_Splash, {});
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Grab_Actor( t )
{
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.owner.target.Warp(this.owner.point0_x - (this.owner.target.point0_x - this.owner.target.x), this.owner.y);
	};
	return true;
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1.00000000)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1.00000000)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.target.DamageGrab_Common(300, 2, -this.direction);
	this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.y);
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
	return true;
}

function Atk_Throw( t )
{
	this.LabelClear();
	this.SetMotion(1802, 1);
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(312, 0, -this.direction);
		},
		function ()
		{
			this.PlaySE(4065);
			this.target.autoCamera = true;
			this.flag1.func[0].call(this.flag1);
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
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1.00000000, this.target.Occult_PowerCreatePoint, t_);
		}
	];
	return true;
}

function Shot_Normal_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, null);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-7.50000000 * this.direction, 0.00000000);
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(4022);
			local t = {};
			t.rot <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.flag2 = this.y <= this.centerY ? -5.00000000 : 5.00000000;
	this.keyAction = [
		function ()
		{
			if (this.flag2 < 0)
			{
				this.centerStop = -3;
			}
			else
			{
				this.centerStop = 3;
			}

			this.SetSpeed_XY(-7.50000000 * this.direction, this.flag2);
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(4022);
			local t = {};
			t.rot <- this.flag1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.30000001, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.10000000, -3.00000000 * this.direction);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.20000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag1 = -40 * 0.01745329;
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag1 = -40 * 0.01745329;
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.Shot_Normal_Init(t);
	this.flag1 = 40 * 0.01745329;
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.Shot_Normal_Air_Init(t);
	this.flag1 = 40 * 0.01745329;
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.flag1 = 0;
	this.func = function ()
	{
		this.SetMotion(this.motion, 2);
		this.flag1++;
		this.count = 0;
		this.PlaySE(4024);
		this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, null);
			this.team.AddMP(-200, 90);
			this.PlaySE(4024);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.stateLabel = function ()
			{
				if (this.count >= 6 && this.flag1 <= 1)
				{
					this.func();
					return;
				}

				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
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
		this.VX_Brake(1.50000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2011, 0);
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.flag1++;
		this.count = 0;

		if (this.va.x * this.direction > -6.00000000)
		{
			this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);
		}

		this.PlaySE(4024);
		this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.team.AddMP(-200, 90);
			this.PlaySE(4024);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.stateLabel = function ()
			{
				if (this.count >= 6 && this.flag1 <= 1)
				{
					this.func();
					return;
				}

				this.CenterUpdate(0.10000000, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.20000000);
				}
			};
		},
		function ()
		{
			if (this.centerStop == 0)
			{
				this.VX_Brake(0.50000000);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5.50000000;
	this.flag2.vy <- 2.50000000;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.count = 0;
	this.flag3 = 0.00000000;

	if (this.input.y < 0)
	{
		this.flag3 = -0.52359873;
	}

	if (this.input.y > 0)
	{
		this.flag3 = 0.52359873;
	}

	this.flag2 = 0;
	this.flag1 = 0.00000000;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			local t_ = {};
			t_.rot <- this.flag3;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
			this.PlaySE(4027);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 1.50000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.34999999);
				}
				else
				{
					this.VX_Brake(0.33000001, -2.00000000 * this.direction);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.75000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.20000000);
		}
	};
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
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.flag2.vec <- this.Vector3();
	this.flag2.vec.x = 1.00000000;
	this.flag2.range <- 5.00000000;
	this.flag2.direction <- this.direction;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0 && this.count % 3 == 1)
		{
			this.PlaySE(4078);
			local t_ = {};
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.vec.x = this.flag2.vec.x * this.flag2.range * this.flag2.direction;
			this.vec.y = this.flag2.vec.y * this.flag2.range;
			this.SetShot(this.x + this.vec.x, this.y + this.vec.y, this.direction, this.Shot_Barrage, t_).weakref();
			this.flag2.vec.RotateByRadian(0.34906584);
			this.flag2.range += (150 - this.flag2.range) * 0.05000000;
		}
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitCount = 0;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4045);

			if (this.back_park == null)
			{
				this.back_park = this.SetFreeObjectStencil(640, 360, 1.00000000, this.Occult_Back, {}).weakref();
			}

			local t_ = {};
			t_.scale <- 1.00000000;
			t_.level <- 0;

			if (this.mukon_charge == 100)
			{
				t_.scale = 3.50000000;
				t_.level = 4;
			}
			else if (this.mukon_charge >= 75)
			{
				t_.scale = 3.00000000;
				t_.level = 3;
			}
			else if (this.mukon_charge >= 50)
			{
				t_.scale = 2.50000000;
				t_.level = 2;
			}
			else if (this.mukon_charge >= 25)
			{
				t_.scale = 2.00000000;
				t_.level = 1;
			}

			if (this.mukon_charge >= 25)
			{
				if (this.mukon_stock.len() > 0 && this.mukon_stock[0])
				{
					this.mukon_stock[0].func[0].call(this.mukon_stock[0]);
					this.mukon_stock.remove(0);
				}

				this.mukon_charge -= 25;
			}

			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.team.AddMP(-200, 120);
			this.back_hole.append(this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.Occult_Hole, t_).weakref());
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Occult_Stump, {});
		}
	];
	return true;
}

function SP_Vuccum_Init( t )
{
	if (this.centerStop * this.centerStop > 1)
	{
		this.SP_Vuccum_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.SetMotion(3000, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.flag1 = true;
	this.flag2 = null;
	this.flag3 = 15;

	if (t.rush)
	{
		this.subState = function ()
		{
			if (this.input.b0 == 1)
			{
				this.flag3 = 15;
			}

			this.flag3--;

			if (this.flag3 <= 0 || ::battle.state != 8)
			{
				this.flag1 = false;
			}
		};
	}
	else
	{
		this.subState = function ()
		{
			if (this.input.b2 == 0 || ::battle.state != 8)
			{
				this.flag1 = false;
			}
		};
	}

	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.count = 0;
			this.PlaySE(4030);
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Vuccum, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.flag2 = null;
			};
			this.stateLabel = function ()
			{
				this.subState();
				this.mukon.Foreach(function ()
				{
					this.func[1].call(this);
				});
				this.VX_Brake(0.75000000);

				if (!this.flag1 && this.count >= 20 || this.count >= 180)
				{
					this.SetMotion(3000, 3);

					if (this.flag2)
					{
						this.flag2.func[0].call(this.flag2);
					}

					this.flag2 = null;
					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0.75000000);
	};
	return true;
}

function SP_Vuccum_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.SetMotion(3001, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.flag1 = true;
	this.flag2 = null;
	this.flag3 = 15;

	if (t.rush)
	{
		this.subState = function ()
		{
			if (this.input.b0 == 1)
			{
				this.flag3 = 15;
			}

			this.flag3--;

			if (this.flag3 <= 0 || ::battle.state != 8)
			{
				this.flag1 = false;
			}
		};
	}
	else
	{
		this.subState = function ()
		{
			if (this.input.b2 == 0 || ::battle.state != 8)
			{
				this.flag1 = false;
			}
		};
	}

	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.count = 0;
			this.PlaySE(4030);
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Vuccum, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.flag2 = null;
			};
			this.stateLabel = function ()
			{
				this.subState();
				this.mukon.Foreach(function ()
				{
					this.func[1].call(this);
				});
				this.CenterUpdate(0.10000000, 3.00000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.75000000);
				}
				else if (this.va.x != 0.00000000)
				{
					this.VX_Brake(0.75000000, 1.00000000 * (this.va.x > 0 ? 1.00000000 : -1.00000000));
				}

				if (!this.flag1 && this.count >= 20 || this.count >= 180)
				{
					this.SetMotion(3000, 3);

					if (this.flag2)
					{
						this.flag2.func[0].call(this.flag2);
					}

					this.flag2 = null;
					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.CenterUpdate(0.10000000, 3.00000000);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.75000000);
		}
		else if (this.va.x != 0.00000000)
		{
			this.VX_Brake(0.75000000, 1.00000000 * (this.va.x > 0 ? 1.00000000 : -1.00000000));
		}
	};
	return true;
}

function SP_Bound_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3010, 0);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4032);
			this.team.AddMP(-200, 120);
			this.centerStop = -2;
			this.SetSpeed_XY(0.00000000, -17.50000000);
			this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B_Mukon, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
			this.stateLabel = function ()
			{
				if (this.y < this.centerY)
				{
					this.AddSpeed_XY(0.00000000, 1.50000000);
				}

				if (this.flag1)
				{
					this.flag1.Warp(this.x, this.flag1.y);
				}

				if (this.va.y > 0.00000000)
				{
					this.graze = 3;

					if (this.flag1 == null && this.y >= this.centerY || this.flag1 && this.y >= this.flag1.y)
					{
						this.graze = 10;
						this.lavelClearEvent = null;

						if (this.flag1)
						{
							this.flag1.ReleaseActor();
						}

						this.SetMotion(this.motion, 2);
						this.hitResult = 1;
						this.Warp(this.x, this.centerY);
						this.SetSpeed_XY(0.00000000, 3.00000000);
						this.centerStop = 1;
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(4034);
			local t_ = {};
			t_.rot <- -0.52359873;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Bound_Big, t_);
			this.SetShot(this.point0_x, this.point0_y, -this.direction, this.SPShot_Bound_Big, t_);
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_Bound_Fire, {});
			this.centerStop = -2;
			this.SetSpeed_XY(-6.00000000 * this.direction, -4.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);

				if (this.va.y > 0.00000000 && this.y >= this.centerY)
				{
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0.00000000, 3.00000000);
					this.centerStop = 1;
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
	};
	return true;
}

function SP_Mine_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Mine_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3020, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.PlaySE(4036);
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);

			for( local i = 1; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- i * 0.52359873;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Bomb_Main, t_);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.44999999);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_Mine_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.SetMotion(3021, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.PlaySE(4036);
			this.centerStop = -2;
			this.SetSpeed_XY(-10.00000000 * this.direction, -2.00000000);

			for( local i = 1; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- i * 0.52359873;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Bomb_Main, t_);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.20000000);
				this.VX_Brake(0.34999999, -2.50000000 * this.direction);
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
		this.CenterUpdate(0.05000000, 2.00000000);
	};
	return true;
}

function SP_Bed_Canon_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_Bed_CanonAir_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 8388608;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3030, 0);
	this.flag1 = [];
	this.flag2 = 0;
	this.flag3 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag3[0].x = -90.00000000;
	this.flag3[0].y = -140;
	this.flag3[1].x = -130.00000000;
	this.flag3[1].y = -60;
	this.flag3[2].x = -130.00000000;
	this.flag3[2].y = 20;
	this.flag3[3].x = -90.00000000;
	this.flag3[3].y = 100;
	this.lavelClearEvent = function ()
	{
		foreach( a in this.flag1 )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.SetParent(null, 0, 0);
				}
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.33000001);

				if (this.count % 4 == 1)
				{
					if (this.flag1.len() > 0)
					{
						this.hitResult = 1;
						this.flag1[0].func[1].call(this.flag1[0]);
						this.flag1.remove(0);
					}
					else
					{
						this.stateLabel = function ()
						{
							this.VX_Brake(0.33000001);
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag2 <= 3 && this.count % 3 == 1)
		{
			this.PlaySE(4039);
			this.flag1.append(this.SetShot(this.x + this.flag3[this.flag2].x * this.direction, this.y + this.flag3[this.flag2].y, this.direction, this.SPShot_Bed_Canon, {}).weakref());
			this.flag2++;
		}
	};
	return true;
}

function SP_Bed_CanonAir_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8388608;
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.SetMotion(3031, 0);
	this.flag1 = [];
	this.flag2 = 0;
	this.flag3 = [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag3[0].x = -90.00000000;
	this.flag3[0].y = -140;
	this.flag3[1].x = -130.00000000;
	this.flag3[1].y = -60;
	this.flag3[2].x = -130.00000000;
	this.flag3[2].y = 20;
	this.flag3[3].x = -90.00000000;
	this.flag3[3].y = 100;
	this.lavelClearEvent = function ()
	{
		foreach( a in this.flag1 )
		{
			if (a)
			{
				a.func[0].call(a);
			}
		}
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.count = 0;
			this.team.AddMP(-200, 120);

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.SetParent(null, 0, 0);
				}
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.33000001);
				this.CenterUpdate(0.10000000, null);

				if (this.count % 2 == 1)
				{
					if (this.flag1.len() > 0)
					{
						this.hitResult = 1;
						this.flag1[0].func[1].call(this.flag1[0]);
						this.flag1.remove(0);
					}
					else
					{
						this.stateLabel = function ()
						{
							this.VX_Brake(0.33000001);
							this.CenterUpdate(0.10000000, null);
						};
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.33000001);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);

		if (this.flag2 <= 3 && this.count % 3 == 1)
		{
			this.PlaySE(4039);
			this.flag1.append(this.SetShot(this.x + this.flag3[this.flag2].x * this.direction, this.y + this.flag3[this.flag2].y, this.direction, this.SPShot_Bed_Canon, {}).weakref());
			this.flag2++;
		}
	};
	return true;
}

function SP_Balloon( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3040, 0);
	this.atk_id = 16777216;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.stateLabel = function ()
	{
	};

	if (this.centerStop * this.centerStop <= 1 || this.centerStop * this.centerStop >= 2 && this.y >= this.centerY)
	{
		this.keyAction = [
			function ()
			{
				this.count = 0;
				this.team.AddMP(-200, 120);
				this.centerStop = -2;
				this.PlaySE(4042);
				this.stateLabel = function ()
				{
					if (this.count == 20)
					{
						this.hitResult = 1;
					}

					this.AddSpeed_XY(0.50000000 * this.direction, -1.00000000, 6.00000000 * this.direction, -7.50000000);

					if (this.y < this.centerY - 150 && this.va.y <= -4.50000000 || !this.flag1 && this.keyTake == 2 || this.y < this.centerY - 25 && this.count >= 20)
					{
						this.hitResult = 1;

						if (this.flag1)
						{
							this.flag1.func[1].call(this.flag1);
						}

						this.flag1 = null;
						this.lavelClearEvent = null;
						this.SetMotion(3040, 3);
						this.stateLabel = function ()
						{
						};
						return;
					}
				};
			},
			function ()
			{
				this.balloon.Foreach(function ()
				{
					this.func[0].call(this);
				});
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Balloon, {}).weakref();
				this.lavelClearEvent = function ()
				{
					if (this.flag1)
					{
						this.flag1.func[2].call(this.flag1);
					}

					this.flag1 = null;
				};
			}
		];
	}
	else
	{
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(0.00000000, -1.50000000);
				this.team.AddMP(-200, 120);
				this.centerStop = -2;
				this.PlaySE(4042);
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.count == 20)
					{
						this.hitResult = 1;
					}

					this.AddSpeed_XY(1.00000000 * this.direction, 0.25000000, 6.00000000 * this.direction, 6.00000000);

					if (this.y >= this.centerY)
					{
						this.centerStop = 1;
						this.SetSpeed_XY(this.va.x, 3.00000000);
						this.hitResult = 1;

						if (this.flag1)
						{
							this.flag1.func[1].call(this.flag1);
						}

						this.flag1 = null;
						this.lavelClearEvent = null;
						this.SetMotion(3040, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
							this.CenterUpdate(this.baseGravity, null);
						};
						return;
					}

					if (!this.flag1 && this.keyTake == 2 || this.count == 30)
					{
						this.hitResult = 1;

						if (this.flag1)
						{
							this.flag1.func[1].call(this.flag1);
						}

						this.flag1 = null;
						this.lavelClearEvent = null;
						this.SetMotion(3040, 3);
						this.stateLabel = function ()
						{
						};
						return;
					}
				};
			},
			function ()
			{
				this.balloon.Foreach(function ()
				{
					this.func[0].call(this);
				});
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_Balloon, {}).weakref();
				this.lavelClearEvent = function ()
				{
					if (this.flag1)
					{
						this.flag1.func[2].call(this.flag1);
					}

					this.flag1 = null;
				};
			}
		];
	}

	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4000, 0);
	this.atk_id = 67108864;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.team.spell_enable_end = false;
			this.hitResult = 1;
			this.PlaySE(4048);
			local t_ = {};
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.atk_id = 67108864;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(4050);
			this.hitResult = 1;
			local t_ = {};
			this.flag1 = this.SetShot(this.target.x, this.target.y, this.direction, this.SpellShot_B, t_).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}

				this.flag1 = null;
			};
		},
		function ()
		{
			this.PlaySE(4051);

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}
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
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.flag1 = this.Vector3();
	this.flag2 = 30 * 0.01745329;
	this.flag3 = this.Vector3();
	this.flag4 = 0;
	this.keyAction = [
		function ()
		{
			this.flag1.x = this.va.x;
			this.flag1.y = this.va.y;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.UseSpellCard(60, -this.team.sp_max);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.flag1.x, this.flag1.y);
			this.count = 0;
			this.PlaySE(4055);
			this.hitResult = 1;
			this.flag2 = 45;
			this.stateLabel = function ()
			{
				local r_ = 0.00000000;
				this.centerStop = -2;

				if (this.input.x == 0)
				{
					if (this.input.y == 0)
					{
						this.Vec_Brake(0.50000000);
					}
					else
					{
						if (this.input.y < 0)
						{
							r_ = -1.57079601;
						}

						if (this.input.y > 0)
						{
							r_ = 1.57079601;
						}

						this.SetSpeed_Vec(3.00000000, r_);
					}
				}
				else
				{
					if (this.input.x < 0)
					{
						r_ = 3.14159203;

						if (this.input.y < 0)
						{
							r_ = -135 * 0.01745329;
						}

						if (this.input.y > 0)
						{
							r_ = 135 * 0.01745329;
						}
					}

					if (this.input.x > 0)
					{
						if (this.input.y < 0)
						{
							r_ = -45 * 0.01745329;
						}

						if (this.input.y > 0)
						{
							r_ = 45 * 0.01745329;
						}
					}

					this.SetSpeed_Vec(3.00000000, r_);
				}

				if (this.va.y < 0.00000000 && this.y < ::battle.scroll_top + 128)
				{
					this.SetSpeed_XY(this.va.x, 0.00000000);
				}

				if (this.count % 6 == 1)
				{
					this.PlaySE(4053);
				}

				if (this.count % 4 == 1)
				{
					local t_ = {};
					t_.rot <- this.flag2 * 0.01745329;
					t_.v <- 12.50000000;
					this.flag3.x = 70.00000000;
					this.flag3.y = 0.00000000;
					this.flag3.RotateByRadian(t_.rot);
					this.SetShot(this.point0_x + this.flag3.x * this.direction, this.point0_y + this.flag3.y, this.direction, this.SpellShot_C, t_);
					this.flag2 -= 15;

					if (this.flag2 < -45)
					{
						this.flag2 = 45;
					}
				}

				if (this.count == 120)
				{
					this.count = 0;
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						if (this.centerStop == 0)
						{
							this.VX_Brake(0.50000000);
						}
						else
						{
							this.CenterUpdate(0.10000000, 1.00000000);
						}

						if (this.count == 10)
						{
							this.SetMotion(4020, 3);
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		},
		null,
		function ()
		{
			::camera.Shake(10.00000000);
			this.PlaySE(4066);
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_PartA, {});
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_PartB, {});
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_PartC, {});
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C_PartD, {});
			this.stateLabel = function ()
			{
			};
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
			this.CenterUpdate(0.05000000, 0.50000000);
		}
	};
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 1.00000000;
	this.flag2 = null;
	this.flag3 = false;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–‚à‚¤–\x250cŠo‚\x2580‚\x255a‚­‚\x2500—\x255f‚¢‚\x2560‚æ–");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();
			};
		},
		function ()
		{
			this.PlaySE(4056);
			this.count = 0;
			this.SetSpeed_XY(2.00000000 * this.direction, -0.69999999);
			this.centerStop = -2;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Climax_Shot, {}).weakref();
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();

				if (this.flag2)
				{
					if (this.target.attackTarget == this.flag2)
					{
						this.target.attackTarget = null;

						if (this.target.team.life > 0)
						{
							this.target.enableStandUp = true;
						}
					}

					this.flag2.func[0].call(this.flag2);
				}
			};
			this.stateLabel = function ()
			{
				this.flag1 += 0.04000000;

				if (this.flag2)
				{
					this.flag2.SetCollisionScaling(this.flag1, this.flag1, 1.00000000);

					if (this.flag2.hitResult & 1 && (this.target.team.master.IsDamage() && this.target.team.master.damageTarget == this.flag2 || this.target.team.slave.IsDamage() && this.target.team.slave.damageTarget == this.flag2))
					{
						this.target.attackTarget = this.flag2.weakref();
						this.target.enableStandUp = false;
					}
				}

				if (this.count <= 90 && this.count % 3 == 1)
				{
					local t_ = {};
					t_.size <- 100 * this.flag1;
					this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Climax_Circle, t_);
				}

				if (this.flag2 && this.count == 85)
				{
				}

				if (this.count == 90)
				{
					if (this.flag2.hitResult & 1 && (this.target.team.master.IsDamage() && this.target.team.master.damageTarget == this.flag2 || this.target.team.slave.IsDamage() && this.target.team.slave.damageTarget == this.flag2))
					{
						this.flag2.func[0].call(this.flag2);
						this.lavelClearEvent = null;
						this.Climax_Hit(null);
						return;
					}

					this.flag2.func[0].call(this.flag2);
				}

				if (this.count >= 90)
				{
					this.Vec_Brake(0.02500000);
				}

				if (this.count == 115)
				{
					this.SetMotion(4900, 4);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.40000001, null);
						this.VX_Brake(0.05000000);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(4900, 6);
							this.stateLabel = function ()
							{
								this.VX_Brake(0.50000000);
							};
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(4.00000000);
	};
	return true;
}

function Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	::battle.enableTimeUp = false;
	this.count = 0;
	this.flag4 = null;
	this.PlaySE(4058);
	this.stateLabel = function ()
	{
		this.flag1 += 0.10000000;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.size <- 100 * this.flag1;
			this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Climax_Circle, t_);
		}

		if (this.count == 30)
		{
			::camera.shake_radius = 20.00000000;
			this.flag4 = this.SetFreeObject(0, 0, 1.00000000, this.Climax_Seat, {}).weakref();
		}

		if (this.count == 80)
		{
			this.flag4.func[0].call(this.flag4);
			this.Climax_SceneA(null);
		}
	};
	return true;
}

function Climax_SceneA( t )
{
	this.LabelReset();
	this.HitReset();
	this.target.attackTarget = null;

	if (this.target.team.life > 0)
	{
		this.target.enableStandUp = true;
	}

	this.SetMotion(4901, 1);
	this.PlaySE(4059);
	this.target.DamageGrab_Common(308, 0, this.target.direction);
	this.EraceBackGround();
	this.flag5 = {};
	this.flag5.back <- this.SetFreeObject(640, 360, 1.00000000, this.Climax_Back, {}).weakref();
	this.flag5.squeez <- this.SetFreeObject(640, 360, 1.00000000, this.Climax_Squeez, {}).weakref();
	this.flag5.enemy <- this.target.SetFreeObject(640, 360, -1.00000000, this.Climax_EnemyStun, {}).weakref();
	this.flag5.midBack <- null;
	this.flag5.base_back <- this.SetFreeObject(0, 0, 1.00000000, this.Climax_Back_Black, {}).weakref();
	this.flag5.face <- null;
	this.flag5.gate <- [
		null,
		null
	];
	this.flag5.chain <- [
		null,
		null,
		null,
		null,
		null
	];
	this.count = -30;
	this.func = [
		function ()
		{
			this.PlaySE(4063);
			this.count = -30;
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.squeez.func[1].call(this.flag5.squeez);
			this.flag5.enemy.func[1].call(this.flag5.enemy);

			foreach( a in this.flag5.chain )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}

			this.flag5.midBack = this.SetFreeObject(0, 0, 1.00000000, this.Climax_MidBack, {}).weakref();
			this.flag5.face = this.SetFreeObject(640, 360, 1.00000000, this.Climax_Cut, {}).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 80)
				{
					this.flag5.face.func[1].call(this.flag5.face);
					this.PlaySE(4062);
				}

				if (this.count == 90)
				{
					this.flag5.face.func[2].call(this.flag5.face);
				}

				if (this.count == 95)
				{
					this.FadeOut(1.00000000, 1.00000000, 1.00000000, 10);
				}

				if (this.count == 150)
				{
					if (this.flag5.back)
					{
						this.flag5.back.func[0].call(this.flag5.back);
					}

					if (this.flag5.squeez)
					{
						this.flag5.squeez.func[0].call(this.flag5.squeez);
					}

					if (this.flag5.enemy)
					{
						this.flag5.enemy.func[0].call(this.flag5.enemy);
					}

					if (this.flag5.midBack)
					{
						this.flag5.midBack.func[0].call(this.flag5.midBack);
					}

					if (this.flag5.face)
					{
						this.flag5.face.func[0].call(this.flag5.face);
					}

					foreach( a in this.flag5.chain )
					{
						if (a)
						{
							a.func[0].call(a);
						}
					}

					this.Climax_Finish(null);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.PlaySE(4060);
			local t_ = {};
			t_.scale <- 6.00000000;
			t_.rot <- -20 * 0.01745329;
			this.flag5.chain[2] = this.SetFreeObjectDynamic(640 - 440, 360 + 100, 1.00000000, this.Climax_ChainPre, t_).weakref();
		}

		if (this.count == 60)
		{
			this.PlaySE(4060);
			local t_ = {};
			t_.scale <- 4.00000000;
			t_.rot <- 190 * 0.01745329;
			this.flag5.chain[3] = this.SetFreeObjectDynamic(640 + 420, 360 - 200, 1.00000000, this.Climax_ChainPre, t_).weakref();
		}

		if (this.count == 120)
		{
			this.PlaySE(4080);
			this.flag5.chain[0] = this.SetFreeObjectDynamic(600, 360, 1.00000000, this.Climax_Chain, {}).weakref();
			this.flag5.chain[1] = this.SetFreeObjectDynamic(680, 360, -1.00000000, this.Climax_Chain, {}).weakref();
		}

		if (this.count == 170)
		{
			this.PlaySE(4061);

			if (this.flag5.chain[2])
			{
				this.flag5.chain[2].func[2].call(this.flag5.chain[2]);
			}

			if (this.flag5.chain[3])
			{
				this.flag5.chain[3].func[2].call(this.flag5.chain[3]);
			}
		}

		if (this.count == 220)
		{
			this.func[0].call(this);
		}
	};
}

function Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 2);
	this.flag5.base_back.func[0].call(this.flag5.base_back);
	this.EraceBackGround(false);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 30);
	this.PlaySE(4064);
	this.Warp(640, this.centerY);
	this.centerStop = -3;
	this.SetSpeed_XY(-4.00000000 * this.direction, -6.00000000);
	this.target.x = 640 + 60 * this.direction;
	this.target.y = this.centerY - 20;
	this.target.attackTarget = null;
	::camera.ResetTarget();
	this.KnockBackTarget(-this.direction);
	::camera.shake_radius = 30.00000000;
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.hitCount = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.20000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.EndtoFreeMove();
		}
	};
}

