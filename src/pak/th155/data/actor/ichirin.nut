function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 4)
	{
		this.BeginBattle_Futo(null);
		return;
	}

	local r_ = this.rand() % 100;

	if (r_ <= 50)
	{
		this.BeginBattleB(null);
	}
	else
	{
		this.BeginBattleA(null);
	}
}

function Func_Win()
{
	local r = this.rand() % 2;

	switch(r)
	{
	case 0:
		local i = this.rand() % 100;

		if (i <= 90)
		{
			this.WinA(null);
		}
		else
		{
			this.WinB(null);
		}

		break;

	case 1:
		local i = this.rand() % 100;

		if (i <= 50)
		{
			this.WinC(null);
		}
		else
		{
			this.WinD(null);
		}

		break;

	default:
		this.WinA(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattleSkip()
{
	if (this.team.index == 0)
	{
		this.Warp(::battle.start_x[0], ::battle.start_y[0]);
	}
	else
	{
		this.Warp(::battle.start_x[1], ::battle.start_y[1]);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.Stand_Init(null);
}

function BeginBattleA( t )
{
	this.SetSpeed_XY(6.00000000 * this.direction, 4.00000000);
	this.LabelClear();
	this.Warp(this.x - 300 * this.direction, this.y - 200);
	this.flag1 = this.Vector3();
	this.flag1.x = ::battle.start_x[this.team.index];
	this.flag1.y = ::battle.start_y[this.team.index];
	this.SetMotion(9000, 0);
	this.count = 0;
	this.PlaySE(1475);
	this.stateLabel = function ()
	{
		if (this.count >= 30)
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
		}

		if (this.count >= 90)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
			};
		}
	};
	this.demoObject = [
		this.SetFreeObject(this.x, this.y, this.direction, this.BattleBeginObjectA, {}).weakref()
	];
	this.keyAction = [
		null,
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(0.00000000, -12.00000000);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((this.flag1.x - this.x) * 0.05000000, null);
				this.AddSpeed_XY(0.00000000, 0.50000000);

				if (this.y >= this.centerY)
				{
					this.centerStop = 2;
					this.SetSpeed_XY(0.00000000, this.va.y * 0.25000000);
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.EndtoFreeMove();
			this.CommonBegin();
		}
	];
}

function BeginBattleB( t )
{
	if (this.team.index == 0)
	{
		this.Warp(::battle.start_x[0], ::battle.start_y[0]);
	}
	else
	{
		this.Warp(::battle.start_x[1], ::battle.start_y[1]);
	}

	this.SetMotion(9001, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 120)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = null;
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1476);
		},
		function ()
		{
			this.EndtoFreeMove();
			this.CommonBegin();
		}
	];
}

function BeginBattle_Futo( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.DrawActorPriority();
	this.count = 0;
	this.direction *= -1.00000000;
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

				this.VX_Brake(0.25000000);

				if (this.va.x > 0.00000000 && this.x > ::battle.start_x[this.team.index] || this.va.x < 0 && this.x < ::battle.start_x[this.team.index])
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
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
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9003, 0);
	this.Warp(::battle.start_x[this.team.index] - 167 * this.direction, this.y + 8);
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
					this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
				}

				this.VX_Brake(0.75000000);
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
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.CommonWin();
		}
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			this.CommonWin();
		}
	};
}

function WinC( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9012, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(1477);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				local r_ = 30 + this.rand() % 45;
				t_.rot <- (i * 45 + this.rand() % 30) * 0.01745329;
				this.demoObject.append(this.SetFreeObject(this.point0_x + r_ * this.cos(t_.rot) * this.direction, this.point0_y + r_ * this.sin(t_.rot), this.direction, this.BattleBeginObjectB, t_).weakref());
			}
		},
		function ()
		{
			this.PlaySE(1478);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinD( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9013, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(1477);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				local r_ = 30 + this.rand() % 45;
				t_.rot <- (i * 45 + this.rand() % 30) * 0.01745329;
				this.demoObject.append(this.SetFreeObject(this.point0_x + r_ * this.cos(t_.rot) * this.direction, this.point0_y + r_ * this.sin(t_.rot), this.direction, this.BattleBeginObjectB, t_).weakref());
			}
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(1479);
			this.stateLabel = function ()
			{
				if (::battle.state == 32 && this.count % 37 == 0)
				{
					this.PlaySE(1479);
				}

				if (this.count == 180)
				{
					this.CommonWin();
				}
			};
		},
		function ()
		{
			this.PlaySE(1479);
			this.SetMotion(9013, 2);
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
		if (this.count == 120)
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
	this.SetSpeed_XY(5.00000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5.00000000 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 13.00000000;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -13.00000000;
	t_.v2 <- -4.00000000;
	t_.v3 <- 13.00000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- -13.00000000;
	t_.v2 <- -4.00000000;
	t_.v3 <- 13.00000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 13.00000000;
	t_.v2 <- 4.00000000;
	t_.v3 <- 13.00000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 5.00000000;
	t_.back <- -5.00000000;
	t_.front_rev <- 4.00000000;
	t_.back_rev <- -4.00000000;
	t_.v <- 13.00000000;
	t_.v2 <- 4.00000000;
	t_.v3 <- 13.00000000;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 5.50000000;
	this.flag5.vy = 4.00000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -5.50000000;
	this.flag5.vy = 4.00000000;
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
	t_.speed <- 6.00000000;
	t_.addSpeed <- 0.15000001;
	t_.maxSpeed <- 11.00000000;
	t_.wait <- 180;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 12;
	t_.wait <- 120;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 11.00000000;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

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

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -7.00000000;
	t_.g <- 0.10000000;
	t_.minWait <- 16;
	t_.wait <- 60;
	t_.addSpeed <- 0.10000000;
	t_.maxSpeed <- 11.00000000;
	this.DashBack_Air_Common(t_);
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
			this.PlaySE(1500);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
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
			this.PlaySE(1501);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.Atk_Mid_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 4;
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
		this.VX_Brake(0.40000001);
	};

	if (this.unzan)
	{
		this.SetMotion(1100, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				this.PlaySE(1503);
			}
		];
	}
	else
	{
		this.SetMotion(1101, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				this.PlaySE(1511);
			}
		];
	}

	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;

	if (this.unzan)
	{
		this.SetMotion(1110, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1502);
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
			},
			this.EndtoFreeMove
		];
	}
	else
	{
		this.SetMotion(1111, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1510);
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
			},
			this.EndtoFreeMove
		];
	}

	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Init( t )
{
	this.LabelClear();
	this.HitReset();

	if (this.unzan)
	{
		this.SetMotion(1700, 0);
		this.keyAction = [
			function ()
			{
				this.AddSpeed_XY(6.00000000 * this.direction, 0.00000000);
				this.PlaySE(1503);
			},
			function ()
			{
				this.HitTargetReset();
			}
		];
	}
	else
	{
		this.SetMotion(1701, 0);
		this.keyAction = [
			function ()
			{
				this.AddSpeed_XY(6.00000000 * this.direction, 0.00000000);
				this.PlaySE(1511);
			}
		];
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(0.40000001);
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.Atk_HighUnder_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 128;
	this.flag1 = false;
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.40000001);
	};

	if (this.unzan)
	{
		this.SetMotion(1210, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, null);
			},
			function ()
			{
				this.PlaySE(1504);
			},
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000);
				};
			}
		];
	}
	else
	{
		this.SetMotion(1211, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, null);
			},
			function ()
			{
				this.PlaySE(1513);
			},
			null,
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000);
				};
			}
		];
	}

	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.unzan)
	{
		this.SetMotion(1215, 0);
		this.keyAction = [
			null,
			function ()
			{
				this.PlaySE(1504);
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
	else
	{
		this.SetMotion(1216, 0);
		this.keyAction = [
			null,
			function ()
			{
				this.PlaySE(1513);
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
				this.SetMotion(this.motion, 4);
				this.stateLabel = function ()
				{
					this.VX_Brake(0.50000000);
				};
			}
		};
	}

	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.Atk_HighUpper_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 64;
	this.flag1 = false;
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};

	if (this.unzan)
	{
		this.SetMotion(1220, 0);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1505);
			}
		];
	}
	else
	{
		this.SetMotion(1221, 0);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1514);
			}
		];
	}

	return true;
}

function Atk_HighUpperCharge_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.stateLabel = this.Atk_HighUpper;

	if (this.unzan)
	{
		this.SetMotion(1222, 0);
		this.SetChargeAura(null);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1505);
				this.SetChargeAuraB(null);
			}
		];
	}
	else
	{
		this.SetMotion(1223, 0);
		this.SetChargeAura(null);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1514);
				this.SetChargeAuraB(null);
			}
		];
	}

	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;

	if (this.unzan)
	{
		this.SetMotion(1225, 0);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1505);
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
	}
	else
	{
		this.SetMotion(1226, 0);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
			},
			function ()
			{
				this.PlaySE(1514);
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
	}

	this.stateLabel = function ()
	{
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

function Atk_HighUpper_AirB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;

	if (this.va.x * this.direction >= 0.00000000)
	{
		this.flag2 = 4.00000000 * this.direction;
	}
	else
	{
		this.flag2 = -4.00000000 * this.direction;
	}

	if (this.unzan)
	{
		this.SetMotion(1226, 0);
		this.keyAction = [
			function ()
			{
				this.centerStop = -2;
				this.SetSpeed_XY(this.flag2, -6.00000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.25000000, 3.00000000);
				};
			},
			function ()
			{
				this.PlaySE(1505);
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
	}
	else
	{
		this.SetMotion(1226, 0);
		this.keyAction = [
			function ()
			{
				this.centerStop = -2;
				this.SetSpeed_XY(this.flag2, -6.00000000);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.25000000, 3.00000000);
				};
			},
			function ()
			{
				this.PlaySE(1505);
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
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(1.00000000);
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 32;
	this.flag1 = false;
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

	if (this.unzan)
	{
		this.SetMotion(1230, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1506);
				this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				local HF_ = function ( t )
				{
					this.SetMotion(0, 0);
					this.priority = 400;
					this.sx = 2;
					this.sy = 2;
					this.SetUpdateFunction(function ()
					{
						this.vx = 0;
						return true;
					});
					this.SetEndMotionCallbackFunction(function ()
					{
						this.Release();
					});
				};
				this.PlaySE(1507);
				this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			}
		];
	}
	else
	{
		this.SetMotion(1231, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1512);
				this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			}
		];
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Atk_HighFrontCharge_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};

	if (this.unzan)
	{
		this.SetMotion(1232, 0);
		this.SetChargeAura(null);
		this.keyAction = [
			function ()
			{
				this.SetChargeAuraB(null);
				this.PlaySE(1506);
				this.SetSpeed_XY(22.50000000 * this.direction, 0.00000000);
			},
			function ()
			{
				local HF_ = function ( t )
				{
					this.SetMotion(0, 0);
					this.sx = 2;
					this.sy = 2;
					this.SetUpdateFunction(function ()
					{
						this.vx = 0;
						return true;
					});
					this.SetEndMotionCallbackFunction(function ()
					{
						this.Release();
					});
				};
				this.PlaySE(1507);
				this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			}
		];
	}
	else
	{
		this.SetMotion(1233, 0);
		this.SetChargeAura(null);
		this.keyAction = [
			function ()
			{
				this.SetChargeAuraB(null);
				this.PlaySE(1512);
				this.SetSpeed_XY(17.50000000 * this.direction, 0.00000000);
			}
		];
	}

	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.Atk_HighFront_Air_Init(t);

	if (this.unzan)
	{
		this.SetMotion(1760, 0);
	}
	else
	{
		this.SetMotion(1761, 0);
	}

	this.atk_id = 16;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.GetFront();
			this.SetMotion(this.motion - 650, 4);
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

	if (this.unzan)
	{
		this.SetMotion(1234, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1506);
				this.SetSpeed_XY(8.50000000 * this.direction, null);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.30000001, 6.00000000);
					this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.50000000 : 0.00000000);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 4);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
					}
				};
			},
			function ()
			{
				this.PlaySE(1507);
				this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.50000000 : 0.00000000);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 4);
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
						this.VX_Brake(0.50000000);
					}
				};
			}
		];
	}
	else
	{
		this.SetMotion(1235, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1512);
				this.SetSpeed_XY(8.50000000 * this.direction, null);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.30000001, 6.00000000);
					this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.50000000 : 0.00000000);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 4);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
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
					this.VX_Brake(this.va.x * this.direction >= 2.00000000 ? 0.50000000 : 0.00000000);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(this.motion, 4);
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
						this.VX_Brake(0.50000000);
					}
				};
			}
		];
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0.30000001, 6.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
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
	this.stateLabel = function ()
	{
		if (this.keyTake <= 1)
		{
			this.VX_Brake(0.10000000);
		}

		if (this.keyTake >= 2)
		{
			this.VX_Brake(0.50000000);
		}
	};

	if (this.unzan)
	{
		this.SetMotion(1300, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(10.00000000 * this.direction, null);
				this.PlaySE(1508);
			},
			function ()
			{
				this.HitTargetReset();
				this.PlaySE(1517);
			}
		];
	}
	else
	{
		this.SetMotion(1301, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(10.00000000 * this.direction, null);
				this.PlaySE(1515);
			},
			function ()
			{
				this.HitTargetReset();
				this.PlaySE(1518);
			}
		];
	}

	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.stateLabel = function ()
	{
		if (this.keyTake >= 1)
		{
			this.VX_Brake(0.20000000);

			if (this.keyTake == 1)
			{
				this.CenterUpdate(0.10000000, null);
			}
		}
	};

	if (this.unzan)
	{
		this.SetMotion(1310, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0.50000000, 0.00000000);
				this.PlaySE(1509);
			}
		];
	}
	else
	{
		this.SetMotion(1311, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0.50000000, 0.00000000);
				this.PlaySE(1516);
			}
		];
	}

	this.SetSpeed_XY(7.50000000 * this.direction, 0.00000000);
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
	this.flag1.stateLabel();
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
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1420);
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(302, 0, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor2, {}, this.weakref()).weakref();
		},
		function ()
		{
			this.flag1.func[0].call(this.flag1);
			this.target.DamageGrab_Common(304, 0, -this.direction);
			this.target.centerStop = -2;
			this.target.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 5.00000000);
			};
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.PlaySE(1419);
			this.hitStopTime = 20;
			::camera.shake_radius = 3.00000000;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
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
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		},
		function ()
		{
		},
		function ()
		{
		}
	];
	return true;
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
	this.keyAction = [
		null,
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1540);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-5 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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
		this.VX_Brake(0.40000001);
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
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1540);
			this.team.AddMP(-200, 90);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-5 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
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
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1540);
			this.team.AddMP(-200, 90);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-45 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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
		this.CenterUpdate(0.10000000, null);
		this.VX_Brake(0.40000001);
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1540);
			this.team.AddMP(-200, 60);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-45 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1540);
			this.team.AddMP(-200, 90);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (40 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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
		this.CenterUpdate(0.10000000, null);
		this.VX_Brake(0.40000001);
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1540);
			this.team.AddMP(-200, 90);

			for( local i = -3; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (40 + i * 10) * 0.01745329;

				if (i == 0)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t_);
				}
				else
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal_Mini, t_);
				}
			}
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
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1540);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
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
		this.CenterUpdate(0.10000000, null);
		this.VX_Brake(0.50000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1540);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
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
		this.CenterUpdate(0.10000000, null);
		this.VX_Brake(0.20000000);
	};
	return true;
}

function Shot_Charge_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.Shot_Charge_Common(t);
	this.flag2.vx <- 4.40000010;
	this.flag2.vy <- 2.75000000;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	if (!this.unzan)
	{
		this.EndtoFreeMove();
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = 0;
	this.flag4 = t.charge;
	this.keyAction = [
		null,
		function ()
		{
			this.hitResult = 1;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.PlaySE(1555);
			local t_ = {};
			t_.scale <- 1.00000000;

			if (this.flag4)
			{
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_FullCharge_Core, {});
			}
			else
			{
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
			}
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

function Shot_Charge_Air_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.Shot_Charge_Init(t);
}

function Shot_Burrage_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 3.00000000;
	this.flag2.vy <- 3.00000000;
	this.flag3 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Barrage_Unzan, {});
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func[0].call(this.flag3);
			this.flag3 = null;
		}
	};
	this.subState = function ()
	{
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2500, 0);
	this.hitResult = 1;
	this.flag1 = t.k;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.k <- 0;

			if (!this.hassyaku)
			{
				this.hassyaku = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Okult_Option, t_).weakref();
			}
		},
		null,
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

function Okult_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.team.AddMP(-200, 60);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.unzan = false;
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			local pos_ = this.Vector3();
			this.GetPoint(0, pos_);
			this.SetShot(pos_.x, pos_.y, this.direction, this.Shot_Okult_Front, {});
		},
		null,
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

function SP_A_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.atk_id = 1048576;
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3000, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.AjustCenterStop();
	this.flag1 = 200.00000000;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1550);
			::camera.shake_radius = 7.00000000;
			this.SetShot(this.x + this.flag1 * this.direction, 0.00000000, this.direction, this.SPShot_A, {});
			this.unzan = false;
			this.unzanReload = 60;
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, 1.00000000);
		this.VX_Brake(0.50000000);
	};
	return true;
}

function SP_B_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 10;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1551);
			this.team.AddMP(-200, 120);
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.SP_B_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.SetMotion(3010, 0);
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.00000000);
	};
	return true;
}

function SP_B_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3015, 0);
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.target.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.target.Warp(this.point0_x, this.point0_y);

		if (this.count > this.flag1)
		{
			this.SetMotion(this.motion, 1);
			this.keyAction[0].call(this);
			this.stateLabel = function ()
			{
				this.target.Warp(this.point0_x, this.point0_y);
			};
			return;
		}
		else
		{
		}
	};
	this.keyAction = [
		function ()
		{
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.target.cameraPos.y = this.y;
			this.target.Warp(this.point0_x, this.point0_y);
		},
		function ()
		{
			this.PlaySE(1552);
			this.SetMotion(this.motion, 2);
			this.target.Warp(this.point0_x, this.point0_y);
			this.stateLabel = null;
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			this.HitReset();
			this.hitResult = 1;
		}
	];
}

function SP_B_Air_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = 10;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1551);
			this.team.AddMP(-200, 120);
			this.HitReset();
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.SP_B_Air_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.SetMotion(3011, 0);
	return true;
}

function SP_B_Air_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3016, 0);
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.target.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.target.Warp(this.point0_x, this.point0_y);

		if (this.count > this.flag1)
		{
			this.SetMotion(this.motion, 1);
			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.stateLabel = function ()
			{
				this.target.Warp(this.point0_x, this.point0_y);
			};
			return;
		}
		else
		{
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.target.cameraPos.x = this.x;
			this.target.cameraPos.y = this.y;
			this.target.Warp(this.point0_x, this.point0_y);
		},
		function ()
		{
			this.PlaySE(1552);
			this.SetMotion(this.motion, 3);
			this.target.Warp(this.point0_x, this.point0_y);
			this.stateLabel = null;
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			this.HitReset();
			this.hitResult = 1;
		}
	];
}

function SP_B_Avoided( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3013, 0);
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.target.autoCamera = true;
	this.target.hitStopTime = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function SP_C_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.team.AddMP(-200, 120);
	this.SetMotion(3020, 0);
	this.SetSpeed_XY(this.va.x * 0.85000002, this.va.y * 0.10000000);
	this.flag1 = 0;
	this.SetMotion(3021, 0);
	this.keyAction = [
		function ()
		{
			this.unzan = false;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, {});
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.01000000, 2.00000000);

		if (this.centerStop * this.centerStop <= 1)
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

function SP_C_Finish( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3023, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1555);
			this.SetSpeed_XY(this.va.x, 0.00000000);
			local t_ = {};
			t_.motion <- 6021;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C_Spark, t_);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(1.50000000);
			};
		},
		null,
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
		this.VX_Brake(0.50000000);
	};
	return true;
}

function SP_D_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.flag2 = 0;
	this.AjustCenterStop();
	this.SetMotion(3030, 0);
	this.subState = function ()
	{
		this.CenterUpdate(0.25000000, 3.00000000);
		this.VX_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_D, {});
			this.stateLabel = function ()
			{
				this.subState();

				if (this.input.b2 == 1 && ::battle.state == 8)
				{
					this.flag2 = 15;
				}

				this.flag2--;

				if (this.count >= 90 || this.count >= 20 && this.flag2 <= 0)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.subState();
						this.VX_Brake(0.50000000);
					};
				}
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
		this.subState();
	};
	return true;
}

function SP_E_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.SetMotion(3040, 0);
	this.count = 0;
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.flag1 = 120 * 0.01745329;
	}
	else if (this.y <= this.centerY)
	{
		this.flag1 = 120 * 0.01745329;
	}
	else
	{
		this.flag1 = -120 * 0.01745329;
	}

	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.unzan = false;
			this.count = 0;
			local t_ = {};
			t_.rot <- this.flag1;
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_Unzan, t_);
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake <= 3)
		{
			this.CenterUpdate(0.05000000, null);
		}

		this.VX_Brake(0.50000000);
	};
	return true;
}

function SP_F_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.team.AddMP(-200, 120);

	if (this.unzan)
	{
		this.SetMotion(3050, 0);
	}
	else
	{
		this.SetMotion(3051, 0);
	}

	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 40 * 0.01745329;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);

	if (this.unzan)
	{
		this.keyAction = [
			function ()
			{
				this.count = 0;
				local t_ = {};
				t_.rot <- this.flag1;
				this.PlaySE(1557);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F, t_);
			},
			function ()
			{
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
			}
		];
	}
	else
	{
		this.keyAction = [
			function ()
			{
				this.count = 0;
				local t_ = {};
				t_.rot <- this.flag1;
				this.PlaySE(1558);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_F2, t_);
			},
			function ()
			{
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
			}
		];
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0.05000000, null);

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

function SP_G_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 16777216;
	this.team.AddMP(-200, 120);
	this.count = 0;
	this.SetMotion(3062, 0);
	this.flag1 = 20;
	this.SetSpeed_XY(13.00000000 * this.direction, 0.00000000);
	this.AjustCenterStop();
	this.PlaySE(1559);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.count > this.flag1 || this.targetDist * this.direction > 0.00000000 && this.abs(this.targetDist) <= 300)
				{
					this.SetMotion(this.motion, 2);
					this.PlaySE(1560);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.10000000, null);
						this.VX_Brake(0.20000000);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		}
	];
	return true;
}

function SP_RingFlight_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 33554432;
	this.team.AddMP(-200, 120);
	this.count = 0;
	this.SetMotion(3070, 0);
	this.va.x = this.Math_MinMax(this.va.x, -6.00000000, 6.00000000);
	this.SetSpeed_XY(this.va.x, this.va.y);
	this.centerStop = -3;
	this.hitCount = 0;
	this.grazeCount = 0;
	this.flag1 = [
		null,
		null,
		null
	];
	this.lavelClearEvent = function ()
	{
		if (this.flag1[0])
		{
			this.flag1[0].func();
		}

		if (this.flag1[1])
		{
			this.flag1[1].func();
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(1546);
			this.flag1[0] = this.SetShot(this.x - 40 * this.direction, this.y + 10, this.direction, this.SPShot_RingFlight_A, {}).weakref();
			this.flag1[1] = this.SetShot(this.x + 100 * this.direction, this.y + 7, this.direction, this.SPShot_RingFlight_B, {}).weakref();
		},
		function ()
		{
			this.lavelClearEvent();
			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.75000000);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.34999999, null);

		if (this.hitCount <= 3 && this.grazeCount <= 3)
		{
			this.HitCycleUpdate(3);
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			this.lavelClearEvent();
			this.lavelClearEvent = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
	return true;
}

function Spell_A_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				if (this.count % 8 == 1)
				{
					this.PlaySE(1488);
				}

				if (this.count % 4 == 1 && this.flag1 <= 30)
				{
					this.hitResult = 1;
					local t_ = {};
					t_.rot <- 0.01745329 * (80 - this.rand() % 160);
					t_.vec <- 5 + this.rand() % 45;
					local d_ = this.direction;

					if (this.flag1 % 2 == 1)
					{
						d_ = -this.direction;
					}

					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x + 128 * d_ + t_.vec * 3.00000000 * this.cos(t_.rot) * d_, this.y + t_.vec * 3.00000000 * this.sin(t_.rot), d_, this.SpellShot_B_Fist, t_);
					this.flag1++;
				}

				if (this.flag1 >= 31)
				{
					this.SetMotion(this.motion, 3);
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

function Spell_B_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4040, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			this.PlaySE(1576);
			this.armor = 7;
			this.stateLabel = function ()
			{
				local x_ = 0.00000000;
				local y_ = 0.00000000;

				if (this.input.x)
				{
					if (this.input.x < 0)
					{
						x_ = -0.10000000;
					}
					else
					{
						x_ = 0.10000000;
					}
				}

				if (this.input.y)
				{
					if (this.input.y < 0)
					{
						y_ = -0.05000000;
					}
					else
					{
						y_ = 0.05000000;
					}
				}
				else
				{
					this.CenterUpdate(0.15000001, 2.00000000);
				}

				if (this.y < this.centerY)
				{
					this.centerStop = -2;
				}

				if (this.y > this.centerY)
				{
					this.centerStop = 2;
				}

				this.AddSpeed_XY(x_, y_);

				if (this.count % 12 == 1)
				{
					this.PlaySE(1575);
				}

				if (this.hitResult)
				{
					this.flag1++;

					if (this.flag1 >= 12)
					{
						this.flag1 = 0;
						this.HitReset();
					}
				}

				if (this.count >= 120)
				{
					this.HitReset();
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0.30000001);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.30000001);
			};
		}
	];
	return true;
}

function Spell_C_Init( t )
{
	if (!this.unzan)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 67108864;
	this.SetMotion(4050, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(1480);
			this.SetSpeed_Vec(20.00000000, -5 * 0.01745329, this.direction);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.50000000);
			};
		},
		function ()
		{
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(640 - 800 * this.direction, this.y, this.direction, this.SpellShot_F, t_);
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.50000000);

				if (this.count >= 45)
				{
					this.HitReset();
					this.SetMotion(this.motion, 5);
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

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.flag2 = null;
	this.flag3 = null;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "ÅñÇQÇUÇTÉZÉìÉ`Ç\x2560ñÇêlå\x2557ÇÈÅIÅñ");
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(1520);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag3 = this.SetShotStencil(640, 360, this.direction, this.Climax_BackShot, t_).weakref();
			this.stateLabel = function ()
			{
				if (this.flag3 && this.flag3.hitResult & 1)
				{
					this.Spell_Climax_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = null;
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0.00000000, 0.00000000);
	};
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.count = 0;
	this.SetMotion(4901, 0);
	this.target.DamageGrab_Common(301, 0, this.target.direction);
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.FadeOut(0.00000000, 0.00000000, 0.00000000, 20);
			this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 30);
		}

		if (this.count == 60)
		{
			this.SetMotion(4901, 1);
			this.target.DamageGrab_Common(308, 0, this.target.direction);
		}

		if (this.count == 75)
		{
			this.Spell_Climax_Cut(null);
		}
	};
}

function Spell_Climax_Cut( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 1);
	this.FadeIn(0.00000000, 0.00000000, 0.00000000, 1);
	this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 1);
	this.EraceBackGround();
	::battle.enableTimeUp = false;
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.flag3 = null;
	this.flag5 = {};
	this.flag5.back <- null;
	this.flag5.cut <- null;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag5.back = this.SetFreeObject(640 + (190 - 640) * this.direction, 610, this.direction, this.Climax_Back, t_).weakref();
	this.flag5.cut = this.SetFreeObject(640 - 640 * this.direction, 0, this.direction, this.Climax_Cut, t_).weakref();
	this.stateLabel = function ()
	{
		if (this.count == 40)
		{
			this.PlaySE(1522);
			this.flag5.cut.func[1].call(this.flag5.cut);
		}

		if (this.count == 100)
		{
			this.PlaySE(1523);
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.cut.func[2].call(this.flag5.cut);
		}

		if (this.count == 190)
		{
			this.flag5.back.func[0].call(this.flag5.back);
			this.flag5.cut.func[0].call(this.flag5.cut);
			this.Spell_Climax_InitB(null);
			return;
		}
	};
}

function Spell_Climax_InitB( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4902, 0);
	this.KnockBackTarget(this.target.direction);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.PlaySE(1524);
	this.flag1 = null;
	this.flag2 = null;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag3 = this.SetFreeObject(640 + (190 - 640) * this.direction, 610, this.direction, this.Climax_BackB, {}).weakref();
	this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_).weakref();
	this.flag1.SetParent(this, this.flag1.x - this.x, this.flag1.y - this.y);
	this.flag2 = this.SetShot(this.x + 50 * this.direction, this.y - 75, this.direction, this.Climax_Option, {}).weakref();
	this.flag2.SetParent(this, this.flag2.x - this.x, this.flag2.y - this.y);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count < 180)
		{
			this.HitCycleUpdate(16);
		}

		if (this.count == 180)
		{
			this.EraceBackGround(false);

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			if (this.flag2 && this.flag2.func[1])
			{
				this.flag2.func[1].call(this.flag2);
			}

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}
		}

		if (this.count == 210)
		{
			::battle.enableTimeUp = true;
			this.lastword.Deactivate();
			this.SetMotion(4900, 5);
			this.stateLabel = null;
		}
	};
	return true;
}

