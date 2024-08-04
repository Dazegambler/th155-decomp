function Shion_Init( t )
{
	if (this.owner.shion_ban)
	{
		this.Shion_SlaveWait(true);
	}
	else if (this.owner == this.team.slave)
	{
		this.Shion_SlaveWait(true);
	}
	else
	{
		this.Shion_Wait(null);
	}
}

function Shion_OutSide()
{
	this.SetMotion(5009, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
	};
}

function Shion_StageIn()
{
	this.SetMotion(5000, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.PlaySE(4626);
	this.Warp(this.owner.x - 160 * this.direction, this.y - 130);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
	this.flag1 = this.Vector3();
	this.stateLabel = function ()
	{
		if (::battle.state == 8)
		{
			this.Shion_SlaveWait(false);
			return;
		}

		this.flag1.x = this.owner.x - 60 * this.direction;
		this.flag1.y = this.owner.y - 30;
		this.SetSpeed_XY((this.flag1.x - this.x) * 0,01500000.0, (this.flag1.y - this.y) * 0,01500000.0);
	};
}

function Shion_StageIn_Effect( t )
{
	this.SetMotion(5004, 0);
	this.keyAction = this.ReleaseActor;
}

function Shion_Wait( t = false )
{
	this.SetMotion(5000, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.rz = 0,00000000.0;

	if (t)
	{
		this.direction = this.owner.direction;
		this.Warp(this.owner.x - 75 * this.direction, this.owner.y - 50);
		this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
	}

	this.owner.shion_act = false;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.SetMotion(5000, 0);
	});
	this.DrawActorPriority(180);
	this.flag1 = this.Vector3();
	this.keyAction = null;
	this.func = [
		function ()
		{
			this.subState = function ()
			{
				this.SetSpeed_XY(null, (this.flag1.y - this.y) * 0,01500000.0);

				if (this.abs(this.flag1.x) <= 20 || this.x < 30 && this.va.x < 0 || this.x > 1250 && this.va.x > 0)
				{
					this.func[1].call(this);
					return;
				}
				else if (this.flag1.x * this.direction > 0)
				{
					if (this.motion != 5001)
					{
						this.SetMotion(5001, 0);
					}

					this.AddSpeed_XY(0,50000000.0 * this.direction, 0,00000000.0, 4,00000000.0 * this.direction, null);
				}
				else
				{
					if (this.motion != 5002)
					{
						this.SetMotion(5002, 0);
					}

					this.AddSpeed_XY(-0,50000000.0 * this.direction, 0,00000000.0, -4,00000000.0 * this.direction, null);
				}
			};
		},
		function ()
		{
			if (this.motion != 5000)
			{
				this.SetMotion(this.motion, 2);
			}

			this.subState = function ()
			{
				this.VX_Brake(0,25000000.0);
				this.VY_Brake(0,25000000.0);

				if (this.abs(this.flag1.x) >= 300)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		if (::battle.state == 8 && this.owner.shion_ban)
		{
			this.Shion_SlaveWait(false);
			return;
		}

		this.direction = this.owner.direction;
		this.flag1.x = this.owner.x - 60 * this.direction - this.x;
		this.flag1.y = this.owner.y - 30;
		this.subState();
	};
}

function Shion_SlaveWait( t )
{
	this.owner.shion_act = true;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	if (t)
	{
		this.SetMotion(5009, 0);
		this.stateLabel = function ()
		{
		};
	}
	else
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
		this.SetMotion(5009, 0);
		this.stateLabel = function ()
		{
		};
	}
}

function Shion_Wait_Behind( t )
{
	this.SetMotion(5003, 0);
	this.DrawActorPriority(180);
	this.owner.shion_act = false;
	this.keyAction = null;
	this.rz = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.direction = this.owner.target.direction;
		this.SetSpeed_XY((this.owner.target.x - 75 * this.direction - this.x) * 0,10000000.0, (this.owner.target.y - 75 - this.y) * 0,10000000.0);
	};
}

function Shion_Wait_Behind_Boss( t )
{
	this.SetMotion(5003, 0);
	this.DrawActorPriority(180);
	this.flag5 = {};
	this.flag5.shotCycle <- 20;
	this.flag5.shotCount <- 180;
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
			this.ReleaseActor();
		},
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
			this.isVisible = false;
		}
	];

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 10;
		this.flag5.shotCount = 150;
		break;

	case 2:
		this.flag5.shotCycle = 7;
		this.flag5.shotCount = 120;
		break;

	case 3:
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 90;
		break;
	}

	this.stateLabel = function ()
	{
		if (this.team.life <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.isVisible)
		{
			if (this.team.current.IsDamage())
			{
				this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
				this.isVisible = false;
				return;
			}

			this.direction = this.owner.target.direction;
			this.SetSpeed_XY((this.owner.target.x - 75 * this.direction - this.x) * 0,10000000.0, (this.owner.target.y - 75 - this.y) * 0,10000000.0);
			this.count++;

			if (this.count > this.flag5.shotCount)
			{
				this.count = -60;
			}

			if (this.count < 0 && ::battle.state == 8 && this.count % this.flag5.shotCycle == -1 && !this.team.current.IsDamage())
			{
				this.SetShot(this.x - 80 + this.rand() % 160, this.y - 100 - this.rand() % 51, 1,00000000.0, this.Shion_ShotBoss, {});
			}
		}
		else if (!this.team.current.IsDamage())
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_StageIn_Effect, {});
			this.isVisible = true;
		}
	};
}

function Shion_ShotBoss( t )
{
	this.SetMotion(5307, this.rand() % 4);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 1,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_XY(2,00000000.0 - this.rand() % 41 * 0,10000000.0, -1);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 50)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,00500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,15000001.0, null, 3,50000000.0);
	};
}

function Shion_Damage( count_ )
{
	this.count = count_;
	this.SetMotion(5100, 0);
	this.PlaySE(4629);
	this.keyAction = null;
	this.SetSpeed_XY(-12,00000000.0 * this.direction, -2,00000000.0);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0, 0,25000000.0);
		this.count--;

		if (this.count <= 0)
		{
			this.SetMotion(5100, 1);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
			};
			this.keyAction = function ()
			{
				this.Shion_Wait(null);
				return;
			};
		}
	};
}

function Shion_DamageVanish()
{
	this.SetMotion(5009, 0);
	this.keyAction = null;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
		if (this.owner.debuff_animal.time == 0 && this.owner.IsFree())
		{
			this.Shion_Wait(true);
			return;
		}
	};
}

function Shion_ChargeShot_Wait( t )
{
	if (this.motion == 5300)
	{
		this.team.op_stop = 300;
		this.team.op_stop_max = 300;
	}

	this.SetMotion(5200, 0);
	this.PlaySE(4626);
	this.keyAction = null;
	this.stateLabel = function ()
	{
		if (this.owner.motion != 2025 && this.owner.motion != 2020)
		{
			this.Shion_Wait(true);
			return;
		}

		this.direction = this.owner.direction;
		this.SetSpeed_XY((this.owner.x - this.x) * 0,05000000.0, (this.owner.y - this.y) * 0,05000000.0);
	};
}

function Shion_ChargeShot_Fire( t )
{
	this.SetMotion(5200, 2);
	this.PlaySE(4627);
	this.life = 400;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
	this.SetEndMotionCallbackFunction(function ()
	{
		this.SetMotion(5000, 0);
	});
	this.DrawActorPriority(200);
	this.count = 0;
	this.hitCount = 0;
	this.HitReset();
	this.atk_id = 131072;
	this.keyAction = null;
	this.flag1 = this.SetFreeObject(this.x, this.y, 1,00000000.0, this.Shion_ChargeShot_Trail, {}, this).weakref();
	this.flag1.SetParent(this, 0, 0);
	this.func = function ()
	{
		this.DrawActorPriority(180);

		if (this.flag1)
		{
			this.flag1.func();
			this.flag1 = null;
		}

		this.rz = 0,00000000.0;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, 0,00000000.0);
		this.SetMotion(5200, 1);
		this.stateLabel = function ()
		{
			this.Vec_Brake(0,50000000.0);
		};
		this.keyAction = function ()
		{
			this.Shion_Wait(null);
		};
		return;
	};
	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}

			this.Shion_Damage(60);
			return;
		}

		this.count++;

		if (this.hitResult & 1)
		{
			if (this.flag1)
			{
				this.flag1.func();
				this.flag1 = null;
			}

			this.Shion_Wait_Behind(null);
			return;
		}

		if (this.IsScreen(100) || this.hitCount > 0)
		{
			this.func();
			return;
		}
	};
}

function Shion_ChargeShot_Trail( t )
{
	this.SetMotion(5200, 3);
	this.stateLabel = function ()
	{
		if (this.initTable.pare.motion != 5200)
		{
			this.func();
			return;
		}
	};
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.func = function ()
		{
		};
		this.count = 0;
		this.SetKeyFrame(1);
		this.stateLabel = function ()
		{
			this.count++;

			if (this.count == 50)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shion_Burrage( t )
{
	if (this.motion == 5300)
	{
		this.team.op_stop = 300;
		this.team.op_stop_max = 300;
	}

	this.SetMotion(5302, 0);
	this.life = 100;
	this.flag1 = 0,00000000.0;
	this.rz = 0,00000000.0;
	this.owner.shion_act = true;
	this.vec.x = this.owner.x - 50 * this.owner.direction - this.x;
	this.vec.y = this.owner.y - 50 - this.y;

	if (this.vec.Length() >= 150)
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
		this.Warp(this.owner.x - 50 * this.owner.direction, this.owner.y - 50);
		this.direction = this.owner.direction;
		this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
	}

	this.subState = function ()
	{
		this.direction = this.owner.direction;
		this.flag1 += 0,50000000.0;

		if (this.flag1 > 7,50000000.0)
		{
			this.flag1 = 7,50000000.0;
		}

		this.va.x = (this.owner.x - 50 * this.owner.direction - this.x) * 0,10000000.0;
		this.va.y = (this.owner.y - 50 - this.y) * 0,10000000.0;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		this.ConvertTotalSpeed();
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(4631);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.team.mp > 0 && this.count % 4 == 1)
				{
					local t_ = {};
					t_.v <- this.va.x * 0,50000000.0;
					t_.y <- this.va.y * 0,50000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shion_Shot_Barrage, t_);
				}

				if (this.owner.motion != 2025)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,10000000.0);
					};
					return;
				}

				this.subState();
			};
		},
		null,
		function ()
		{
			this.Shion_Wait(null);
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Shion_Burrage_Behind( t )
{
	this.SetMotion(5302, 0);
	this.life = 100;
	this.flag1 = 0,00000000.0;
	this.owner.shion_act = true;
	this.rz = 0,00000000.0;
	this.subState = function ()
	{
		this.direction = this.owner.target.direction;
		this.flag1 += 0,50000000.0;

		if (this.flag1 > 12,50000000.0)
		{
			this.flag1 = 12,50000000.0;
		}

		this.va.x = (this.owner.target.x - 100 * this.owner.target.direction - this.x) * 0,10000000.0;
		this.va.y = (this.owner.target.y - 50 - this.y) * 0,10000000.0;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		this.ConvertTotalSpeed();
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(4631);
			this.stateLabel = function ()
			{
				this.count++;

				if (this.team.mp > 0 && this.count % 4 == 1)
				{
					local t_ = {};
					t_.v <- -3,00000000.0 * this.direction;
					t_.y <- 0,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shion_Shot_Barrage, t_);
				}

				if (this.owner.motion != 2025)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,10000000.0);
					};
					return;
				}

				this.subState();
			};
		},
		null,
		function ()
		{
			this.Shion_Wait(null);
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Shion_Shot_Barrage( t )
{
	this.SetMotion(5308, this.rand() % 4);
	this.atk_id = 262144;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 0,50000000.0;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_XY(t.v + (3,00000000.0 + this.rand() % 31 * 0,10000000.0) * this.direction, -2,00000000.0 + t.y);
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.flag2 = (1,00000000.0 - this.sx) * 0,25000000.0;
		this.count++;
		this.sx = this.sy += this.flag2;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
	};
}

function Shion_Occult( t )
{
	this.SetMotion(5300, 0);
	this.life = 100;
	this.flag1 = 0,00000000.0;
	this.owner.shion_act = true;
	this.rz = 0,00000000.0;
	this.subState = function ()
	{
		this.AddSpeed_XY(0,50000000.0 * this.direction, 0,00000000.0, 5,00000000.0 * this.direction, null);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(4631);
			this.stateLabel = function ()
			{
				if (this.life <= 0)
				{
					this.team.op_stop = 300;
					this.team.op_stop_max = 300;
					this.Shion_Damage(60);
					return;
				}

				this.count++;

				if (this.count <= 60 && this.count % 6 == 1)
				{
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shion_ShotOccult, {});
				}

				if (this.count == 75 || this.team.current.IsDamage() || this.IsScreen(200))
				{
					this.SetMotion(5300, 2);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,10000000.0);
					};
					return;
				}

				this.subState();
			};
		},
		null,
		function ()
		{
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.Shion_Wait(null);
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Shion_OccultChange( pos_ )
{
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.rz = 0,00000000.0;
	this.team.op_stop = 300;
	this.team.op_stop_max = 300;
	this.Warp(pos_.x, pos_.y);
	this.keyAction = function ()
	{
		this.Shion_Wait(null);
	};
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(5310, 0);
	this.stateLabel = function ()
	{
	};
}

function Shion_ShotOccult( t )
{
	this.SetMotion(5309, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.atk_id = 524288;
	this.sx = this.sy = 0,25000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_XY((4,00000000.0 + this.rand() % 20 * 0,10000000.0) * this.direction, -6,00000000.0 - this.rand() % 21 * 0,10000000.0);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 50 || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return;
		}

		this.flag2 = (1,50000000.0 - this.sx) * 0,25000000.0;

		if (this.flag2 < 0,01000000.0)
		{
			this.flag2 = 0,01000000.0;
		}

		this.count++;
		this.sx = this.sy += this.flag2;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0 || this.count >= 90)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
	};
}

function Shion_Vanish( t )
{
	this.SetMotion(5004, 0);
	this.DrawActorPriority(181);
	this.keyAction = this.ReleaseActor;
}

function Shion_Climax_Wait( t )
{
	this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
	this.SetMotion(5322, 0);
	return;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.direction = this.owner.direction;
	this.flag1.x = this.owner.x - 70 * this.direction - this.x;
	this.flag1.y = this.owner.y - 50 - this.y;

	if (this.flag1.Length() <= 100)
	{
		this.SetMotion(5000, 0);
	}
	else if (this.flag1.x * this.direction > 0)
	{
		this.SetMotion(5001, 0);
	}
	else
	{
		this.SetMotion(5002, 0);
	}

	this.subState = function ()
	{
		local l_ = this.flag1.Length();

		if (l_ <= 60)
		{
			if (this.motion == 5001)
			{
				this.SetMotion(5001, 2);
			}

			if (this.motion == 5002)
			{
				this.SetMotion(5002, 2);
			}

			this.subState = function ()
			{
			};
		}
	};
	this.stateLabel = function ()
	{
		this.flag1.x = this.owner.x - 70 * this.direction - this.x;
		this.flag1.y = this.owner.y - 50 - this.y;
		this.flag2 += 0,50000000.0;

		if (this.flag2 > 15,00000000.0)
		{
			this.flag2 = 15,00000000.0;
		}

		this.subState();
		this.SetSpeed_XY(this.flag1.x * 0,10000000.0, this.flag1.y * 0,10000000.0);

		if (this.va.Length() > this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}
	};
}

function Shion_Climax_MoneyCatch_A( t )
{
	this.SetMotion(5320, 0);
	this.flag1 = this.Vector3();
	this.flag2 = this.Vector3();
	this.flag3 = 0,00000000.0;
	this.direction = -this.owner.direction;
	this.Warp(this.owner.x + 800 * this.owner.direction, this.owner.y);
	this.count = 0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.flag2.x = 20 * this.sin(this.count * 0,08726646.0) * this.direction;
		this.flag2.y = 30 * this.cos(this.count * 0,06981317.0);
		this.flag1.x = this.owner.target.x - 240 * this.direction + this.flag2.x - this.x;
		this.flag1.y = this.owner.y - this.flag2.y - this.y;
		this.flag3 += 1,50000000.0;

		if (this.flag3 > 25,00000000.0)
		{
			this.flag3 = 25,00000000.0;
		}

		this.SetSpeed_XY(this.flag1.x * 0,10000000.0, this.flag1.y * 0,10000000.0);

		if (this.va.Length() > this.flag3)
		{
			this.va.SetLength(this.flag3);
			this.ConvertTotalSpeed();
		}
	};
}

function Shion_Climax_MoneyCatch_B( t )
{
	this.SetMotion(5321, 0);
	this.flag1 = this.Vector3();
	this.flag2 = this.Vector3();
	this.flag2.x = 240,00000000.0;
	this.flag3 = 0,00000000.0;
	this.direction = -this.owner.direction;
	this.count = 0;
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
			this.SetMotion(5322, 0);
			this.stateLabel = null;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.flag2.RotateByRadian(0,10471975.0);
		this.flag1.x = this.owner.x + this.flag2.x - this.x;
		this.flag1.y = this.owner.y + this.flag2.y * 0,25000000.0 + 50 - this.y;

		if (this.flag2.y < 0,00000000.0)
		{
			this.DrawActorPriority(180);
		}
		else
		{
			this.DrawActorPriority(210);
		}

		this.flag3 += 1,00000000.0;

		if (this.flag3 > 25,00000000.0)
		{
			this.flag3 = 25,00000000.0;
		}

		this.SetSpeed_XY(this.flag1.x * 0,10000000.0, this.flag1.y * 0,10000000.0);

		if (this.va.Length() > this.flag3)
		{
			this.va.SetLength(this.flag3);
			this.ConvertTotalSpeed();
		}

		if (this.va.x > 0)
		{
			this.direction = 1,00000000.0;
		}
		else
		{
			this.direction = -1,00000000.0;
		}
	};
}

function Shion_Win_Paper( t )
{
	this.SetMotion(5400, 0);
	this.direction = this.owner.direction;
	this.flag1 = 0,00000000.0;
	this.flag2 = this.Vector3();
	this.stateLabel = function ()
	{
		this.count++;
		this.flag2.x = 20 * this.sin(this.count * 0,03490658.0);
		this.flag2.y = 20 * this.cos(this.count * 0,05235988.0);
		this.flag1 += 0,50000000.0;

		if (this.flag1 >= 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.vec.x = (this.owner.x - (100 + this.flag2.x) * this.direction - this.x) * 0,10000000.0;
		this.vec.y = (this.owner.y + this.flag2.y - this.y - 100) * 0,10000000.0;

		if (this.vec.Length() >= this.flag1)
		{
			this.vec.SetLength(this.flag1);
		}

		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
}

function Shion_Win_Taxi( t )
{
	this.SetMotion(5000, 0);
	this.direction = this.owner.direction;
	this.flag1 = 0,00000000.0;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(5402, 0);
		},
		function ()
		{
			this.PlaySE(4679);
			this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashB, {});
			this.SetMotion(5402, 1);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, -4,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,20000000.0 * this.direction, 0,50000000.0, -2,00000000.0 * this.direction);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0,50000000.0;

		if (this.flag1 >= 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.vec.x = (this.owner.x - 65 * this.direction - this.x) * 0,10000000.0;
		this.vec.y = (this.owner.y - this.y - 50) * 0,10000000.0;

		if (this.vec.Length() >= this.flag1)
		{
			this.vec.SetLength(this.flag1);
		}

		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
}

function Shion_Win_TaxiB( t )
{
	this.SetMotion(5000, 0);
	this.direction = this.owner.direction;
	this.flag1 = 0,00000000.0;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(5401, 0);
		},
		function ()
		{
			this.SetMotion(5401, 1);
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0,50000000.0;

		if (this.flag1 >= 10,00000000.0)
		{
			this.flag1 = 10,00000000.0;
		}

		this.vec.x = (this.owner.x - 65 * this.direction - this.x) * 0,10000000.0;
		this.vec.y = (this.owner.y - this.y - 50) * 0,10000000.0;

		if (this.vec.Length() >= this.flag1)
		{
			this.vec.SetLength(this.flag1);
		}

		this.SetSpeed_XY(this.vec.x, this.vec.y);
	};
}

function Shion_Wait_Stg( t )
{
	this.owner.shion_act = false;
	this.func = [
		function ()
		{
			this.SetMotion(5009, 0);
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
			this.PlaySE(4629);
			this.keyAction = null;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.owner.shion_act = true;
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.owner.shion_act = false;
			this.SetMotion(5000, 0);
			this.DrawActorPriority(180);
			this.keyAction = null;
			this.rz = 0,00000000.0;
			local pos_ = this.Vector3();
			pos_.x = this.owner.x;
			pos_.y = this.owner.y;
			this.flag5 = [
				pos_
			];
			this.Warp(this.flag5[0].x, this.flag5[0].y);
			this.PlaySE(4629);
			this.SetFreeObject(this.x, this.y, this.direction, this.Shion_Vanish, {});
			this.subState = function ()
			{
			};
			this.stateLabel = function ()
			{
				if (this.owner.IsDamage())
				{
					this.func[0].call(this);
					return;
				}

				this.subState();

				if (this.owner.damageStopTime == 0 && this.owner.hitStopTime == 0 && (this.owner.vx || this.owner.vy))
				{
					local pos_ = this.Vector3();
					pos_.x = this.owner.x;
					pos_.y = this.owner.y;
					this.flag5.append(pos_);
				}

				if (this.flag5.len() >= 20)
				{
					this.flag5.remove(0);
				}

				this.Warp(this.flag5[0].x, this.flag5[0].y);
			};
		},
		function ()
		{
			this.owner.shion_act = false;

			if (this.motion != 5302 || this.motion == 5302 && this.keyTake >= 2)
			{
				this.SetMotion(5302, 0);
			}

			this.count = 0;
			this.SetShot(this.point0_x, this.point0_y, 1,00000000.0, this.Shion_ShotStg, {});
			this.subState = function ()
			{
				this.count++;

				if (this.count >= 30)
				{
					this.subState = function ()
					{
					};
					this.SetMotion(5302, 2);
					this.keyAction = function ()
					{
						this.SetMotion(5000, 0);
						this.keyAction = null;
					};
				}
			};
		}
	];
	this.func[1].call(this);
}

function Shion_ShotStg( t )
{
	this.SetMotion(5507, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.cancelCount = 1;
	this.sx = this.sy = 1,00000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_XY(3,00000000.0, -10,00000000.0);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.y > ::battle.scroll_bottom + 50)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,02000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.AddSpeed_XY(0,00000000.0, 0,50000000.0, null, 15,00000000.0);
	};
}

