function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 7)
	{
		this.BeginBattle_Koishi(null);
		return;
	}

	local r_ = this.rand() % 2;

	if (r_ == 1)
	{
		this.BeginBattleA(null);
	}
	else
	{
		this.BeginBattleB(null);
		  // [041]  OP_JMP            0      0    0    0
	}
}

function Func_Win()
{
	local r_ = this.rand() % 2;

	if (r_ == 1)
	{
		this.WinA(null);
	}
	else
	{
		this.WinB(null);
		  // [020]  OP_JMP            0      0    0    0
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattleA( t )
{
	this.Warp(this.x - 800 * this.direction, this.y - 300);
	this.SetSpeed_XY(10.00000000 * this.direction, 18.00000000);
	this.LabelClear();
	this.count = 0;
	this.PlaySE(1290);

	if (this.team.index == 0)
	{
		this.flag1 = 0;
	}
	else
	{
		this.flag1 = 1;
	}

	this.SetMotion(9000, 0);
	this.func = function ()
	{
		if (this.count % 3 == 0)
		{
			this.SetFreeObject(this.point0_x + 45 - this.rand() % 90, this.point0_y + 30 - this.rand() % 60, this.direction, this.BattleBeginObject_A, {});
		}
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.50000000);
		this.func();

		if (this.va.y <= 0.00000000)
		{
			this.centerStop = -2;
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.func();
				local v_ = (::battle.start_x[this.flag1] - this.x) * this.direction * 0.10000000;

				if (v_ <= this.va.x * this.direction)
				{
					this.SetSpeed_XY(v_ * this.direction, null);
				}

				this.AddSpeed_XY(0.00000000, -0.50000000);

				if (this.va.y < -7.00000000)
				{
					this.stateLabel = function ()
					{
						this.func();
						local v_ = (::battle.start_x[this.flag1] - this.x) * this.direction * 0.10000000;

						if (this.abs(::battle.start_x[this.flag1] - this.x) <= 0.50000000)
						{
							this.Warp(::battle.start_x[this.flag1], this.y);
							this.SetSpeed_XY(0.00000000, null);
						}

						if (v_ <= this.va.x * this.direction)
						{
							this.SetSpeed_XY(v_ * this.direction, null);
						}

						this.CenterUpdate(0.50000000, 5.00000000);
					};
				}
			};
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;
			this.SetMotion(0, 0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 5.00000000);

				if (this.count >= 60)
				{
					this.CommonBegin();
					this.LabelClear();
					this.stateLabel = this.Stand;
				}
			};
		}
	];
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9001, 0);
	this.count = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
}

function BeginBattle_Koishi( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.team.slave.BeginBattle_Marisa(null);
		},
		null,
		null,
		null,
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
}

function WinA( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1291);
		},
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

function WinB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(1292);
			this.stateLabel = function ()
			{
				this.SetFreeObject(this.point0_x - 25 + this.rand() % 50, this.point0_y - 25 + this.rand() % 50, this.direction, this.BattleWinObject_A, {});
			};
		},
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

function Lose( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 90)
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
	this.VX_Brake(0.80000001);
}

function MoveFront_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(7.00000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5.75000000 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 19.50000000;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 10.00000000;
	t_.front <- 8.00000000;
	t_.back <- -8.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- -19.50000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 19.50000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 10.00000000;
	t_.front <- 8.00000000;
	t_.back <- -8.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- -19.50000000;
	t_.v2 <- -8.00000000;
	t_.v3 <- 19.50000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 10.00000000;
	t_.front <- 8.00000000;
	t_.back <- -8.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- 19.50000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 19.50000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 10.00000000;
	t_.front <- 8.00000000;
	t_.back <- -8.00000000;
	t_.front_rev <- 5.50000000;
	t_.back_rev <- -5.50000000;
	t_.v <- 19.50000000;
	t_.v2 <- 8.00000000;
	t_.v3 <- 19.50000000;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 8.50000000;
	this.flag5.vy = 5.00000000;
	this.flag5.g = 0.50000000;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7.50000000;
	this.flag5.vy = 7.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = -8.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = 8.50000000;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	if (t == null && this.GetFront())
	{
		this.DashBack_Init(null);
	}
	else
	{
		this.LabelClear();
		this.SetMotion(40, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(801);
				this.SetSpeed_XY(7.00000000 * this.direction, 0.00000000);
				this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.AddSpeed_XY(0.34999999 * this.direction, 0.00000000);

					if (this.va.x * this.direction > 16.00000000)
					{
						this.SetSpeed_XY(16.00000000 * this.direction, null);
					}
				};
			}
		];
		this.subState = function ()
		{
			if (this.keyTake == 2 && this.input.x * this.direction <= 0 && this.count >= 5 || this.count >= 120)
			{
				this.SetMotion(this.motion, 3);
				this.stateLabel = function ()
				{
					this.VX_Brake(0.50000000);
				};
				return true;
			}

			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.input.y > 0)
				{
					this.command.ban_slide = 1;
					this.SlideFall_Init(null);
					return true;
				}
				else if (this.input.y < 0)
				{
					this.command.ban_slide = -1;
					this.SlideUp_Init(null);
					return true;
				}
			}

			return false;
		};
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 10.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 20;
	t_.wait <- 60;
	t_.addSpeed <- 0.15000001;
	t_.maxSpeed <- 15.00000000;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(801);
			this.SetSpeed_XY(-13.50000000 * this.direction, -4.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.60000002);

				if (this.y > this.centerY && this.va.y > 0.00000000)
				{
					this.SetMotion(41, 3);
					this.centerStop = 1;
					this.SetSpeed_XY(null, 2.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -11.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 14.00000000;
	this.DashBack_Air_Common(t_);
}

function Flight_Assult_Init( t )
{
	this.Flight_Assult_Common(t);
	this.flag2 = 13.50000000;
	this.flag4 = 0.00000000;
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
			this.PlaySE(1200);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1218);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1600, 0);
	this.atk_id = 4;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1220);
			this.SetSpeed_XY(7.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
			};
		},
		null,
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
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1202);

			if (this.va.x * this.direction <= 5.00000000)
			{
				this.SetSpeed_XY(5.00000000 * this.direction, null);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		},
		null,
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
		this.VX_Brake(0.50000000);
	};
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
			this.PlaySE(1200);
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
					this.VX_Brake(1.00000000);
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1110, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.Atk_HighUnder_Init(null);
	this.flag1 = false;
	this.SetMotion(1710, 0);
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
			this.SetSpeed_XY(10.00000000 * this.direction, 12.50000000);
			this.PlaySE(1204);
			this.centerStop = 3;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.flag1 = true;

	if (this.y >= this.centerY)
	{
		this.SetMotion(1211, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1204);
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
						this.VX_Brake(0.75000000);
					}
				};
			}
		];
		this.stateLabel = function ()
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(1211, 3);
				this.stateLabel = function ()
				{
					this.VX_Brake(0.75000000);
				};
			}
		};
	}
	else
	{
		this.SetMotion(1212, 0);
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1208);
				this.centerStop = 2;
				this.SetSpeed_XY(14.00000000 * this.direction, 8.00000000);
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(5);

					if (this.y >= this.centerY)
					{
						this.SetMotion(1212, 2);
						this.keyAction[1].call(this);
						return;
					}
				};
			},
			function ()
			{
				this.HitTargetReset();
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(null, -0.50000000);
					this.VX_Brake(0.75000000);
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
			if (this.input.b1 <= 0)
			{
				this.flag1 = false;
			}

			this.CenterUpdate(0.25000000, 3.00000000);
			this.VX_Brake(0.30000001);
		};
	}

	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.SetMotion(1720, 0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.flag1 = false;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1210);
			this.SetSpeed_XY(9.00000000 * this.direction, -7.50000000);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
				this.AddSpeed_XY(0.00000000, 0.40000001);
			};
		},
		null,
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.25000000);
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.SetMotion(1220, 0);
	this.flag1 = true;
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1210);
		},
		function ()
		{
			this.SetSpeed_XY(6.00000000 * this.direction, -7.50000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
				this.AddSpeed_XY(0.00000000, 0.40000001);
			};
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.25000000);

		if (this.input.b1 <= 0)
		{
			this.flag1 = false;
		}
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1222, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1210);
			this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
				this.CenterUpdate(0.25000000, 6.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1222, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		null,
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1222, 5);
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
	this.stateLabel = function ()
	{
	};
	return true;
}

function Atk_HighUpper_Charge()
{
	this.SetMotion(1221, 0);
	this.LabelClear();
	this.HitReset();
	this.SetChargeAura(null);
	this.keyAction = [
		function ()
		{
			this.SetChargeAuraB(null);
			this.PlaySE(1210);
			this.SetSpeed_XY(8.00000000 * this.direction, -14.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
				this.AddSpeed_XY(0.00000000, 0.60000002);
			};
		},
		null,
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
		this.CenterUpdate(0.25000000, null);
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1730, 0);
	this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.60000002);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1206);
			this.SetSpeed_XY(20.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 0.50000000 : 0.05000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
		}
	];
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
	this.SetMotion(1230, 0);
	this.Atk_HighFront(t);
	this.atk_id = 32;
	return true;
}

function Atk_HighFront( t )
{
	this.flag1 = true;
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1206);
			this.SetSpeed_XY(15.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 0.50000000 : 0.05000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		},
		function ()
		{
		}
	];
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.Atk_HighFront_Air_Init(t);
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
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
	this.SetMotion(1235, 0);
	this.keyAction = [
		function ()
		{
			if (this.y <= this.centerY)
			{
				this.centerStop = -2;
				this.SetSpeed_XY(15.00000000 * this.direction, -4.00000000);
			}
			else
			{
				this.centerStop = 2;
				this.SetSpeed_XY(15.00000000 * this.direction, 4.00000000);
			}

			this.PlaySE(1206);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 1.00000000 ? 0.50000000 : 0.05000000);
				this.CenterUpdate(0.50000000, 8.00000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.50000000, null);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
					return;
				}

				this.VX_Brake(0.10000000);
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
				else
				{
					this.VX_Brake(0.10000000);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
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
	this.stateLabel = function ()
	{
	};
	this.SetMotion(1300, 0);
	this.SetSpeed_XY(10.00000000 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1212);
		},
		function ()
		{
			this.PlaySE(1213);
			this.HitReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	return true;
}

function Atk_LowDash()
{
	if (this.keyTake <= 2)
	{
		this.CenterUpdate(0.20000000, 4.00000000);
	}

	if (this.keyTake >= 3)
	{
		this.VX_Brake(0.50000000);
	}
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1216);
			this.SetSpeed_XY(12.00000000 * this.direction, 0.00000000);
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 5.00000000);

				if (this.hitResult)
				{
					this.flag1++;

					if (this.flag1 >= 8)
					{
						this.flag1 = 0;
						this.HitReset();
					}
				}
			};
		},
		function ()
		{
			this.PlaySE(1216);
		},
		function ()
		{
			this.PlaySE(1216);
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
		this.target.Warp(this.initTable.pare.point0_x + (this.target.x - this.target.point0_x), this.initTable.pare.y);
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.DamageGrab_Common(301, 2, -this.direction);
	::battle.enableTimeUp = false;
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.target.y;
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
			this.stateLabel = function ()
			{
			};
			this.target.DamageGrab_Common(300, 0, -this.direction);
		},
		function ()
		{
			this.PlaySE(1224);
			this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.Grab_Smash, {});
			this.flag1.func[0].call(this.flag1);
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			this.HitReset();
			this.hitResult = 1;
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			::battle.enableTimeUp = true;
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
			this.stateLabel = function ()
			{
				this.VX_Brake(0.60000002);
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
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.team.AddMP(-200, 90);
			this.PlaySE(1250);
			local t_ = {};
			t_.rot <- 0.00000000;

			if (this.target.centerStop * this.target.centerStop >= 2)
			{
				t_.rot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				t_.rot = this.Math_MinMax(t_.rot, -0.26179937, 0.26179937);
			}

			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.SetShot(pos_.x, pos_.y, this.direction, this.NormalShot, t_);
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
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			if (this.y > this.centerY)
			{
				this.centerStop = 2;
				this.SetSpeed_XY(-10.00000000 * this.direction, 3.00000000);
			}
			else
			{
				this.centerStop = -2;
				this.SetSpeed_XY(-10.00000000 * this.direction, -3.00000000);
			}

			this.team.AddMP(-200, 90);
			this.PlaySE(1250);
			local t_ = {};
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -0.26179937, 0.26179937);
			this.SetShot(pos_.x, pos_.y, this.direction, this.NormalShot, t_);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.20000000, 2.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.25000000);
				}
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
				else
				{
					this.VX_Brake(0.25000000);
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
		else
		{
			this.VX_Brake(0.20000000);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = 7.00000000;
			t_.v.y = -13.50000000;
			t_.h <- -1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Bottle, t_);
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
	this.SetMotion(2004, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = 7.00000000;
			t_.v.y = -13.50000000;
			t_.h <- -1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Bottle, t_);
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

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2002, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = 7.00000000;
			t_.v.y = 6.00000000;
			t_.h <- 1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Bottle, t_);
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
	this.SetMotion(2005, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = 7.00000000;
			t_.v.y = 6.00000000;
			t_.h <- 1.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Bottle, t_);
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

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.count = 0;
			this.PlaySE(1253);
			local t_ = {};
			t_.rot <- 0.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Laser, t_, this.weakref());
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -1.00000000 ? 0.25000000 : 0.00000000);
			};
		},
		function ()
		{
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
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2011, 0);
	this.count = 0;
	this.GetFront();
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.count = 0;
			this.PlaySE(1253);
			local t_ = {};
			t_.rot <- 0.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Laser, t_, this.weakref());
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -1.00000000 ? 0.25000000 : 0.00000000);
				this.CenterUpdate(0.10000000, 3.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0.50000000);
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
				this.VX_Brake(0.50000000);
				this.CenterUpdate(0.10000000, 3.00000000);
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
		this.CenterUpdate(0.10000000, 1.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;
	this.subState = function ()
	{
	};
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.flag1 = true;
	this.flag2 = 0.00000000;
	this.flag3 = 0.00000000;
	this.flag4 = t.charge;

	if (this.input.y < 0)
	{
		this.flag2 = -30 * 0.01745329;
		this.flag3 = -50;
	}

	if (this.input.y > 0)
	{
		this.flag2 = 30 * 0.01745329;
		this.flag3 = 50;
	}

	this.SetMotion(2020, 0);
	this.func = function ()
	{
		if (this.input.y < 0)
		{
			this.flag2 = -30 * 0.01745329;
			this.flag3 = -50;
		}

		if (this.input.y > 0)
		{
			this.flag2 = 30 * 0.01745329;
			this.flag3 = 50;
		}

		this.SetMotion(2020, 2);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.75000000);
		};
	};
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
		this.CenterUpdate(0.10000000, null);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1305);
			local t_ = {};
			t_.rot <- this.flag2;

			if (this.flag4)
			{
				this.SetShot(this.point0_x, this.point0_y + this.flag3, this.direction, this.Shot_ChargeFull, t_);
			}
			else
			{
				this.SetShot(this.point0_x, this.point0_y + this.flag3, this.direction, this.Shot_Charge, t_);
			}

			this.SetSpeed_XY(-7.50000000 * this.direction, -10.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.05000000);
				this.AddSpeed_XY(null, 0.94999999);

				if (this.y > this.centerY && this.va.y > 0.00000000)
				{
					this.SetMotion(2020, 4);
					this.centerStop = 2;
					this.SetSpeed_XY(this.va.x * 0.50000000, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		}
	];
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.pos <- this.Vector3();
	this.flag2.pos.y = this.y > this.centerY ? 80 : -80;
	this.flag2.rot_speed <- 13 * 0.01745329;

	if (this.y > this.centerY)
	{
		this.flag2.rot_speed = -13 * 0.01745329;
	}

	this.subState = function ()
	{
		if (this.team.mp > 0)
		{
			if (this.count >= 10 && this.count % 2 == 0)
			{
				this.PlaySE(1225);
				local t_ = {};
				t_.v <- this.Vector3();
				t_.v.x = this.flag2.pos.x * 0.20000000 * this.direction;
				t_.v.y = this.flag2.pos.y * 0.20000000;
				this.SetShot(this.x + this.flag2.pos.x * this.direction, this.y - 20 + this.flag2.pos.y, this.direction, this.Shot_Barrage, t_).weakref();
				this.flag2.pos.RotateByRadian(this.flag2.rot_speed);
			}
		}
	};
	return true;
}

function Okult_PreAura( t )
{
	this.SetMotion(2508, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.sx = this.sy = 0.00000000;
	this.flag1 = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.owner.Okult_PreAuraB, {}).weakref();
	this.SetParent.call(this.flag1, this, 0, 0);
	this.func = [
		function ()
		{
			this.flag1.func[0].call(this.flag1);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.80000001;
				this.alpha -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag1.func[1].call(this.flag1);
			this.SetParent(null, 0, 0);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2.50000000 - this.sx) * 0.15000001;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Okult_PreAuraRing, {});
		}
	];
	this.subState = function ()
	{
		if (this.owner.motion != 2500)
		{
			this.func[0].call(this);
			return true;
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += (0.60000002 - this.sx) * 0.20000000;

		if (this.sx >= 0.50000000)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += (0.33000001 - this.sx) * 0.00500000;
				this.subState();
			};
		}

		this.subState();
	};
}

function Okult_PreAuraB( t )
{
	this.SetMotion(2508, 1);
	this.sx = this.sy = 0.10000000;
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 256;
	this.anime.vertex_alpha1 = 0.00000000;
	this.anime.vertex_blue1 = 0.00000000;
	this.anime.vertex_green1 = 0.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 12.00000000;
				this.alpha -= 0.15000001;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top -= 10.00000000;
				this.sx = this.sy += 0.10000000;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top += 12.00000000;
		this.sx = this.sy += (1.00000000 - this.sx) * 0.05000000;
	};
}

function Okult_PreAuraRing( t )
{
	this.SetMotion(2508, 2);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (3.50000000 - this.sx) * 0.15000001;
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.count = 0;
	this.flag2 = true;
	this.flag3 = null;
	this.flag4 = 5;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
				this.CenterUpdate(0.10000000, 1.00000000);

				if (this.count >= this.flag4)
				{
					this.team.AddMP(-200, 120);
					this.team.op_stop = 300;
					this.team.op_stop_max = 300;
					this.SetMotion(this.motion, 2);
					this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});

					switch(this.okltSelect)
					{
					case 0:
						this.okltItem = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_OkultA, {}).weakref();
						break;

					case 1:
						this.okltItem = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_OkultB, {}).weakref();
						break;

					case 2:
						this.okltItem = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_OkultD, {}).weakref();
						break;

					case 3:
						this.okltItem = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_OkultF, {}).weakref();
						break;
					}

					this.stateLabel = function ()
					{
						this.VX_Brake(0.40000001);
						this.CenterUpdate(0.10000000, 1.00000000);
					};
				}
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
		this.VX_Brake(0.25000000);
		this.CenterUpdate(0.10000000, 1.00000000);
	};
	this.okltSelect++;

	if (this.okltSelect >= 4)
	{
		this.okltSelect = 0;
	}

	return true;
}

function Okult_InitA( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_OkultA, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Okult_InitB( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_OkultB, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Okult_InitC( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			this.SetOccultAura(null);
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_OkultC, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Okult_InitD( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			this.SetOccultAura(null);
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetObject(pos_.x, pos_.y, this.direction, this.Shot_OkultD, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Okult_InitE( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			this.SetOccultAura(null);
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetObject(pos_.x, pos_.y, this.direction, this.Shot_OkultE, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Okult_InitF( t )
{
	this.SetMotion(2500, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 0 && !this.flag2 || this.count >= 90)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = null;
				}
			};
		},
		null,
		function ()
		{
			this.SetOccultAura(null);
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.okltItem = this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_OkultF, {}).weakref();
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 3;
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

		if (this.keyTake == 0)
		{
			this.VX_Brake(1.00000000);
		}
	};
	this.flag3 = 4;
	this.SetMotion(3000, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_Vec(25.00000000, 0.00000000, this.direction);
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
				this.VX_Brake(1.00000000);
			};
		}
	];
	return true;
}

function SP_A_Bloom( t )
{
	this.SetMotion(3009, 0);
	this.DrawActorPriority(191);
	this.SetParent(this.owner, 0, 0);
	this.func = function ()
	{
		this.SetKeyFrame(1);
		this.count = 0;
		this.SetParent(null, 0, 0);
		this.stateLabel = function ()
		{
			this.sy *= 0.85000002;
			this.count++;

			if (this.count == 30)
			{
				this.ReleaseActor();
			}
		};
	};
}

function SP_A_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 3;
	this.AjustCenterStop();
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

		if (this.keyTake == 0)
		{
			this.Vec_Brake(1.00000000);
		}
	};
	this.flag3 = 4;
	this.SetMotion(3002, 0);
	this.keyAction = [
		function ()
		{
			this.AjustCenterStop();
			this.team.AddMP(-200, 120);
			this.SetSpeed_Vec(20.00000000, 0.00000000, this.direction);
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
			this.SetSpeed_XY(this.va.x * 0.75000000, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.CenterUpdate(0.25000000, null);
			};
		}
	];
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.count = 0;
	this.SetMotion(3010, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.flag1 = -3.14159203 / 30 * this.direction;
			this.SetSpeed_XY(0.00000000, 15.00000000);
			this.PlaySE(1302);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.Vec_Rotate(this.flag1);
			};
		},
		function ()
		{
			this.centerStop = -2;
			this.count = 0;
			this.flag2 = 0;
			this.SetSpeed_XY(0.00000000, -30.00000000);
			this.PlaySE(1303);
			this.stateLabel = function ()
			{
				if (this.hitResult)
				{
					this.flag2++;

					if (this.flag2 >= 3)
					{
						this.HitReset();
						this.flag2 = 0;
					}
				}

				if (this.count >= 10)
				{
					this.SetSpeed_XY(0.00000000, this.va.y * 0.85000002);
				}

				if (this.count >= 20)
				{
					this.SetMotion(this.motion, 3);
					this.HitTargetReset();
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.75000000, null, 12.50000000);
					};
				}
			};
			local t_ = {};
			t_.rf <- false;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B_Blade, t_);
		},
		function ()
		{
			this.HitTargetReset();
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.75000000, null, 12.50000000);

				if (this.count >= 6 && this.y >= this.centerY)
				{
					this.centerStop = 1;
					this.stateLabel = null;
					this.SetSpeed_XY(null, 3.50000000);
					this.SetMotion(this.motion, 5);
				}
			};
		},
		function ()
		{
		}
	];
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3020, 0);
		this.func = function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-12.50000000 * this.direction, -10.00000000);
			this.PlaySE(1305);
			local t_ = {};
			t_.rot <- 0.00000000;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		};
	}
	else if (this.y < this.centerY)
	{
		this.SetMotion(3022, 0);
		this.func = function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-12.50000000 * this.direction, -10.00000000);
			this.PlaySE(1305);
			local t_ = {};
			t_.rot <- 20.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		};
	}
	else
	{
		this.SetMotion(3021, 0);
		this.func = function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-12.50000000 * this.direction, -8.00000000);
			this.PlaySE(1305);
			local t_ = {};
			t_.rot <- -20.00000000 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		};
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(1.00000000);
	};
	this.keyAction = [
		function ()
		{
			this.Vec_Brake(1.00000000);
			this.stateLabel = function ()
			{
				this.func();
				this.SetMotion(this.motion, 2);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000);
					this.AddSpeed_XY(null, 0.40000001);
				};
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000);
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
				this.AddSpeed_XY(null, 0.40000001);
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

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3030, 0);
	this.count = 0;
	this.flag3 = 3;
	this.flag4 = -960;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		null,
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);

				if (this.count % 5 == 0)
				{
					if (this.flag3 > 0)
					{
						this.hitResult = 1;
						this.PlaySE(1308);
						local t_ = {};
						t_.count <- 15;
						t_.posY <- this.flag4;
						t_.rot <- (15.00000000 - this.flag3 * 4) * 0.01745329;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D, t_);
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Flash, {});
						this.flag3--;
					}
					else
					{
						this.SetMotion(3030, 4);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function SP_D_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();

	if (this.y > this.centerY)
	{
		this.SetMotion(3032, 0);
	}
	else
	{
		this.SetMotion(3031, 0);
	}

	this.count = 0;
	this.AjustCenterStop();
	this.flag3 = 3;
	this.flag4 = -960;

	if (this.va.x != 0.00000000)
	{
		this.flag5 = this.va.x > 0.00000000 ? 2.00000000 : -2.00000000;
	}
	else
	{
		this.flag5 = 0.00000000;
	}

	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		null,
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.VX_Brake(0.50000000, this.flag5);
				}

				this.CenterUpdate(0.25000000, 3.00000000);

				if (this.count % 5 == 0)
				{
					if (this.flag3 > 0)
					{
						this.hitResult = 1;
						this.PlaySE(1308);
						local t_ = {};
						t_.count <- 10;
						t_.posY <- this.flag4;
						t_.rot <- (15.00000000 - this.flag3 * 4) * 0.01745329;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D, t_);
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_Flash, {});
						this.flag3--;
					}
					else
					{
						this.SetMotion(3030, 4);
						this.stateLabel = function ()
						{
						};
					}
				}
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
			this.VX_Brake(0.50000000, this.flag5);
		}

		this.CenterUpdate(0.25000000, 3.00000000);
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16777216;
	this.count = 0;
	this.flag1 = 0;
	this.flag3 = this.Vector3();
	this.flag4 = 0.00000000;

	if (this.flag2)
	{
		this.flag5 = 45;
	}
	else
	{
		this.flag5 = 30;
	}

	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3040, 0);
		this.flag4 = 20 * 0.01745329;
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(1312);
				this.count = 0;
				this.centerStop = 3;
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(6);
					this.AddSpeed_Vec(0.75000000, 30 * 0.01745329, 17.50000000, this.direction);

					if (this.count >= 30)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(1.00000000);
						};
					}
				};
			},
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0.75000000, this.va.y * 0.50000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.25000000, null);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			}
		];
	}
	else if (this.y <= this.centerY)
	{
		this.SetMotion(3040, 0);
		this.flag4 = 20 * 0.01745329;
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(1312);
				this.count = 0;
				this.centerStop = 3;
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(6);
					this.AddSpeed_Vec(0.75000000, 30 * 0.01745329, 17.50000000, this.direction);

					if (this.count >= 10 && this.y > this.centerY)
					{
						this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(1.00000000);
						};
					}
				};
			},
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0.75000000, this.va.y * 0.50000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.25000000, null);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			}
		];
	}
	else
	{
		this.SetMotion(3041, 0);
		this.flag4 = -20 * 0.01745329;
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(1312);
				this.count = 0;
				this.centerStop = -3;
				this.stateLabel = function ()
				{
					this.HitCycleUpdate(6);
					this.AddSpeed_Vec(0.75000000, -30 * 0.01745329, 17.50000000, this.direction);

					if (this.count >= 10 && this.y < this.centerY)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(1.00000000);
						};
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.25000000, null);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			}
		];
	}

	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.flag1 = this.Vector3();
	this.count = 0;
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(3050, 0);
		this.flag1.x = 15.00000000;
		this.flag1.y = -10.00000000;
		this.SetSpeed_XY(this.va.x, this.va.y * 0.50000000);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				local t_ = {};
				t_.vx <- this.flag1.x;
				t_.vy <- this.flag1.y;
				t_.rf <- false;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F, t_);
			}
		];
		this.stateLabel = function ()
		{
			this.VX_Brake(0.75000000);
		};
	}
	else
	{
		this.SetMotion(3051, 0);
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
		this.subState = function ()
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(3051, 3);
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
				this.team.AddMP(-200, 120);
				local t_ = {};
				t_.vx <- this.flag1.x;
				t_.vy <- this.flag1.y;
				t_.rf <- false;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F, t_);
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.05000000);

					if (this.subState())
					{
						return;
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000);
				};
			}
		];
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.10000000, 2.00000000);
			this.VX_Brake(0.05000000);

			if (this.subState())
			{
				return;
			}
		};

		if (this.y > this.centerY)
		{
			this.flag1.x = 6.00000000;
			this.flag1.y = -14.50000000;
		}
		else
		{
			this.flag1.x = 6.00000000;
			this.flag1.y = -3.50000000;
		}
	}

	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.UseSpellCard(60, -this.team.sp_max);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(1363);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellA_Shot, t_);
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
					this.PlaySE(1352);
				}

				this.CenterUpdate(0.50000000, 1.00000000);
				this.VX_Brake(0.50000000);

				if (this.keyTake == 2)
				{
					if (this.count >= 150)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.02500000);
						};
					}
				}
			};
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
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0;
	this.flag2 = 0;
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.freeMap = true;
			this.UseSpellCard(60, -this.team.sp_max);
			this.SetSpeed_XY(-60.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.direction == 1.00000000 && this.x < ::battle.scroll_left - 240.00000000 || this.direction == -1.00000000 && this.x > ::battle.scroll_right + 240.00000000)
				{
					if (this.direction == 1.00000000)
					{
						this.Warp(::battle.scroll_left - 240.00000000, this.y);
					}
					else
					{
						this.Warp(::battle.scroll_right + 240.00000000, this.y);
					}

					this.SetSpeed_XY(0.00000000, 0.00000000);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellB_Shot, {});
			this.PlaySE(1359);
			this.SetSpeed_XY(80.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.hitResult && this.hitCount < 20)
				{
					this.flag2 = 10;
					this.SetSpeed_XY(1.00000000 * this.direction, 0.00000000);
					this.flag1++;

					if (this.flag1 >= 3)
					{
						this.flag1 = 0;
						this.HitReset();
					}
				}
				else
				{
					this.SetSpeed_XY(80.00000000 * this.direction, 0.00000000);
				}

				if (this.direction == 1.00000000 && this.x >= ::battle.scroll_right + 1280 || this.direction == -1.00000000 && this.x <= ::battle.scroll_left - 1280)
				{
					this.SetSpeed_XY(0.00000000 * this.direction, 0.00000000);
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
					return;
				}
			};
		},
		null,
		function ()
		{
			this.hitResult = 1;
			this.freeMap = false;
			this.direction = -this.direction;

			if (this.direction == 1.00000000)
			{
				this.Warp(::battle.scroll_left - 120.00000000, ::battle.scroll_top - 120);
			}
			else
			{
				this.Warp(::battle.scroll_right + 120.00000000, ::battle.scroll_top - 120);
			}

			this.SetSpeed_XY(10.00000000 * this.direction, -4.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.IsCenter(20.00000000) == 0)
				{
					this.SetMotion(this.motion, 6);
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

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();

	if (this.bitCore)
	{
		this.bitCore.func[0].call(this.bitCore);
	}

	this.SetMotion(4020, 0);
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.PlaySE(1356);
			this.count = 0;
			this.team.spell_enable_end = false;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.bitCore = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellC_ShotCore, t_).weakref();
			this.stateLabel = function ()
			{
				if (this.count >= 25)
				{
					this.SetMotion(4020, 4);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.00000000);
	};
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.atk_id = 134217728;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.func[0].call(this);
	});
	this.func = [
		function ()
		{
			if (this.hitResult & 1 && this.target.team.life > 0 && (this.target.team.master.IsDamage() && this.target.team.master.damageTarget == this || this.target.team.slave.IsDamage() && this.target.team.slave.damageTarget == this))
			{
				this.Spell_Climax_Hit(null);
				return;
			}
			else
			{
				this.EndtoFreeMove();
			}
		}
	];
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–ƒXƒeƒLI™\x2560‚\x2560‰\x2558Žq‚\x2502‚ñI–");
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
			this.PlaySE(1364);
		},
		function ()
		{
			this.SetSpeed_XY(8.00000000 * this.direction, -12.50000000);
			this.centerStop = -2;
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.VX_Brake(0.50000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.SetSpeed_XY(null, this.va.y * 0.50000000);
					this.centerStop = 1;
					this.SetMotion(4900, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		null,
		function ()
		{
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
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.target.DamageGrab_Common(308, 0, -this.direction);
	this.flag1 = this.Vector3();
	this.GetPoint(0, this.flag1);
	this.flag2 = this.Vector3();
	this.flag3 = this.Vector3();
	this.flag5 = {};
	this.flag5.zoom <- 2.00000000;
	this.target.freeMap = true;
	::battle.enableTimeUp = false;
	this.stateLabel = function ()
	{
		if (this.subState)
		{
			this.subState();
		}

		this.GetPoint(0, this.flag1);
		this.VX_Brake(this.va.x * this.direction <= -1.00000000 ? 0.50000000 : 0.00500000);
		::camera.SetTarget(this.x, this.y, this.flag5.zoom, false);
		this.flag5.zoom += 0.00500000;
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1272);
		},
		function ()
		{
			this.target.DamageGrab_Common.call(this.target, 305, 1, -this.direction);
			this.target.x = this.x + 30 * this.direction;
			this.target.y = ::battle.scroll_top - 1000;
			this.flag2.y = 10.00000000;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.flag2.y += 0.25000000;
				this.target.y += this.flag2.y;

				if (this.target.y > this.y - 50)
				{
					this.PlaySE(1273);
					::camera.shake_radius = 25.00000000;
					this.SetMotion(4901, 3);
					::camera.SetTarget(640, 360, 1.00000000, false);
					this.target.DrawActorPriority(300);
					this.target.x = this.x + 60 * this.direction;
					this.target.y = this.y;
					this.target.DamageGrab_Common(304, 0, -this.direction);
					this.target.freeMap = true;
					this.target.cameraPos.x = this.x;
					this.target.cameraPos.y = this.y;
					this.count = 0;
					this.flag4 = this.Vector3();
					this.flag3.x = this.target.x;
					this.flag3.y = this.target.y;
					this.flag4.x = 640 + 340 * this.direction - this.target.x;
					this.flag4.y = 360 - 320 - this.target.y;
					this.flag4.z = -200;
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
						this.target.sx = this.target.sy += 0.30000001;
						this.target.masterRed = this.target.masterGreen = this.target.masterBlue -= 0.02500000;
						this.target.x = this.flag3.x + this.flag4.x * ((this.target.sx - 1.00000000) * 0.25000000);
						this.target.y = this.flag3.y + this.flag4.y * ((this.target.sy - 1.00000000) * 0.25000000);
						this.target.rz -= 24.00000000 * 0.01745329;

						if (this.count >= 30)
						{
							this.Spell_Climax_Finish(null);
							return;
						}
					};
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
	this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 30);
	this.FadeOut(0.00000000, 0.00000000, 0.00000000, 20);
	this.stateLabel = function ()
	{
		if (this.count == 40)
		{
			this.PlaySE(1279);
			this.EraceBackGround(true);
			::camera.SetTarget(640, 360, 2.00000000, true);
			this.SetMotion(4902, 0);
			this.target.DamageGrab_Common.call(this.target, 308, 0, -this.direction);
			this.flag1 = this.SetFreeObject(0, 0, 1.00000000, this.Climax_Back, {}).weakref();
			this.FadeIn(0.00000000, 0.00000000, 0.00000000, 10);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.flag1.func[1].call(this.flag1);
				}

				if (this.count == 90)
				{
					this.flag1.func[2].call(this.flag1);
				}

				if (this.count == 160)
				{
					this.PlaySE(1276);
					this.KnockBackTarget(-this.direction);
					this.flag2 = this.SetFreeObject(640 + 190, 360 - 25, 1.00000000, this.Climax_CutInA, {}).weakref();
				}

				if (this.count == 185)
				{
					this.lastword.Deactivate();
				}

				if (this.count == 320)
				{
					this.Spell_Climax_FinishB(null);
				}
			};
		}
	};
}

function Spell_Climax_FinishB( t )
{
	this.LabelClear();
	this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
	this.EraceBackGround(false);
	this.flag1.func[0].call(this.flag1);
	this.flag2.func[0].call(this.flag2);
	this.HitReset();
	this.count = 0;
	this.masterAlpha = 1.00000000;
	this.autoCamera = true;
	this.freeMap = false;
	this.target.freeMap = false;
	this.target.masterRed = this.target.masterGreen = this.target.masterBlue = 1.00000000;
	this.target.sx = this.target.sy = 1.00000000;
	::camera.ResetTarget();
	this.ReleaseTargetActor(this.flag4);
	this.Warp(640 - 120.00000000 * this.direction, this.centerY - 128.00000000);
	this.target.Warp(640 + 120.00000000 * this.direction, this.centerY - 64.00000000);
	this.SetSpeed_XY(-2.00000000 * this.direction, 1.00000000);
	this.centerStop = -2;
	this.DrawActorPriority.call(this.target, 190);
	this.target.team.master.enableKO = true;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = true;
	}

	this.SetMotion(4902, 2);
	this.KnockBackTarget(-this.direction);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 45);
	this.centerStop = -2;
	this.SetSpeed_XY(-3.00000000 * this.direction, -5.00000000);
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			::battle.enableTimeUp = true;
			this.SetMotion(4902, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
}

