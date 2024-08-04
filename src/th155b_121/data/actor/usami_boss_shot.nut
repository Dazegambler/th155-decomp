function Boss_Shot_M1_Bullet( t )
{
	this.flag2 = this.rand() % 4;
	this.SetMotion(4919, 1 + this.flag2 * 2);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x - t.pare.x;
	this.flag1.y = this.y - t.pare.y;
	this.func = [
		function ()
		{
			this.SetMotion(4919, this.flag2 * 2);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ( pare_ )
		{
			this.hitOwner = this;
			this.SetSpeed_XY((this.x - pare_.x) * 0,10000000.0, (this.y - pare_.y) * 0,10000000.0);
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
	this.flag5.moveV <- 0,00000000.0;
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

	case 4:
		this.flag4 = 24;
		this.flag5.rad_1 = 300;
		this.flag5.rad_2 = 575;
		break;
	}

	this.cancelCount = 99;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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
				this.flag5.moveV += 0,50000000.0;

				if (this.flag5.moveV > 4,00000000.0)
				{
					this.flag5.moveV = 4,00000000.0;
				}

				this.va.x = (this.team.current.x - this.x) * 0,15000001.0;
				this.va.y = (this.team.current.y - this.y) * 0,15000001.0;

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
			this.flag1.RotateByDegree(4,00000000.0);
			this.SetSpeed_XY((a_.x + this.flag1.x - this.x) * 0,20000000.0, (a_.y + this.flag1.y - this.y) * 0,20000000.0);
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

	case 4:
		this.life = 1200;
		this.flag5.shotCycle = 240;
		break;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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

			if (this.life <= 0 && this.owner.team.life > 0)
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
					this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1,00000000.0 : 1,00000000.0;
			this.SetMotion(4926, 0);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		},
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
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
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
		if (this.owner.team.life <= 0)
		{
			this.func[2].call(this);
			return;
		}

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

	case 4:
		this.life = 1200;
		this.flag5.shotCycle = 150;
		break;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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

			if (this.life <= 0 && this.owner.team.life > 0)
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
					this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1,00000000.0 : 1,00000000.0;
			this.SetMotion(4927, 0);
			this.PlaySE(3637);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		},
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
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
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
			this.SetShot(this.direction == 1,00000000.0 ? ::camera.camera2d.right + 100 : ::camera.camera2d.left - 100, 860, -this.direction, this.Boss_Shot_D2_Denchu, {});
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
		if (this.owner.team.life <= 0)
		{
			this.func[2].call(this);
			return;
		}

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

	case 4:
		this.life = 1200;
		this.flag5.shotCycle = 240;
		break;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
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

			if (this.life <= 0 && this.owner.team.life > 0)
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
					this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
					this.owner.Set_Boss_Shield(null);
					this.team.current.SpellCrash_Init(null);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.direction = this.x >= this.owner.target.x ? -1,00000000.0 : 1,00000000.0;
			this.SetMotion(4925, 0);
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.subState = function ()
			{
			};
		},
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
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
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
		if (this.owner.team.life <= 0)
		{
			this.func[2].call(this);
			return;
		}

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
	::camera.shake_radius = 5,00000000.0;
	this.PlaySE(3649);
	this.rz = 15 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.flag1 = 0,25000000.0 * 0,01745329.0;
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
	case 4:
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
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.rz > 10,00000000.0 * 0,01745329.0)
		{
			if (this.keyTake == 2)
			{
				this.SetMotion(4937, 0);
			}
		}

		this.flag1 += this.flag1 < 0,50000000.0 * 0,01745329.0 ? 0,00025000.0 * 0,01745329.0 : 0,00000000.0;

		if (this.rz > 45,00000000.0 * 0,01745329.0)
		{
			this.flag1 += 0,01000000.0 * 0,01745329.0;

			if (this.keyTake == 0)
			{
				this.SetMotion(4937, 1);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

		if (this.grazeCount >= this.flag2 || this.hitCount >= this.flag3)
		{
			this.callbackGroup = 0;
		}
		else
		{
			this.HitCycleUpdate(8);
		}

		this.count++;

		if (this.rz >= 90 * 0,01745329.0)
		{
			this.PlaySE(3650);
			::camera.shake_radius = 12,00000000.0;
			this.ReleaseActor();
			return;
		}
	};
}

function Boss_Shot_D2_Denchu( t )
{
	this.SetMotion(4939, 2);
	this.owner.shot_actor.Add(this);
	this.rz = -10 * 0,01745329.0;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.flag1 = 0,75000000.0 * 0,01745329.0;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,05000000.0;
				this.flag1 += 0,05000000.0 * 0,01745329.0;
				this.rz += this.flag1;

				if (this.rz > 90,00000000.0 * 0,01745329.0)
				{
					this.rz = 90,00000000.0 * 0,01745329.0;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			return;
		}
	];
	this.stateLabel = function ()
	{
		if (this.rz > 10,00000000.0 * 0,01745329.0)
		{
			this.flag1 += 0,05000000.0 * 0,01745329.0;

			if (this.keyTake == 2)
			{
				this.SetMotion(this.motion, 0);
			}
		}

		this.rz += this.flag1;
		this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);

		if (this.rz >= 90 * 0,01745329.0)
		{
			this.PlaySE(3638);
			::camera.shake_radius = 5,00000000.0;
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
				this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
				break;

			case 1:
				this.flag1 = 6;
				this.flag2 = 30;
				this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
				break;

			case 2:
				this.flag1 = 8;
				this.flag2 = 25;
				this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
				break;

			case 3:
				this.flag1 = 12;
				this.flag2 = 20;
				this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
				break;

			case 4:
				this.flag1 = 14;
				this.flag2 = 15;
				this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
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
	this.SetSpeed_Vec(35,00000000.0, -1,57079601.0, this.direction);
	this.flag1 = -35 * 0,01745329.0;
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.flag1 *= 0,94999999.0;
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.subState();
				this.SetSpeed_XY(this.va.x * 0,89999998.0, this.va.y * 0,89999998.0);
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				this.alpha = this.red = this.green = this.blue -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
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

		this.Vec_Brake(1,00000000.0, 1,50000000.0);
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
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

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
	this.sx = 1,50000000.0;
	this.SetSpeed_Vec(60,00000000.0, -1,57079601.0, this.direction);
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
				if (this.Vec_Brake(2,00000000.0, 1,50000000.0))
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
						this.sx *= 1,00999999.0;
						this.alpha = this.red = this.green -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}

				this.alpha -= 0,10000000.0;
				this.sx *= 0,92000002.0;

				if (this.alpha <= 0,00000000.0)
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

		if (this.Vec_Brake(2,50000000.0, 1,50000000.0))
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.sx *= 1,00999999.0;
				this.alpha = this.red = this.green -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Boss_Shot_D3_Aura( t )
{
	this.SetMotion(4969, 0);
	this.DrawActorPriority(180);
	this.SetParent(this.owner, 0, 0);
	this.sx = 0,80000001.0 + this.rand() % 31 * 0,01000000.0;
	this.sy = 0,69999999.0 + this.rand() % 11 * 0,01000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 0,00500000.0;
	this.flag1.y = 0,01000000.0;
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,15000001.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
				this.alpha -= 0,20000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
		this.sx += this.flag1.x;
		this.sy += this.flag1.y;
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,10000000.0);
				this.sx += this.flag1.x;
				this.sy += this.flag1.y;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Boss_Shot_D3_Spark( t )
{
	this.SetMotion(4968, 0);
	this.owner.shot_actor.Add(this);
	this.SetParent(t.pare, this.x - t.pare.x, 0);
	this.hitResult = 128;
	this.cancelCount = 99;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag5 = 0;
		break;

	case 1:
		this.flag5 = 45;
		break;

	case 2:
		this.flag5 = 32;
		break;

	case 3:
	case 4:
		this.flag5 = 10;
		break;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 1);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = null;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(20);
		this.count++;

		if (this.count % 12 == 1)
		{
			this.rx = this.rand() % 360 * 0,01745329.0;
		}

		if (this.flag5 > 0 && this.count % this.flag5 == 1)
		{
			this.SetShot(640 + 740 * this.direction, this.y, -this.direction, this.Boss_Shot_D3_Debri, {});
		}
	};
}

function Boss_Shot_D3_SparkB( t )
{
	this.SetMotion(4968, 0);
	this.owner.shot_actor.Add(this);
	this.SetParent(t.pare, this.x - t.pare.x, 0);
	this.hitResult = 128;
	this.cancelCount = 99;
	this.flag1 = this.Vector3();

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag5 = 0;
		break;

	case 1:
		this.flag5 = 90;
		break;

	case 2:
		this.flag5 = 60;
		break;

	case 3:
	case 4:
		this.flag5 = 10;
		break;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 1);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = null;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.initTable.target == null)
		{
			this.func[0].call(this);
			return;
		}

		this.flag1.x = this.initTable.target.x - this.x;
		this.flag1.y = this.initTable.target.y - this.y;
		this.sx = this.flag1.Length() / 1500;
		this.rz = this.atan2(this.flag1.y, this.flag1.x * this.direction);
		this.FitBoxfromSprite();
		this.HitCycleUpdate(20);
	};
}

function Boss_Shot_D3_SparkC( t )
{
	this.SetMotion(4968, 0);
	this.owner.shot_actor.Add(this);
	this.SetParent(t.pare, this.x - t.pare.x, 0);
	this.hitResult = 128;
	this.cancelCount = 99;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag5 = 0;
		break;

	case 1:
		this.flag5 = 30;
		break;

	case 2:
		this.flag5 = 32;
		break;

	case 3:
	case 4:
		this.flag5 = 6;
		break;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(this.motion, 1);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = null;
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.HitCycleUpdate(20);
		this.count++;

		if (this.flag5 > 0 && this.count % this.flag5 == 1)
		{
			this.SetShot(this.x + 740 * this.direction * this.cos(this.rz), this.y + 360 * this.sin(this.rz), this.cos(this.rz) * this.direction > 0,00000000.0 ? -1,00000000.0 : 1,00000000.0, this.Boss_Shot_D3_Debri, {});
		}
	};
}

function Boss_Shot_D3_Debri( t )
{
	this.SetMotion(4967, 1 + this.rand() % 4 * 2);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	local r_ = (2 + this.rand() % 2) * (1 - 2 * this.rand() % 2) * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, r_);
	this.SetSpeed_XY((15,00000000.0 + this.rand() % 6) * this.direction, 0,00000000.0);
	this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashC, {});
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake - 1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.cancelCount = 3;
	this.subState = function ()
	{
		this.VX_Brake(0,75000000.0, 2,00000000.0 * this.direction);
		this.count++;

		if (this.count >= 60)
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(0,50000000.0 * this.direction, 0,00000000.0, 7,50000000.0 * this.direction, 0,00000000.0);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 5)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);
		this.subState();
	};
}

function Boss_Shot_D3_DebriB( t )
{
	this.SetMotion(4967, this.rand() % 4 * 2);
	this.flag1 = this.keyTake;
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	local r_ = (2 + this.rand() % 2) * (1 - 2 * this.rand() % 2) * 0,01745329.0;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, r_);
	this.SetSpeed_XY(0,00000000.0, -2,50000000.0);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.flag1);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.SetMotion(this.motion, this.flag1 + 1);
			this.subState = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,20000000.0, 0,00000000.0, 5,00000000.0);
			};
		}
	];
	this.cancelCount = 3;
	this.subState = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
			this.subState = function ()
			{
				this.VY_Brake(0,05000000.0);
				this.count++;

				if (this.count >= 30)
				{
					this.func[1].call(this);
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 5)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);
		this.subState();
	};
}

function Boss_Doppel_Start_D3( t )
{
	this.SetMotion(4960, 2);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	this.life = 99999;
	this.flag1 = 99999;
	this.subState = function ()
	{
		this.Warp(1280 - this.owner.x, this.owner.y);
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
			this.flag5 = null;
			this.flag3 = null;
			this.SetMotion(4929, 0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4960, 0);
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag1 > this.life && this.owner.team.life > 0)
		{
			this.team.regain_life -= (this.flag1 - this.life) * 0,10000000.0;
			this.flag1 = this.life;

			if (this.team.life >= this.team.regain_life)
			{
				this.team.regain_life = this.team.life;
				this.owner.boss_shot.Foreach(function ()
				{
					this.func[0].call(this);
				});
				::camera.Shake(10);
				local t_ = {};
				t_.count <- 15;
				t_.priority <- 210;
				this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
				this.owner.Set_Boss_Shield(null);
				this.team.current.SpellCrash_Init(null);
				this.func[0].call(this);
				return;
			}
		}

		this.subState();
	};
}

function Boss_DoppelA_D3( t )
{
	this.SetMotion(4960, 0);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	this.flag5 = this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_Spark, {}, this.weakref()).weakref();
	this.life = 9999;
	this.flag1 = 9999;
	this.subState = function ()
	{
		this.Warp(1280 - this.owner.x, this.owner.y);
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

			if (this.flag5)
			{
				this.flag5.func[0].call(this.flag5);
			}

			this.flag4 = null;
			this.flag5 = null;
			this.flag3 = null;
			this.SetMotion(4929, 0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
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
		if (this.flag1 > this.life && this.owner.team.life > 0)
		{
			this.team.regain_life -= this.flag1 - this.life;
			this.flag1 = this.life;

			if (this.team.life >= this.team.regain_life)
			{
				this.team.regain_life = this.team.life;
				this.owner.boss_shot.Foreach(function ()
				{
					this.func[0].call(this);
				});
				::camera.Shake(10);
				local t_ = {};
				t_.count <- 15;
				t_.priority <- 210;
				this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
				this.owner.Set_Boss_Shield(null);
				this.team.current.SpellCrash_Init(null);
				this.func[0].call(this);
				return;
			}
		}

		this.subState();
	};
}

function Boss_DoppelB_D3( t )
{
	this.SetMotion(4961, 0);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	local t_ = {};
	t_.target <- this.owner.weakref();
	this.flag5 = this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_SparkB, t_, this.weakref()).weakref();
	this.life = 9999;
	this.flag1 = 9999;
	this.subState = function ()
	{
		this.Warp(1280 - this.owner.x, this.owner.y);
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

			if (this.flag5)
			{
				this.flag5.func[0].call(this.flag5);
			}

			this.flag4 = null;
			this.flag5 = null;
			this.flag3 = null;
			this.SetMotion(4929, 0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
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
		if (this.flag1 > this.life && this.owner.team.life > 0)
		{
			this.team.regain_life -= this.flag1 - this.life;
			this.flag1 = this.life;

			if (this.team.life >= this.team.regain_life)
			{
				this.team.regain_life = this.team.life;
				this.owner.boss_shot.Foreach(function ()
				{
					this.func[0].call(this);
				});
				::camera.Shake(10);
				local t_ = {};
				t_.count <- 15;
				t_.priority <- 210;
				this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
				this.owner.Set_Boss_Shield(null);
				this.team.current.SpellCrash_Init(null);
				this.func[0].call(this);
				return;
			}
		}

		this.subState();
	};
}

function Boss_DoppelC_D3( t )
{
	this.SetMotion(4960, 0);
	this.flag3 = this.SetEffect(this.x, this.y, this.direction, this.EF_Shield, {}, this.weakref()).weakref();
	this.flag4 = null;
	this.flag5 = null;
	this.life = 9999;
	this.flag1 = 9999;
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

			if (this.flag5)
			{
				this.flag5.func[0].call(this.flag5);
			}

			this.flag4 = null;
			this.flag5 = null;
			this.flag3 = null;
			this.SetMotion(4929, 0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx *= 0,89999998.0;
				this.sy *= 1,04999995.0;
				this.SetSpeed_XY(0,00000000.0, -10 * this.sy);
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.flag5 = this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_SparkC, {}, this.weakref()).weakref();
		},
		function ()
		{
			if (this.flag5)
			{
				if (this.flag5)
				{
					this.flag5.func[0].call(this.flag5);
				}

				this.flag5 = null;
			}
		},
		function ()
		{
			this.SetMotion(4960, 0);
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag1 > this.life && this.owner.team.life > 0)
		{
			this.team.regain_life -= this.flag1 - this.life;
			this.flag1 = this.life;

			if (this.team.life >= this.team.regain_life)
			{
				this.team.regain_life = this.team.life;
				this.owner.boss_shot.Foreach(function ()
				{
					this.func[0].call(this);
				});
				::camera.Shake(10);
				local t_ = {};
				t_.count <- 15;
				t_.priority <- 210;
				this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);
				this.owner.Set_Boss_Shield(null);
				this.team.current.SpellCrash_Init(null);
				this.func[0].call(this);
				return;
			}
		}
	};
}

function Boss_Shot_D4_BulletB_Core( t )
{
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag1 = 1;
		break;

	case 1:
		this.flag1 = 3;
		break;

	case 2:
		this.flag1 = 4;
		break;

	case 3:
		this.flag1 = 6;
		break;

	case 4:
		this.flag1 = 8;
		break;
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 15 == 1)
		{
			this.flag1--;
			local t_ = {};
			t_.rot <- this.rz;
			this.SetShot(this.x, this.y, this.owner.direction, this.Boss_Shot_D4_BulletB, t_, this.weakref());

			if (this.flag1 <= 0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Boss_Shot_D4_BulletB( t )
{
	this.SetMotion(4949, 1 + this.rand() % 4 * 2);
	this.owner.shot_actor.Add(this);
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,05235988.0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 3;
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.RotateByRadian(t.rot);
	this.flag2 = this.Vector3();
	this.flag3 = 100,00000000.0;
	this.flag4 = this.Vector3();
	this.flag4.x = this.x;
	this.flag4.y = this.y;
	this.flag5 = 3,00000000.0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag5 = 6,00000000.0;
		break;

	case 1:
		this.flag5 = 7,00000000.0;
		break;

	case 2:
		this.flag5 = 8,00000000.0;
		break;

	case 3:
	case 4:
		this.flag5 = 9,00000000.0;
		break;
	}

	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.red = this.green = this.blue -= 0,05000000.0;

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
			this.subState = null;
		}
	];
	this.subState = function ()
	{
		this.flag2.x = this.flag1.x * this.direction * this.flag3;
		this.flag2.y = this.flag1.y * this.flag3 * 0,40000001.0;
		this.SetSpeed_XY(this.flag4.x + this.flag2.x - this.x, this.flag4.y + this.flag2.y - this.y);
		local r_ = this.flag5 / this.flag3;
		this.flag1.RotateByRadian(r_);
		local l_ = (350 - this.flag3) * 0,02500000.0;

		if (l_ < 2,00000000.0)
		{
			l_ = 2,00000000.0;
		}

		this.flag3 += l_;
	};
	this.flag2.x = this.flag1.x * this.direction * this.flag3;
	this.flag2.y = this.flag1.y * this.flag3 * 0,40000001.0;
	this.Warp(this.initTable.pare.x + this.flag2.x, this.initTable.pare.y + this.flag2.y);
	this.stateLabel = function ()
	{
		if (this.IsScreen(500))
		{
			this.ReleaseActor();
		}

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
		}

		if (this.subState)
		{
			this.subState();
		}
	};
}

function Boss_Shot_D4_Bullet( t )
{
	this.SetMotion(4949, t.take);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.cancelCount = 3;
	this.flag1 = this.Vector3();
	this.flag1.x = 1,00000000.0;
	this.flag1.RotateByDegree(t.rot);
	this.flag3 = 100,00000000.0;
	this.flag4 = t.rot;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.red = this.green = this.blue -= 0,05000000.0;

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.HitReset();
			this.cancelCount = 3;
			this.SetMotion(4949, this.keyTake + 1);
			this.SetSpeed_XY((this.owner.x - this.x) * 0,01000000.0, (this.owner.y - this.y) * 0,01000000.0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.ReleaseActor();
				}

				if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.subState = function ()
	{
		this.flag2.x = this.flag1.x * this.flag3;
		this.flag2.y = this.flag1.y * this.flag3 * 0,50000000.0;
		this.flag2.RotateByRadian(this.flag4);
		this.Warp(this.initTable.pare.x + this.flag2.x * this.direction, this.initTable.pare.y + this.flag2.y);
	};
	this.subState();
	this.stateLabel = function ()
	{
		this.subState();
		this.flag1.RotateByDegree(8,00000000.0);
	};
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				this.red = this.green = this.blue -= 0,05000000.0;

				if (this.y > ::battle.scroll_bottom + 100)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.HitReset();
			this.cancelCount = 3;
			this.SetMotion(4949, this.keyTake + 1);
			this.SetSpeed_XY((this.owner.x - this.x) * 0,01000000.0, (this.owner.y - this.y) * 0,01000000.0);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100))
				{
					this.ReleaseActor();
				}

				if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
				}
			};
		}
	];
}

function Boss_Shot_D4( t )
{
	this.owner.shot_actor.Add(this);
	this.SetMotion(4949, 9);
	this.DrawActorPriority(180);
	this.sx = this.sy = 0,01000000.0;
	this.flag1 = 0,33000001.0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag4 = 0;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_D4_A, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_D4_B, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	local a_ = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Boss_Shot_D4_C, {});
	a_.SetParent(this, 0, 0);
	this.flag2.Add(a_);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag3.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.sx = this.sy = 2,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,69999999.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4949, 8);
			this.HitReset();
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag3.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.flag2.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.sx = this.sy += (6,00000000.0 - this.sx) * 0,25000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
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
		this.count++;

		if (this.count % 60 == 59)
		{
			this.PlaySE(3631);
			this.flag3.Add(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_D4_BulletB_Core, {}));
		}

		this.SetSpeed_XY((this.owner.point0_x - this.x) * 0,10000000.0, (this.owner.point0_y - this.y) * 0,10000000.0);
		this.flag1 += 0,01000000.0;

		if (this.flag1 > 2,00000000.0)
		{
			this.flag1 = 2,00000000.0;
		}

		this.sx = this.sy += (this.flag1 - this.sx) * 0,20000000.0;
		this.flag2.Foreach(function ( sx_ = this.sx, sy_ = this.sy )
		{
			this.sx = this.flag1.x * sx_;
			this.sy = this.flag1.y * sy_;
		});
		this.Vec_Brake(0,50000000.0);
	};
}

function Boss_Shot_D4_A( t )
{
	this.SetMotion(4949, 11);
	this.DrawActorPriority(180);
	this.rx = 75 * 0,01745329.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 0,00000000.0;
	this.flag1.y = 0,00000000.0;
	this.flag2 = 1,00000000.0;
	this.sx = this.sy = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0,80000001.0;
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
		this.rz -= 0,01745329.0;

		if (this.flag2 < 2,00000000.0)
		{
			this.flag2 += 0,01000000.0;
		}

		this.flag1.x = this.flag1.y += this.flag2 - this.flag1.x - 0,10000000.0;
	};
}

function Boss_Shot_D4_B( t )
{
	this.SetMotion(4949, 12);
	this.DrawActorPriority(180);
	this.flag1 = this.Vector3();
	this.flag1.x = 0,50000000.0;
	this.flag1.y = 0,50000000.0;
	this.sx = this.sy = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0,80000001.0;
				this.sy *= 1,04999995.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.flag1.y += 0,02500000.0;
	};
}

function Boss_Shot_D4_C( t )
{
	this.SetMotion(4949, 13);
	this.DrawActorPriority(180);
	this.DrawActorPriority(180);
	this.anime.vertex_alpha1 = 0,00000000.0;
	this.alpha = 0,00000000.0;
	this.flag1 = this.Vector3();
	this.flag1.x = 1,75000000.0;
	this.flag1.y = 1,75000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 10,00000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += this.alpha <= 0,94999999.0 ? 0,05000000.0 : 0,00000000.0;
		this.anime.top += 10,00000000.0;
	};
}

function Boss_Shot_D4_Spark( t )
{
	this.SetMotion(4949, 10);
	this.DrawActorPriority(199);
	this.rz = t.rot;
	this.sx = this.sy = 0,50000000.0 + this.rand() % 15 * 0,10000000.0;
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx += 0,05000000.0;
	};
}

