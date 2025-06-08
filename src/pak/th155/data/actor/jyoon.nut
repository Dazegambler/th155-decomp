function Team_FreeChangeAction()
{
	if (!this.shion_ban)
	{
		this.shion.Shion_Wait(true);
	}
}

function Func_BeginBattle()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.BeginBattleA(null);
		break;

	case 1:
		this.BeginBattleA(null);
		break;
	}
}

function Func_Win()
{
	local r_ = 3;

	switch(r_)
	{
	case 0:
	case 1:
	case 2:
		this.WinD(null);
		break;

	case 3:
		this.WinC(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function Wait_Outside()
{
	this.LabelClear();
	this.SetMotion(0, 0);
	this.Warp(640 - 640 * this.direction, this.centerY);
	this.isVisible = false;
	this.shion.Shion_OutSide();
	this.stateLabel = function ()
	{
	};
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
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
			this.PlaySE(4678);
			::camera.shake_radius = 3.00000000;
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

function BeginBattleA( t )
{
	this.LabelClear();
	this.SetMotion(0, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.CommonBegin();
			this.stateLabel = this.Stand;
		}
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
			this.PlaySE(1000);
			::camera.shake_radius = 3.00000000;
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

function WinA( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.shion.Shion_Win_Paper(null);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
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
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1093);
			::camera.shake_radius = 3.00000000;
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function WinC( t )
{
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.LabelClear();
	this.SetMotion(9012, 0);
	this.count = 0;
	this.shion.Shion_Win_Taxi(null);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.demoObject = [
				this.SetFreeObject(this.x + 1400 * this.direction, this.centerY, -this.direction, this.WinC_Object_Taxi, {}).weakref()
			];
			this.stateLabel = function ()
			{
				if (this.count == 50)
				{
					this.shion.func[0].call(this.shion);
				}

				if (this.count == 65)
				{
					this.shion.func[1].call(this.shion);
				}

				if (this.count == 120)
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
	this.SetMotion(9012, 0);
	this.count = 0;
	this.shion.Shion_Win_TaxiB(null);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.demoObject = [
				this.SetFreeObject(this.x + 1610 * this.direction, this.centerY, -this.direction, this.WinC_Object_Taxi, {}).weakref()
			];
			this.stateLabel = function ()
			{
				if (this.count == 50)
				{
					this.shion.func[0].call(this.shion);
				}

				if (this.count == 65)
				{
					this.shion.func[1].call(this.shion);
				}

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
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count <= 180 && this.count % 17 == 7)
				{
					this.PlaySE(4665);
				}

				if (this.count == 90)
				{
					this.CommonLose();
				}
			};
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
	this.SetSpeed_XY(5.50000000 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5.50000000 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 20.00000000;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -20.00000000;
	t_.v2 <- -6.00000000;
	t_.v3 <- 20.00000000;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- -20.00000000;
	t_.v2 <- -6.00000000;
	t_.v3 <- 20.00000000;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 20.00000000;
	t_.v2 <- 6.00000000;
	t_.v3 <- 20.00000000;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9.00000000;
	t_.front <- 6.00000000;
	t_.back <- -6.00000000;
	t_.front_rev <- 4.50000000;
	t_.back_rev <- -4.50000000;
	t_.v <- 20.00000000;
	t_.v2 <- 6.00000000;
	t_.v3 <- 20.00000000;
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

function GC_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 2.00000000;
	t_.front <- 2.00000000;
	t_.back <- -2.00000000;
	t_.front_rev <- 2.00000000;
	t_.back_rev <- -2.00000000;
	this.GC_SlideUp_Common(t_);
}

function GC_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 2.00000000;
	t_.front <- 2.00000000;
	t_.back <- -2.00000000;
	t_.front_rev <- 2.00000000;
	t_.back_rev <- -2.00000000;
	this.GC_SlideFall_Common(t_);
}

function DashFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.flag1 = 0;
	this.SetMotion(40, 0);
	this.stateLabel = function ()
	{
		this.VX_Brake(2.00000000);
	};
	this.func = function ()
	{
		this.SetMotion(40, 0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.40000001);
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4619);
			this.SetSpeed_XY(20.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.50000000);
			};
			this.lavelClearEvent = function ()
			{
				this.SetSpeed_XY(null, 0.00000000);
			};
		},
		function ()
		{
			this.hitResult = 1;
			this.SetSpeed_XY(6.00000000 * this.direction, this.va.y * 0.25000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);

				if (this.input.x * this.direction > 0)
				{
					if (this.count == 13 && this.flag1 < 3)
					{
						this.flag1++;
						this.func();
						return;
					}
				}
			};
		}
	];
}

function DashFront_Air_Init( t )
{
	this.LabelClear();
	this.flag1 = 0;
	this.flag2 = true;
	this.SetMotion(42, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.dashCount++;
	this.func = function ()
	{
		this.SetMotion(42, 3);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.40000001);
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4619);
			this.SetSpeed_XY(16.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.input.x * this.direction <= 0)
				{
					this.flag2 = false;
				}

				this.CenterUpdate(0.40000001, null);
				this.VX_Brake(1.50000000, 5.00000000 * this.direction);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.input.x * this.direction <= 0)
				{
					this.flag2 = false;
				}

				this.VX_Brake(1.50000000, 5.00000000 * this.direction);
				this.CenterUpdate(0.50000000, null);
			};
		},
		function ()
		{
			if (!this.flag2 || this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(42, 4);
				this.stateLabel = function ()
				{
					if (this.input.x * this.direction <= 0)
					{
						this.flag2 = false;
					}

					this.CenterUpdate(0.50000000, null);
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					if (this.input.x * this.direction <= 0)
					{
						this.flag2 = false;
					}

					this.VX_Brake(0.40000001, 5.00000000 * this.direction);
					this.CenterUpdate(0.50000000, null);
				};
			}
		},
		function ()
		{
			this.SetMotion(42, 1);
			this.PlaySE(4619);
			this.SetSpeed_XY(16.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.input.x * this.direction <= 0)
				{
					this.flag2 = false;
				}

				this.VX_Brake(1.50000000, 5.00000000 * this.direction);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.input.x * this.direction <= 0)
		{
			this.flag2 = false;
		}
	};
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4619);
			this.SetSpeed_XY(-17.50000000 * this.direction, 0.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001, -5.00000000 * this.direction);

				if (this.count >= 7)
				{
					this.SetMotion(41, 3);
					this.SetSpeed_XY(this.va.x * 0.50000000, 0.00000000);
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
		this.VX_Brake(0.75000000);
	};
}

function DashBack_Air_Init( t )
{
	this.LabelClear();
	this.flag1 = 0;
	this.SetMotion(43, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.dashCount++;
	this.func = function ()
	{
		this.SetMotion(this.motion, 3);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.40000001);
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4619);
			this.SetSpeed_XY(-16.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.40000001, null);
				this.VX_Brake(1.50000000, -5.00000000 * this.direction);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.50000000, -5.00000000 * this.direction);
				this.CenterUpdate(0.50000000, null);
			};
		},
		function ()
		{
			if (this.input.x * this.direction >= 0 || this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(this.motion, 4);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
				};
			}
			else
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.40000001, -5.00000000 * this.direction);
					this.CenterUpdate(0.50000000, null);
				};
			}
		},
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.PlaySE(4619);
			this.SetSpeed_XY(-16.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.50000000, -5.00000000 * this.direction);
			};
		}
	];
}

function StandUp_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.count = 0;

	if (t == 0)
	{
		this.SetMotion(37, 0);
		this.centerStop = -2;
		this.SetSpeed_XY(0.00000000, -5.00000000);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.50000000);
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
				this.GetFront();
			}
		];
	}
	else if (t * this.direction >= 1.00000000)
	{
		this.PlaySE(4619);
		this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
		this.stateLabel = function ()
		{
		};
		this.SetMotion(35, 0);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				this.GetFront();
			}
		];
	}
	else
	{
		this.SetMotion(36, 0);
		this.PlaySE(4619);
		this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
		this.stateLabel = function ()
		{
		};
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
			},
			function ()
			{
				this.GetFront();
			}
		];
	}
}

function DamageAnimalB_Init( t )
{
	this.LabelClear();
	this.flag1 = this.y;

	if (this.shion)
	{
		this.shion.Shion_DamageVanish();
	}

	this.centerStop = -3;
	this.direction = t.direction;

	switch(t.atkRank)
	{
	case 1:
		this.SetSpeed_XY(-4.50000000 * this.direction, -4.00000000 - this.rand() % 4);
		break;

	case 2:
		this.SetSpeed_XY(-4.50000000 * this.direction, -8.00000000 - this.rand() % 4);
		break;

	default:
		this.SetSpeed_XY(-4.50000000 * this.direction, -3.50000000 - this.rand() % 2);
		break;
	}

	this.SetMotion(289, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.va.y > 0.00000000 && this.y + this.va.y >= this.flag1 || this.count >= 90)
		{
			if (this.debuff_animal.time <= 0)
			{
				this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
				this.EndtoFreeMove();
			}
			else
			{
				this.StandAnimal_Init(null);
				this.SetSpeed_XY(null, this.va.y * 0.50000000);
			}
		}
	};
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4600);
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
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4600);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.SetSpeed_XY(0.00000000, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(20.00000000 * this.direction, null);
			this.PlaySE(4602);
			this.stateLabel = function ()
			{
				this.VX_Brake(8.00000000);
			};
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
	this.SetSpeed_XY(this.va.x * 0.20000000, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(20.00000000 * this.direction, null);
			this.PlaySE(4602);
			this.stateLabel = function ()
			{
				this.VX_Brake(8.00000000);
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
	this.keyAction = [
		function ()
		{
			this.PlaySE(4617);
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(1110, 2);
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
	this.SetSpeed_XY(8.00000000 * this.direction, -8.50000000);
	this.centerStop = -3;
	this.keyAction = [
		function ()
		{
			this.centerStop = 2;
			this.SetSpeed_XY(8.00000000 * this.direction, 12.00000000);
			this.PlaySE(4609);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);
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
		this.VX_Brake(0.25000000);
		this.AddSpeed_XY(null, 0.50000000);
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
			this.centerStop = 2;
			this.SetSpeed_XY(8.00000000 * this.direction, 12.00000000);
			this.PlaySE(4609);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);
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
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.centerStop <= -2 && this.y < this.centerY)
	{
		this.stateLabel = function ()
		{
		};
		this.SetMotion(1211, 0);
		this.SetSpeed_XY(9.00000000 * this.direction, -7.50000000);
		this.centerStop = -2;
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.keyAction = [
			function ()
			{
				this.centerStop = 2;
				this.SetSpeed_XY(9.00000000 * this.direction, 18.00000000);
				this.PlaySE(4609);
				this.stateLabel = function ()
				{
					if (this.y > this.centerY)
					{
						this.centerStop = 1;
						this.SetSpeed_XY(2.00000000 * this.direction, 4.00000000);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.25000000);
						};
						this.SetMotion(this.motion, 3);
					}
				};
			}
		];
	}
	else
	{
		this.SetMotion(1212, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(4609);
			},
			null,
			null,
			this.EndtoFreeMove,
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.25000000);

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
				this.stateLabel = function ()
				{
					this.VX_Brake(1.00000000);
				};
				this.SetMotion(this.motion, 4);
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
	this.keyAction = [
		null,
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(4606);
			this.centerStop = -2;
			this.SetSpeed_XY(0.00000000, -25.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 2.50000000 : 0.25000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 1.25000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
				{
					this.SetMotion(1220, 5);
					this.SetSpeed_XY(0.00000000, 1.00000000);
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
		this.VX_Brake(1.50000000);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.count = 0;
	this.SetMotion(1720, 0);
	this.keyAction = [
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(4606);
			this.centerStop = -2;
			this.SetSpeed_XY(15.00000000 * this.direction, -15.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000, 1.50000000 * this.direction);
				this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 1.50000000 : 1.00000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y < 0.00000000 ? 1.50000000 : 1.00000000);

				if (this.va.y > 0.00000000 && this.y > this.centerY)
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
		this.VX_Brake(1.50000000);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4606);
		},
		null,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1700, 0);
	this.atk_id = 32;
	this.flag1 = false;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
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
	this.SetSpeed_XY(-6.00000000 * this.direction, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4611);
			this.SetSpeed_XY(15.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
		},
		function ()
		{
			this.SetSpeed_XY(5.00000000 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1740, 0);
	this.atk_id = 16;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4611);
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
		function ()
		{
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.GetFront();
			this.SetMotion(1110, 2);
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
	this.func = function ()
	{
		this.SetMotion(1231, 3);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.50000000);
		};
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4611);
		},
		function ()
		{
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.func();
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
	this.SetSpeed_XY(20.00000000 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(4613);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000, 2.00000000 * this.direction);
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
		this.VX_Brake(2.00000000, 1.00000000 * this.direction);
	};
	return true;
}

function Atk_LowDash2_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1301, 0);
	this.SetSpeed_XY(20.00000000 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.PlaySE(4615);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000, 2.00000000 * this.direction);
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
		this.VX_Brake(2.00000000, 2.00000000 * this.direction);
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);
	this.SetSpeed_XY(10.00000000 * this.direction, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	this.keyAction = [
		function ()
		{
			this.Warp(this.x, this.centerY);
			this.centerStop = -2;
			this.SetSpeed_XY(14.00000000 * this.direction, -5.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000, 5.00000000 * this.direction);
				this.AddSpeed_XY(null, this.va.y < -2.00000000 ? 0.50000000 : 0.10000000);
			};
		},
		function ()
		{
			this.PlaySE(4620);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.10000000);
				this.VX_Brake(0.50000000, 5.00000000 * this.direction);

				if (this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x * 0.50000000, 3.00000000);
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
				this.AddSpeed_XY(null, 0.50000000);
				this.VX_Brake(0.50000000, 5.00000000 * this.direction);

				if (this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x * 0.50000000, 3.00000000);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	];
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
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.initTable.pare.y);
	};
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
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.y);
	this.stateLabel = function ()
	{
		if (this.Atk_Grab_Hit_Update())
		{
			this.Warp(this.x - 25 * this.direction, this.y);
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
	this.HitReset();
	this.SetMotion(1802, 1);
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.target.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag2 = 8;
	this.stateLabel = function ()
	{
		this.target.Warp(this.point0_x, this.y);
	};
	this.keyAction = [
		function ()
		{
			this.target.DamageGrab_Common(300, 0, -this.direction);
		},
		function ()
		{
			this.PlaySE(4659);
			this.flag2--;
			::camera.shake_radius = 2.00000000;
			this.target.DamageGrab_Common(301, 0, -this.direction);
			this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_HitSmashB, {});
			this.KnockBackTarget(-this.direction);
			this.SetFreeObject(this.target.x, this.target.y, this.direction, this.Grab_Gold, {});
		},
		function ()
		{
			if (this.flag2 <= 0)
			{
				this.SetMotion(1802, 3);
			}
			else
			{
				this.SetMotion(1802, 1);
			}
		},
		function ()
		{
			this.PlaySE(4660);
			this.hitStopTime = 20;
			::camera.shake_radius = 3.00000000;
			this.KnockBackTarget(-this.direction);
			this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_HitSmashC, {});
			::battle.enableTimeUp = true;
			this.target.autoCamera = true;
			this.flag1.func[0].call(this.flag1);
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
			this.stateLabel = function ()
			{
			};
		},
		null,
		this.EndtoFreeMove
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
			this.PlaySE(4622);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(-30 * 0.01745329);

			for( local i = -3; i <= 3; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 9.00000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
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

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4622);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(-30 * 0.01745329);

			for( local i = -3; i <= 3; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 9.00000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			if (this.flag2 == -1.00000000)
			{
				this.SetSpeed_XY(-6.00000000 * this.direction, -3.00000000);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.25000000);
				};
			}
			else
			{
				this.SetSpeed_XY(-6.00000000 * this.direction, 3.00000000);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, -0.25000000);
				};
			}
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

		if (this.centerStop * this.centerStop == 0)
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

function Shot_Normal_Upper_Init( t )
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
			this.PlaySE(4622);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(-80 * 0.01745329);

			for( local i = -8; i <= -2; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 8.00000000 - i * 0.25000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
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
	this.flag1 = 0;

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4622);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(-80 * 0.01745329);

			for( local i = -8; i <= -2; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 8.00000000 - i * 0.25000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			if (this.flag2 == -1.00000000)
			{
				this.SetSpeed_XY(-6.00000000 * this.direction, -3.00000000);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.25000000);
				};
			}
			else
			{
				this.SetSpeed_XY(-4.00000000 * this.direction, 6.00000000);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, -0.40000001);
				};
			}
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

		if (this.centerStop * this.centerStop == 0)
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

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2002, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4622);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(20 * 0.01745329);

			for( local i = 2; i <= 8; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 8.00000000 + i * 0.25000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			this.SetSpeed_XY(-9.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
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
	this.flag1 = 0;

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4622);
			this.centerStop = -3;
			this.SetSpeed_XY(-4.00000000 * this.direction, -6.50000000);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(20 * 0.01745329);

			for( local i = 2; i <= 8; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 8.00000000 + i * 0.25000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}

			if (this.flag2 == -1.00000000)
			{
				this.SetSpeed_XY(-4.00000000 * this.direction, -6.00000000);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.40000001);
				};
			}
			else
			{
				this.SetSpeed_XY(-6.00000000 * this.direction, 3.00000000);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, -0.25000000);
				};
			}
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

		if (this.centerStop * this.centerStop == 0)
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

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2010, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.50000000, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4624);
			this.team.AddMP(-200, 90);
			this.hitResult = 1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2011, 0);
	this.count = 0;
	this.flag1 = 4;
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(4624);
			this.team.AddMP(-200, 90);
			this.hitResult = 1;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
			this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.20000000, 2.00000000);
				this.VX_Brake(0.50000000, -1.00000000 * this.direction);
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
					this.VX_Brake(0.20000000);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
			return true;
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.20000000, 2.00000000);
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5.00000000;
	this.flag2.vy <- 3.00000000;

	if (this.shion)
	{
		this.Shion_ChargeShot_Wait.call(this.shion, null);
	}

	this.subState = function ()
	{
	};
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2020, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.flag1 = null;
	this.flag2 = t.ky;
	this.flag3 = false;
	this.flag4 = t.charge;
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			local r_ = this.atan2(this.target.y - this.point0_y, (this.target.x - this.point0_x) * this.direction);
			r_ = this.Math_MinMax(r_, -15 * 0.01745329, 15 * 0.01745329);
			local pos_ = this.Vector3();
			pos_.x = 100;
			pos_.RotateByRadian(r_);
			local t_ = {};
			t_.rot <- r_;
			this.shion.Warp(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y);
			this.Shion_ChargeShot_Fire.call(this.shion, t_);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 1.50000000);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0.15000001);
				}
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
	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6.50000000;
	this.flag2.vy <- 4.00000000;
	this.flag2.rot <- 0.00000000;

	if (this.shion.motion == 5003)
	{
		this.shion.Shion_Burrage_Behind(t);
	}
	else
	{
		this.shion.Shion_Burrage(t);
	}

	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
		}
	};
	return true;
}

function Okult_Init( t )
{
	if (this.centerStop * this.centerStop >= 4)
	{
		this.Okult_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(this.va.x * 0.25000000, this.va.y * 0.25000000);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.shion.Shion_Occult(null);
			this.PlaySE(4630);
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);

				if (!this.shion || !(this.shion.motion == 5300 && this.shion.keyTake <= 1))
				{
					this.SetMotion(2501, 3);
					this.stateLabel = function ()
					{
					};
					return;
				}

				if (this.count >= 30)
				{
					if (this.input.b3 > 0)
					{
						this.Occult_ChangeShion(null);
						return;
					}

					if (this.input.b4 > 0)
					{
						if (this.input.y <= -1)
						{
							this.hitBackFlag = 0.00000000;
							this.C_SlideUp_Init(null);
							return true;
						}

						if (this.input.y >= 1)
						{
							this.hitBackFlag = 0.00000000;
							this.C_SlideFall_Init(null);
							return true;
						}

						if (this.input.x * this.direction < 0 && this.input.y == 0)
						{
							this.DashBack_Init(null);
							return true;
						}
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

function Okult_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.shion.Shion_Occult(null);
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);

				if (!this.shion || !(this.shion.motion == 5300 && this.shion.keyTake <= 1))
				{
					this.SetMotion(2501, 3);
					this.stateLabel = function ()
					{
					};
					return;
				}

				if (this.count >= 30)
				{
					if (this.input.b3 > 0)
					{
						this.Occult_ChangeShion(null);
						return;
					}

					if (this.input.b4 > 0)
					{
						if (this.input.y <= -1)
						{
							this.hitBackFlag = 0.00000000;
							this.C_SlideUp_Init(null);
							return true;
						}

						if (this.input.y >= 1)
						{
							this.hitBackFlag = 0.00000000;
							this.C_SlideFall_Init(null);
							return true;
						}

						if (this.dashCount <= 1)
						{
							if (this.input.x * this.direction > 0 && this.input.y == 0)
							{
								this.DashFront_Air_Init(null);
								return true;
							}

							if (this.input.x * this.direction < 0 && this.input.y == 0)
							{
								this.DashBack_Air_Init(null);
								return true;
							}
						}
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

function Occult_ChangeShion( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(2502, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.PlaySE(903);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
			local pos_ = this.Vector3();
			pos_.x = this.x;
			pos_.y = this.y;
			local d_ = this.direction;
			this.direction = this.shion.direction;
			this.shion.direction = d_;
			this.Warp(this.shion.x, this.shion.y);
			this.shion.Shion_OccultChange(pos_);

			if (this.abs(this.y - this.centerY) <= 15)
			{
				this.centerStop = 1;
			}
			else if (this.y < this.centerY)
			{
				this.centerStop = -2;
			}
			else
			{
				this.centerStop = 2;
			}
		}
	];
	return true;
}

function SP_A_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_A_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(3000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4633);
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.bag = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.bag)
				{
					this.bag.func[2].call(this.bag);
				}

				this.bag = null;
			};
			this.stateLabel = function ()
			{
				if (this.bag == null)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
					return;
				}

				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
			this.lavelClearEvent = null;
			this.bag = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(this.baseGravity, null);
	};
	return true;
}

function SP_A_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(3001, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4633);
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.bag = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.bag)
				{
					this.bag.func[2].call(this.bag);
				}

				this.bag = null;
			};
			this.stateLabel = function ()
			{
				if (this.bag == null)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
					};
					return;
				}

				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
			this.lavelClearEvent = null;
			this.bag = null;
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

function SP_A_Throw( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.AjustCenterStop();
	this.SetMotion(3002, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4633);
			this.hitResult = 1;
			this.bag = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, {}).weakref();
			this.lavelClearEvent = function ()
			{
				this.bag = null;
			};
			this.stateLabel = function ()
			{
				if (this.bag == null)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
					return;
				}

				this.VX_Brake(0.50000000);
			};
		},
		null,
		function ()
		{
			this.lavelClearEvent = null;
			this.bag = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
}

function SP_A_Dash( t )
{
	this.lavelClearEvent = null;
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(2.00000000 * this.direction, 0.00000000);
	};
	this.PlaySE(4635);
	this.AjustCenterStop();
	this.SetMotion(3003, 0);
	this.keyAction = [
		function ()
		{
			this.Warp(this.bag.x - 50 * this.direction, this.y);
			this.hitResult = 1;

			if (this.bag)
			{
				this.ReleaseActor.call(this.bag);
				this.bag = null;
			}

			this.centerStop = 0;
			this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, null);
				this.VX_Brake(0.75000000);
			};
		},
		function ()
		{
		}
	];
}

function SP_B_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_B_Air_Init(t);
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(3010, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4636);
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.hitResult = 1;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.lavelClearEvent();
			this.lavelClearEvent = null;
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_B_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3011, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4636);
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.hitResult = 1;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
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

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0.20000000, this.va.y * 0.20000000);
	this.flag1 = null;
	this.SetMotion(3020, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(4640);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SPShot_C, {}).weakref();
		},
		function ()
		{
			this.hitResult = 1;
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
	this.SetMotion(3030, 0);
	this.count = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(4643);
			this.count = 0;
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
			this.centerStop = -2;
			this.flag1 = this.SetShot(this.x, this.y + 0, this.direction, this.SPShot_D_Foot, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(10);

				if (this.count == 45)
				{
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x, 0.00000000);
					this.lavelClearEvent();
					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
						this.VX_Brake(0.30000001);
					};
				}

				this.VX_Brake(0.50000000, 6.00000000 * this.direction);

				if (this.y > this.centerY - 50)
				{
					this.AddSpeed_XY(0.00000000, -0.80000001, null, -12.50000000);
				}
				else
				{
					this.VY_Brake(0.80000001);
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetSpeed_XY(0.00000000, null);
					this.LabelClear();
					this.stateLabel = null;
					this.SetMotion(10, 5);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000);
	};
	return true;
}

function SP_D_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitCount = 0;
	this.SetMotion(3030, 0);
	this.count = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(4643);
			this.count = 0;
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
			this.centerStop = -2;
			this.flag1 = this.SetShot(this.x, this.y + 0, this.direction, this.SPShot_D_Foot, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(10);

				if (this.count == 45)
				{
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x, 0.00000000);
					this.lavelClearEvent();
					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
						this.VX_Brake(0.30000001);
					};
				}

				this.VX_Brake(0.50000000, 6.00000000 * this.direction);

				if (this.y > this.centerY - 50)
				{
					this.AddSpeed_XY(0.00000000, -0.80000001, null, -12.50000000);
				}
				else
				{
					this.VY_Brake(0.80000001);
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetSpeed_XY(0.00000000, null);
					this.LabelClear();
					this.stateLabel = null;
					this.SetMotion(10, 5);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(this.baseGravity, this.baseSlideSpeed);
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3040, 0);
	this.count = 0;
	this.flag1 = null;
	this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			local t_ = {};
			t_.rot <- 90 * 0.01745329;
			t_.rotSpeed <- -0.08726646;
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_).weakref();
			this.flag1.SetParent(this, 0, 0);
			this.PlaySE(4645);
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
				else
				{
					this.CenterUpdate(0.10000000, 1.50000000);
				}

				if (this.flag1 == null)
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
		if (this.centerStop == 0)
		{
			this.VX_Brake(0.50000000);
		}
		else
		{
			this.CenterUpdate(0.10000000, 1.50000000);
		}
	};
	return true;
}

function Change_Attack( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3120, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 4)
				{
					if ((this.target.x - this.x) * this.direction <= 60 || this.count >= 15)
					{
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.25000000);
						};
					}
				}
			};
		}
	];
}

function Change_Shot_Rush( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = 4;
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);

				if (this.count % 5 == 1)
				{
					if (this.flag1 <= 0)
					{
						this.count = 0;
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0.50000000);
						};
						return;
					}
					else
					{
						this.hitResult = 1;
						this.PlaySE(1070);
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, {});
						this.flag1--;
					}
				}
			};
		},
		null,
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
}

function Change_Shot_Wide( t )
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
			this.PlaySE(1071);
			local pos_ = this.Vector3();
			pos_.x = 60;
			pos_.RotateByRadian(-30 * 0.01745329);

			for( local i = -3; i <= 3; i++ )
			{
				local t = {};
				t.rot <- i * 10 * 0.01745329;
				t.v <- 9.00000000;
				this.SetShot(this.point0_x + pos_.x * this.direction, this.point0_y + pos_.y, this.direction, this.Shot_Normal, t);
				pos_.RotateByRadian(10 * 0.01745329);
			}
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.50000000);
	};
}

function Spell_A_Init( t )
{
	this.Spell_B_Init(t);
	return true;
	this.LabelClear();
	this.HitReset();

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(4000, 0);
	}
	else
	{
		this.SetMotion(4001, 0);
	}

	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(4654);
			this.SetSpeed_XY(25.00000000 * this.direction, 0.00000000);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.SetMotion(this.motion, 4);
					this.keyAction[3].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.HitReset();
			this.SetSpeed_XY(10.00000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.Spell_A_Hit();
					return;
				}

				this.VX_Brake(0.25000000);
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
	return true;
}

function Spell_A_Grab_Actor( t )
{
	this.EnableTimeStop(false);
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.owner.target.team.slave.Warp(this.owner.point0_x - (this.owner.target.team.slave.point0_x - this.owner.target.team.slave.x), this.owner.point0_y - (this.owner.target.team.slave.point0_y - this.owner.target.team.slave.y));
	};
}

function Spell_A_Hit()
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4002, 0);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Spell_A_Grab_Actor, {}).weakref();
	this.PlaySE(4655);

	if (this.target == this.target.team.slave)
	{
		this.target.team.master.Warp(this.target.team.slave.x, this.target.team.slave.y);
		this.ResetSpeed();
		this.target.Team_Change_Common();
		this.team.current.ResetSpeed();
	}

	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.target.team.master.DamageGrab_Common(301, 1, -this.direction);
	this.target.team.slave.DamageGrab_Common(304, 1, -this.direction);
	this.SetSpeed_XY(30.00000000 * this.direction, 0.00000000);
	::battle.SetSlow(180);
	this.count = 0;
	::battle.enableTimeUp = false;
	::camera.shake_radius = 6.00000000;
	this.target.team.slave.Warp(this.point0_x - (this.target.team.slave.point0_x - this.target.team.slave.x), this.point0_y - (this.target.team.slave.point0_y - this.target.team.slave.y));
	this.keyAction = [
		null,
		null,
		function ()
		{
			::battle.enableTimeUp = true;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(2.00000000, 2.00000000 * this.direction);

		if (this.count == 90)
		{
			this.PlaySE(4656);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.target.team.slave_ban = 480;
			this.target.team.slave.Team_Bench_In();
			this.hitResult = 1;
			::battle.SetSlow(0);
			::camera.shake_radius = 15.00000000;
			this.SetMotion(4002, 2);
			this.KnockBackTarget(-this.direction);
			this.SetSpeed_XY(25.00000000 * this.direction, 0.00000000);
			this.direction = -this.direction;
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000, -1.50000000 * this.direction);
			};
		}
	};
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.PlaySE(4675);
		},
		function ()
		{
			this.hitResult = 1;
			local t_ = {};
			t_.count <- 120;
			t_.priority <- 210;
			this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
			this.PlaySE(4657);
			::camera.shake_radius = 20.00000000;
			local t_ = {};
			t_.rot <- 0.00000000;
			t_.tagRot <- -45 * 0.01745329;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_);
			this.SetSpeed_XY(-3.00000000 * this.direction, -9.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, this.va.y < -1.00000000 ? 0.50000000 : 0.02500000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.25000000, null);
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
	this.Spell_B_Init(t);
	return true;
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4021, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = 0;
	this.flag2 = null;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4681);
			this.UseSpellCard(60, -this.team.sp_max);
			this.count = 0;
			this.SetSpeed_XY(-2.00000000 * this.direction, -15.00000000);
			this.centerStop = -2;
			this.flag2 = this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.SpellC_DanceTable, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 30);
			};
			this.stateLabel = function ()
			{
				if (this.y < this.centerY)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 1.00000000);

						if (this.va.y > 0.00000000 && this.y >= this.centerY)
						{
							this.Warp(this.x, this.centerY);
							this.SetSpeed_XY(0.00000000, 0.00000000);
							this.SetMotion(this.motion, 5);
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		},
		function ()
		{
		},
		null,
		null,
		null,
		function ()
		{
			this.Spell_C_Dance(t);
			return;
		}
	];
	return true;
}

function Spell_C_Dance( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4020, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.flag1 = 0;
	this.flag3 = [
		null,
		null,
		null,
		null
	];
	this.stateLabel = function ()
	{
		if (this.count >= 90)
		{
			this.SetMotion(this.motion, 2);
			this.keyAction[1].call(this);
			return;
		}
	};
	this.subState = function ()
	{
		this.flag1++;

		if (this.flag1 == 0)
		{
			foreach( a in this.flag3 )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}

			this.FadeIn(0.00000000, 0.00000000, 0.00000000, 1);
		}

		if (this.flag1 >= 20)
		{
			this.flag1 = -10;
			this.FadeOut(0.00000000, 0.00000000, 0.00000000, 1);
		}
	};
	this.keyAction = [
		function ()
		{
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 30);
			};
		},
		function ()
		{
			this.PlaySE(4661);
			this.BackFadeOut(0.00000000, 0.00000000, 0.00000000, 1);
			this.SetFreeObject(640, 820, 1.00000000, this.SpellShot_C, {});
			this.count = 0;
			this.flag1 = 20;
			this.flag3[0] = this.SetShot(this.x + 100, ::battle.scroll_top - 100, 1.00000000, this.SpellShot_C_Spot, {}).weakref();
			this.flag3[1] = this.SetShot(this.x - 100, ::battle.scroll_top - 100, -1.00000000, this.SpellShot_C_Spot, {}).weakref();
			this.flag3[2] = this.SetShot(this.x - 50, ::battle.scroll_top, 1.00000000, this.SpellShot_C_Spot, {}).weakref();
			this.flag3[3] = this.SetShot(this.x + 50, ::battle.scroll_top, -1.00000000, this.SpellShot_C_Spot, {}).weakref();
			this.subState();
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count == 150)
				{
					this.SetMotion(this.motion, 3);
					this.FadeOut(0.00000000, 0.00000000, 0.00000000, 1);
					this.flag1 = 0;
					this.stateLabel = function ()
					{
						this.flag1++;

						if (this.flag1 == 10)
						{
							foreach( a in this.flag3 )
							{
								if (a)
								{
									a.func[1].call(a);
								}
							}

							this.FadeIn(0.00000000, 0.00000000, 0.00000000, 1);
						}

						if (this.flag1 == 30)
						{
							this.FadeOut(0.00000000, 0.00000000, 0.00000000, 1);
						}

						if (this.flag1 == 40)
						{
							foreach( a in this.flag3 )
							{
								if (a)
								{
									a.func[0].call(a);
								}
							}

							this.FadeIn(0.00000000, 0.00000000, 0.00000000, 1);
							this.SetMotion(this.motion, 5);
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
			this.flag1 = 0;
			this.FadeOut(0.00000000, 0.00000000, 0.00000000, 1);

			foreach( a in this.flag3 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			for( local i = 40; i <= 1280; i = i + 150 )
			{
				this.SetShot(i, 640, this.direction, this.SpellShot_C_Steam, {});
			}

			this.stateLabel = function ()
			{
				this.flag1++;

				if (this.flag1 == 10)
				{
					this.PlaySE(4663);
					this.FadeIn(0.00000000, 0.00000000, 0.00000000, 1);
					::camera.shake_radius = 10.00000000;
					this.hitResult = 1;
				}
			};
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func[0].call(this.flag2);
			}

			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 30);
			this.lavelClearEvent = null;
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	return false;
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "「80\'s�\x2560エクストーショナー」");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();
			};
		},
		function ()
		{
			this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					this.Spell_Climax_Hit(null);
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
	return true;
}

function Climax_Grab_Actor( t )
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
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.ResetSpeed();
	::battle.enableTimeUp = false;
	this.SetMotion(4901, 0);
	::camera.SetTarget(this.x + 50 * this.direction, this.y - 20, 2.00000000, false);
	this.PlaySE(4647);
	this.shion.Shion_Climax_Wait(null);
	this.flag5 = {};
	this.flag5.zoom <- 2.00000000;
	this.flag5.paper <- null;
	this.flag5.binbou <- null;
	this.flag5.grab_actor <- this.SetShot(this.x, this.y, this.direction, this.Climax_Grab_Actor, {}).weakref();
	this.target.DamageGrab_Common(301, 2, this.target.direction);
	this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.y);
	this.DrawActorPriority(this.drawPriority);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.flag5.grab_actor.stateLabel = function ()
			{
				this.owner.target.Warp(this.owner.point0_x, this.owner.y);
			};
			this.stateLabel = function ()
			{
				this.target.DamageGrab_Common(301, 2, this.target.direction);
			};
			this.target.Warp(this.point0_x, this.y);
		},
		function ()
		{
			this.shion.Shion_Climax_MoneyCatch_A(null);
			this.stateLabel = function ()
			{
			};
			this.PlaySE(4648);
			this.target.DamageGrab_Common(301, 0, this.target.direction);
			::camera.SetTarget(this.x + 160 * this.direction, this.y - 20, 2.50000000, false);
			::camera.Shake(5.00000000);
			this.SetEffect(this.point0_x, this.y, this.direction, this.EF_HitSmashC, {});
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 8 == 4)
				{
					local i = 4;

					while (i > 0)
					{
						i--;
						this.SetFreeObject(this.point0_x, this.y, this.direction, this.Climax_Coin, {});
					}

					this.PlaySE(4649);
					::camera.Shake(2.00000000);
					this.target.DamageGrab_Common(301, 0, this.target.direction);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
				}

				if (this.count == 90)
				{
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 17)
						{
							this.PlaySE(4648);
							local i = 6;

							while (i > 0)
							{
								i--;
								this.SetFreeObject(this.point0_x, this.y, this.direction, this.Climax_Coin, {});
							}

							this.target.DamageGrab_Common(301, 0, this.target.direction);
							this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
							::camera.Shake(10.00000000);
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.shion.func[0].call(this.shion);
			::camera.SetTarget(this.x + 25 * this.direction, this.y, 2.00000000, false);
			this.count = 0;
			this.target.DamageGrab_Common(302, 1, this.target.direction);
			this.flag5.grab_actor.stateLabel = function ()
			{
				this.owner.target.Warp(this.owner.point0_x - (this.owner.target.point0_x - this.owner.target.x), this.owner.point0_y - (this.owner.target.point0_y - this.owner.target.y));
			};
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.shion.Shion_Climax_MoneyCatch_B(null);
			this.stateLabel = function ()
			{
				if (this.count % 8 == 2)
				{
					this.PlaySE(4651);

					for( local i = 3; i > 0;  )
					{
						i--;
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_CoinB, {});
					}
				}

				if (this.count % 8 == 6)
				{
				}

				if (this.count == 150)
				{
					this.target.enableStandUp = false;
					this.SetMotion(this.motion, 7);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.point0_y - (this.target.point0_y - this.target.y));
					};
				}
			};
		},
		null,
		function ()
		{
			this.shion.func[0].call(this.shion);
			this.flag5.grab_actor.ReleaseActor();
			this.flag5.grab_actor = null;
			this.target.damageTarget = this.weakref();
			this.count = 0;
			::camera.SetTarget(this.x + 120 * this.direction, this.y - 20, 2.00000000, false);
			this.target.Warp(this.point0_x, this.y - 30);
			this.KnockBackTarget(-this.direction);
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.SetMotion(this.motion, 11);
					this.stateLabel = function ()
					{
						::camera.Shake(1.00000000);
					};
				}
			};
			return;
			this.stateLabel = function ()
			{
				if (this.count == 12)
				{
					this.SetEffect(this.x + 150 * this.direction, this.y, this.direction, this.EF_HitSmashA, {});
					this.flag5.binbou = this.SetFreeObject(this.target.x, this.y, -this.direction, this.Climax_Binbou, {}).weakref();
				}

				if (this.count == 50)
				{
					::camera.SetTarget(this.x + 180 * this.direction, this.y - 20, 2.50000000, false);
					this.flag5.binbofunc[1].call(this.flag5.binbou);
					this.SetMotion(this.motion, 9);
					this.count = 0;
					this.stateLabel = function ()
					{
						::camera.Shake(1.00000000);

						if (this.count == 120)
						{
							this.SetMotion(this.motion, 11);
							this.stateLabel = function ()
							{
								::camera.Shake(1.00000000);
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
			this.PlaySE(4652);
			this.flag5.paper = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Climax_Paper, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 25)
				{
				}

				if (this.count == 20)
				{
					this.Spell_Climax_SceneA(null);
					return;
				}
			};
		}
	];
}

function Spell_Climax_SceneA( t )
{
	this.LabelReset();
	this.count = 0;
	this.flag5.cut_paper <- this.SetFreeObject(640, 360, 1.00000000, this.Climax_CutPaper, {}).weakref();
	this.flag5.cut_back <- this.SetFreeObject(640, 360, 1.00000000, this.Climax_CutBack, {}).weakref();
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.flag5.paper.func[0].call(this.flag5.paper);
			this.SetMotion(4902, 0);
			this.target.DamageGrab_Common(308, 0, this.target.direction);
		}

		if (this.count == 70)
		{
			this.PlaySE(4676);
			this.flag5.cut_paper.func[1].call(this.flag5.cut_paper);
			this.flag5.cut_face <- this.SetFreeObject(800, 460, 1.00000000, this.Climax_CutFace, {}).weakref();
		}

		if (this.count == 180)
		{
			if (this.flag5.cut_face)
			{
				this.flag5.cut_face.func[0].call(this.flag5.cut_face);
			}

			if (this.flag5.cut_paper)
			{
				this.flag5.cut_face.func[0].call(this.flag5.cut_paper);
			}

			if (this.flag5.cut_back)
			{
				this.flag5.cut_face.func[0].call(this.flag5.cut_back);
			}

			this.Spell_Climax_Finish(null);
		}
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.SetMotion(4902, 1);
	this.FadeIn(0.00000000, 0.00000000, 0.00000000, 2);
	this.EraceBackGround(false);
	this.Warp(this.x, this.centerY);
	this.centerStop = 0;
	this.target.DamageGrab_Common(301, 2, -this.direction);
	this.target.Warp(this.x + 200 * this.direction, this.target.centerY);
	::camera.ResetTarget();
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.SetSpeed_XY(15.00000000 * this.direction, 0.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 7)
		{
			this.PlaySE(4653);
			this.hitStopTime = 60;
			::camera.Shake(20.00000000);
			this.target.damageTarget = null;
			this.target.enableStandUp = true;
			this.KnockBackTarget(-this.direction);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
			};
			this.shion.Shion_Wait(null);
			this.shion.Warp(this.x - 640, this.y);
		}
	};
}

function Climax_FinishB( t )
{
	this.BackFadeIn(0.00000000, 0.00000000, 0.00000000, 0);
	this.EraceBackGround(false);
	this.flag1.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.LabelReset();
	this.HitReset();
	this.count = 0;
	this.masterAlpha = 1.00000000;
	this.autoCamera = true;
	this.freeMap = false;
	::camera.ResetTarget();
	this.ReleaseTargetActor(this.flag4);
	this.Warp(640 - 120.00000000 * this.direction, this.centerY - 128.00000000);
	this.target.Warp(640 + 120.00000000 * this.direction, this.centerY - 64.00000000);
	this.SetSpeed_XY(-2.00000000 * this.direction, 1.00000000);
	this.centerStop = -2;
	this.target.team.master.enableKO = true;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = true;
	}

	this.SetMotion(4901, 7);
	this.KnockBackTarget(-this.direction);
	this.FadeIn(1.00000000, 1.00000000, 1.00000000, 45);
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(null, 0.01000000);
	};
}

