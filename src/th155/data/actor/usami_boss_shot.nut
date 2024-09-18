function Boss_Shot_M1_Bullet( t )
{
	this.flag2 = this.rand() % 4;
	this.SetMotion(4919, 1 + this.flag2 * 2);
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x - t.pare.x;
	this.flag1.y = this.y - t.pare.y;
	this.func = [
		function ()
		{
			this.SetMotion(4919, this.flag2);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.02500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( pare_ )
		{
			this.hitOwner = this;
			this.SetSpeed_XY((this.x - pare_.x) * 0.10000000, (this.y - pare_.y) * 0.10000000);
			this.cancelCount = 1;
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Boss_Shot_M1( t )
{
	this.SetMotion(4919, 8);
	this.owner.shot_actor.Add(this);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag4 = 6;
	this.flag5 = {};
	this.flag5.shotCycle <- 10;
	this.flag5.moveV <- 0.00000000;
	this.flag5.rad_1 <- 100;
	this.flag5.rad_2 <- 200;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag4 = 12;
		this.flag5.rad_1 = 125;
		this.flag5.rad_2 = 250;
		break;

	case 2:
		this.flag4 = 16;
		this.flag5.rad_1 = 200;
		this.flag5.rad_2 = 400;
		break;

	case 3:
		this.flag4 = 20;
		this.flag5.rad_1 = 275;
		this.flag5.rad_2 = 550;
		break;
	}

	this.cancelCount = 99;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.flag1.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.ReleaseActor();
		},
		function ()
		{
			this.flag5.moveV = 0;
			this.subState = function ()
			{
				this.flag5.moveV += 0.50000000;

				if (this.flag5.moveV > 4.00000000)
				{
					this.flag5.moveV = 4.00000000;
				}

				this.va.x = (this.team.current.x - this.x) * 0.15000001;
				this.va.y = (this.team.current.y - this.y) * 0.15000001;

				if (this.va.Length() > this.flag5.moveV)
				{
					this.va.SetLength(this.flag5.moveV);
				}

				this.ConvertTotalSpeed();
			};
		},
		function ()
		{
			this.PlaySE(3645);
			this.flag1.Foreach(function ( pare_ = this )
			{
				this.func[2].call(this, pare_);
			});
			this.ReleaseActor();
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % this.flag5.shotCycle == 1 && this.flag4 > 0)
		{
			local a_ = this.SetShot(this.x - this.flag5.rad_1 + this.rand() % this.flag5.rad_2, this.y - this.flag5.rad_1 + this.rand() % this.flag5.rad_2, this.direction, this.Boss_Shot_M1_Bullet, {}, this.weakref());
			this.flag1.Add(a_);
			a_.hitOwner = this;
			this.flag4--;
		}

		this.HitCycleUpdate(11);
		this.flag1.Foreach(function ( a_ = this )
		{
			this.flag1.RotateByDegree(4.00000000);
			this.SetSpeed_XY((a_.x + this.flag1.x - this.x) * 0.20000000, (a_.y + this.flag1.y - this.y) * 0.20000000);
		});
		this.subState();
	};
}

function Boss_Doppel_Hole_D2( t )
{
	this.SetMotion(4926, 5);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag5 = {};
	this.flag5.shotCycle <- 360;
	this.flag5.shotCount <- 0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.life = 500;
		break;

	case 1:
		this.life = 750;
		this.flag5.shotCycle = 330;
		break;

	case 2:
		this.life = 900;
		this.flag5.shotCycle = 300;
		break;

	case 3:
		this.life = 1200;
		this.flag5.shotCycle = 270;
		break;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.subState = function ()
	{
		this.count++;

		if (this.count >= this.flag5.shotCycle)
		{
			this.func[1].call(this);
			return;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4929, 0);

			if (this.life <= 0)
			{
				this.team.regain_life -= 1000;

				if (this.team.life >= this.team.regain_life)
				{
					this.team.life = this.team.regain_life;
					this.owner.boss_shot.Foreach(function ()
					{
						this.func[0].call(this);
					});
					::camera.Shake(10);
					local t_ = {};
					t_.count <- 15;
					t_.priority <- 210;
					this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 1.04999995;
				this.SetSpeed_XY(0.00000000, -10 * this.sy);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1.00000000 : 1.00000000;
			this.SetMotion(4926, 0);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		}
	];
	this.keyAction = [
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetShot(this.x + 100 * this.direction, ::battle.scroll_bottom, this.direction, this.Boss_Shot_D2_HoleCore, {});
		},
		null,
		null,
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.count++;

				if (this.count >= this.flag5.shotCycle)
				{
					this.func[1].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Doppel_Denchu_D2( t )
{
	this.SetMotion(4927, 5);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 360;
	this.flag5.shotCount <- 0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.life = 500;
		break;

	case 1:
		this.life = 750;
		this.flag5.shotCycle = 300;
		break;

	case 2:
		this.life = 900;
		this.flag5.shotCycle = 240;
		break;

	case 3:
		this.life = 1200;
		this.flag5.shotCycle = 180;
		break;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.subState = function ()
	{
		this.count++;

		if (this.count >= this.flag5.shotCycle)
		{
			this.func[1].call(this);
			return;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4929, 0);

			if (this.life <= 0)
			{
				this.team.regain_life -= 1000;

				if (this.team.life >= this.team.regain_life)
				{
					this.team.life = this.team.regain_life;
					this.owner.boss_shot.Foreach(function ()
					{
						this.func[0].call(this);
					});
					::camera.Shake(10);
					local t_ = {};
					t_.count <- 15;
					t_.priority <- 210;
					this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 1.04999995;
				this.SetSpeed_XY(0.00000000, -10 * this.sy);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1.00000000 : 1.00000000;
			this.SetMotion(4927, 0);
			this.PlaySE(3637);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetShot(this.direction == 1.00000000 ? ::camera.camera2d.right + 100 : ::camera.camera2d.left - 100, 860, -this.direction, this.Boss_Shot_D2_Denchu, {});
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.count++;

				if (this.count >= this.flag5.shotCycle)
				{
					this.func[1].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Doppel_Tower_D2( t )
{
	this.SetMotion(4925, 5);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 360;
	this.flag5.shotCount <- 0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.life = 500;
		break;

	case 1:
		this.life = 750;
		this.flag5.shotCycle = 330;
		break;

	case 2:
		this.life = 900;
		this.flag5.shotCycle = 300;
		break;

	case 3:
		this.life = 1200;
		this.flag5.shotCycle = 270;
		break;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.subState = function ()
	{
		this.count++;

		if (this.count >= this.flag5.shotCycle)
		{
			this.func[1].call(this);
			return;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4929, 0);

			if (this.life <= 0)
			{
				this.team.regain_life -= 1000;

				if (this.team.life >= this.team.regain_life)
				{
					this.team.life = this.team.regain_life;
					this.owner.boss_shot.Foreach(function ()
					{
						this.func[0].call(this);
					});
					::camera.Shake(10);
					local t_ = {};
					t_.count <- 15;
					t_.priority <- 210;
					this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0.89999998;
				this.sy *= 1.04999995;
				this.SetSpeed_XY(0.00000000, -10 * this.sy);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1.00000000 : 1.00000000;
			this.SetMotion(4925, 0);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.Boss_Shot_D2, {});
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.count++;

				if (this.count >= this.flag5.shotCycle)
				{
					this.func[1].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.life <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_D2( t )
{
	this.SetMotion(4937, 2);
	this.owner.shot_actor.Add(this);
	::camera.shake_radius = 5.00000000;
	this.PlaySE(3649);
	this.rz = 15 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.flag1 = 0.25000000 * 0.01745329;
	this.cancelCount = 99;
	this.flag2 = 1;
	this.flag3 = 1;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag2 = 10;
		this.flag3 = 3;
		break;

	case 2:
		this.flag2 = 100;
		this.flag3 = 6;
		break;

	case 3:
		this.flag2 = 100;
		this.flag3 = 10;
		break;
	}

	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.rz > 10.00000000 * 0.01745329)
		{
			if (this.keyTake == 2)
			{
				this.SetMotion(4937, 0);
			}
		}

		this.flag1 += this.flag1 < 0.50000000 * 0.01745329 ? 0.00025000 * 0.01745329 : 0.00000000;

		if (this.rz > 45.00000000 * 0.01745329)
		{
			this.flag1 += 0.01000000 * 0.01745329;

			if (this.keyTake == 0)
			{
				this.SetMotion(4937, 1);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

		if (this.grazeCount >= this.flag2 || this.hitCount >= this.flag3)
		{
			this.callbackGroup = 0;
		}
		else
		{
			this.HitCycleUpdate(8);
		}

		this.count++;

		if (this.rz >= 90 * 0.01745329)
		{
			this.PlaySE(3650);
			::camera.shake_radius = 12.00000000;
			this.ReleaseActor();
			return;
		}
	};
}

function Boss_Shot_D2_Denchu( t )
{
	this.SetMotion(4939, 2);
	this.owner.shot_actor.Add(this);
	this.rz = -10 * 0.01745329;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.flag1 = 0.75000000 * 0.01745329;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.05000000;
				this.flag1 += 0.05000000 * 0.01745329;
				this.rz += this.flag1;

				if (this.rz > 90.00000000 * 0.01745329)
				{
					this.rz = 90.00000000 * 0.01745329;
				}

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			return;
		}
	];
	this.stateLabel = function ()
	{
		if (this.rz > 10.00000000 * 0.01745329)
		{
			this.flag1 += 0.05000000 * 0.01745329;

			if (this.keyTake == 2)
			{
				this.SetMotion(this.motion, 0);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

		if (this.rz >= 90 * 0.01745329)
		{
			this.PlaySE(3638);
			::camera.shake_radius = 5.00000000;
			this.ReleaseActor();
			return;
		}
	};
}

function Boss_Shot_D2_HoleCore( t )
{
	this.owner.shot_actor.Add(this);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(3628);

			switch(this.owner.com_difficulty)
			{
			case 0:
				this.flag1 = 3;
				this.flag2 = 90;
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				break;

			case 1:
				this.flag1 = 6;
				this.flag2 = 30;
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				break;

			case 2:
				this.flag1 = 8;
				this.flag2 = 25;
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				break;

			case 3:
				this.flag1 = 12;
				this.flag2 = 20;
				this.SetSpeed_XY(6.00000000 * this.direction, 0.00000000);
				break;
			}

			this.stateLabel = function ()
			{
				this.count++;

				if (this.count % this.flag2 == 1)
				{
					this.PlaySE(3628);
					this.flag1--;
					this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_D2_Splash, {});
				}

				if (this.flag1 <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(10))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;

		if (this.count == 20)
		{
			this.func[1].call(this);
		}
	};
	this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_D2_Hole, {});
}

function Boss_Shot_D2_Hole( t )
{
	this.SetMotion(4938, 0);
	this.cancelCount = 3;
	this.SetSpeed_Vec(35.00000000, -1.57079601, this.direction);
	this.flag1 = -35 * 0.01745329;
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0.94999999;
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.subState();
				this.SetSpeed_XY(this.va.x * 0.89999998, this.va.y * 0.89999998);
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.alpha = this.red = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.Vec_Brake(1.00000000, 1.50000000);
		this.count++;

		if (this.count == 20)
		{
			this.callbackGroup = 0;
			this.SetMotion(4938, 3);
		}

		if (this.count >= 50)
		{
			this.stateLabel = function ()
			{
				this.subState();
				this.AddSpeed_XY(0.00000000, 0.75000000);

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Boss_Shot_D2_Splash( t )
{
	this.SetMotion(4938, 1);
	this.sx = 1.50000000;
	this.SetSpeed_Vec(60.00000000, -1.57079601, this.direction);
	this.cancelCount = 1;

	if (this.rand() % 100 <= 50)
	{
		this.sx = -this.sx;
	}

	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(2.00000000, 1.50000000))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0.00000000, 0.50000000);
						this.sx *= 1.00999999;
						this.alpha = this.red = this.green -= 0.05000000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					};
				}

				this.alpha -= 0.10000000;
				this.sx *= 0.92000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func[0].call(this);
			return;
		}

		if (this.Vec_Brake(2.50000000, 1.50000000))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.sx *= 1.00999999;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

