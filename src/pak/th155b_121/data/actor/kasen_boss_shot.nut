function Eagle_Catch_Boss( t )
{
	this.SetMotion(3019, 0);
	this.DrawActorPriority(180);
	this.PlaySE(3038);
	this.count = 0;
	this.flag5.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.rz = 0.00000000;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.owner.motion != 4910)
		{
			this.Eagle_Wait(null);
			return;
		}

		if (this.count % 40 == 24)
		{
			this.PlaySE(3040);
		}

		this.direction = this.team.current.direction;
		this.SetSpeed_XY((this.owner.x - this.x) * 0.10000000, (this.owner.y - 85 - this.y) * 0.10000000);

		if (this.va.Length() >= 12.00000000)
		{
			this.va.SetLength(12.00000000);
			this.SetSpeed_XY(null, null);
		}
	};
}

function Eagle_PreAssult_Boss( t )
{
	this.HitReset();
	this.DrawActorPriority(180);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3019, 5);
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4910)
		{
			this.Eagle_Wait(null);
			return;
		}

		this.direction = this.team.current.direction;
	};
}

function Eagle_Assult_Boss( t )
{
	this.HitReset();
	this.DrawActorPriority(180);
	this.count = 0;
	this.direction = t.direction;
	this.rz = 0.52359873;
	this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.PlaySE(3041);
	this.SetMotion(3019, 17);
	local t_ = {};
	t_.rot <- this.rz;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_AuraF, t_);
	this.flag5.Add(a_);
	a_.SetParent(this, 0, 0);
	this.subState = function ()
	{
		if (this.team.current.IsDamage())
		{
			this.flag5.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.rz = 0.00000000;
			this.SetMotion(3019, 7);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.Vec_Brake(0.75000000);

				if (this.count >= 60)
				{
					this.Eagle_Wait(null);
				}
			};
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.flag5.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Aura, t_));
			this.SetFreeObject(this.x + 50 - this.rand() % 100, this.y + 50 - this.rand() % 100, this.direction, this.SPShot_B_Feather, {});
		}

		if (this.count == 35)
		{
			this.flag5.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.rz = 0.00000000;
			this.SetMotion(3019, 9);
			this.count = 0;
			this.flag2 = 30 * 0.01745329;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.flag2 -= 0.01745329 * 0.50000000;
				this.rz += this.flag2;
				this.Vec_Brake(1.50000000);
				this.count++;

				if (this.count >= 20)
				{
					if (this.team.master.com_flag3.len() > 0 && this.team.master.com_flag3[0])
					{
						local t_ = {};
						t_.direction <- this.owner.target.x > this.x ? 1.00000000 : -1.00000000;
						this.Eagle_AssultBall_Boss(t_);
					}
					else
					{
						this.Eagle_Wait(null);
					}
				}
			};
			return;
		}
	};
}

function Eagle_AssultBall_Boss( t )
{
	if (this.team.master.com_flag3.len() <= 0)
	{
		this.Eagle_Wait(null);
		return;
	}

	if (this.team.master.com_flag3[0] == null)
	{
		this.Eagle_Wait(null);
		return;
	}

	this.HitReset();
	this.DrawActorPriority(180);
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag3 = this.team.master.com_flag3[0].weakref();
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag3.x;
	this.flag2.y = this.flag3.y;
	this.direction = this.flag3.x > this.x ? 1.00000000 : -1.00000000;
	this.rz = this.atan2(this.flag3.y - this.y, (this.flag3.x - this.x) * this.direction);

	switch(this.team.master.com_difficulty)
	{
	case 0:
		this.SetSpeed_Vec(15.00000000, this.rz, this.direction);
		break;

	case 1:
		this.SetSpeed_Vec(17.50000000, this.rz, this.direction);
		break;

	case 2:
		this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
		break;

	case 3:
	case 4:
		this.SetSpeed_Vec(25.00000000, this.rz, this.direction);
		break;
	}

	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.PlaySE(3041);
	local t_ = {};
	t_.rot <- this.rz;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_AuraF, t_);
	this.flag5.Add(a_);
	a_.SetParent(this, 0, 0);
	this.SetMotion(3019, 17);
	this.subState = function ()
	{
		if (this.team.current.IsDamage())
		{
			this.flag5.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.rz = 0.00000000;
			this.SetMotion(3019, 7);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.Vec_Brake(0.75000000);

				if (this.count >= 60)
				{
					this.Eagle_Wait(null);
				}
			};
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.flag5.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Aura, t_));
			this.SetFreeObject(this.x + 50 - this.rand() % 100, this.y + 50 - this.rand() % 100, this.direction, this.SPShot_B_Feather, {});
		}

		if (this.flag3)
		{
			local tPos_ = this.Vector3();
			tPos_.x = this.flag2.x - this.x;
			tPos_.y = this.flag2.y - this.y;

			if (tPos_.Length() <= 150)
			{
				this.flag1.x = this.flag3.x - this.x;
				this.flag1.y = this.flag3.y - this.y;

				if (this.flag1.Length() <= 150)
				{
					this.flag5.Foreach(function ()
					{
						this.func[0].call(this);
					});

					switch(this.team.master.com_difficulty)
					{
					case 1:
						this.PlaySE(3078);

						for( local i = 0; i < 6; i++ )
						{
							local t_ = {};
							t_.v <- 6.00000000;
							t_.rot <- i * 1.04719746;
							this.SetShot(this.flag3.x, this.flag3.y, this.direction, this.Eagle_Shot_Boss, t_);
						}

						break;

					case 2:
						this.PlaySE(3078);

						for( local i = 0; i < 8; i++ )
						{
							local t_ = {};
							t_.v <- 6.00000000;
							t_.rot <- i * 0.78539813;
							this.SetShot(this.flag3.x, this.flag3.y, this.direction, this.Eagle_Shot_Boss, t_);
						}

						break;

					case 3:
					case 4:
						this.PlaySE(3078);

						for( local i = 0; i < 8; i++ )
						{
							local t_ = {};
							t_.v <- 6.00000000;
							t_.rot <- i * 0.78539813;
							this.SetShot(this.flag3.x, this.flag3.y, this.direction, this.Eagle_Shot_Boss, t_);
						}

						for( local i = 0; i < 8; i++ )
						{
							local t_ = {};
							t_.v <- 4.00000000;
							t_.rot <- (22.50000000 + i * 45) * 0.01745329;
							this.SetShot(this.flag3.x, this.flag3.y, this.direction, this.Eagle_Shot_Boss, t_);
						}

						break;
					}

					this.flag3.func[0].call(this.flag3);

					if (this.team.master.com_flag3.len() >= 2)
					{
						this.team.master.com_flag3.remove(0);
						this.flag3 = this.team.master.com_flag3[0];
					}
					else
					{
						this.flag3 = null;
					}

					this.SetSpeed_Vec(12.00000000, this.rz, this.direction);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							return;
						}

						this.count++;

						if (this.count == 10)
						{
							this.rz = 0.00000000;
							this.SetMotion(3019, 9);
							this.count = 0;
							this.flag2 = 30 * 0.01745329;
							this.stateLabel = function ()
							{
								if (this.subState())
								{
									return;
								}

								this.flag2 -= 0.01745329 * 0.50000000;
								this.rz += this.flag2;
								this.Vec_Brake(1.50000000);
								this.count++;

								if (this.count >= 25)
								{
									if (this.flag3)
									{
										this.Eagle_AssultBall_Boss(null);
									}
									else
									{
										this.Eagle_Wait(null);
									}
								}
							};
							return;
						}
					};
				}
				else
				{
					this.flag3.func[0].call(this.flag3);
					this.rz = 0.00000000;
					this.SetMotion(3019, 7);
					this.flag5.Foreach(function ()
					{
						this.func[0].call(this);
					});
					this.stateLabel = function ()
					{
						this.count++;
						this.Vec_Brake(0.75000000);

						if (this.count >= 60)
						{
							this.Eagle_Wait(null);
						}
					};
				}
			}
		}
		else
		{
			this.rz = 0.00000000;
			this.SetMotion(3019, 7);
			this.flag5.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.stateLabel = function ()
			{
				this.count++;
				this.Vec_Brake(0.75000000);

				if (this.count >= 60)
				{
					this.Eagle_Wait(null);
				}
			};
		}
	};
}

function Eagle_Shot_Boss( t )
{
	this.SetMotion(4919, 0);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 1);
			this.sx = this.sy = 3.00000000;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.sx = this.sy = 3.00000000;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (1.00000000 - this.sx) * 0.15000001;
	};
}

function Boss_Shot_MS2_Charge( t )
{
	this.SetMotion(4959, 1);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = function ()
	{
		this.ReleaseActor();
	};
}

function Boss_Shot_MS2_Common( t )
{
	this.SetMotion(4959, 4);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetMotion(4959, 5);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.15000001;
				this.sx = this.sy *= 0.85000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.count >= 420)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.subState();
	};
}

function Boss_Shot_MS2( t )
{
	this.Boss_Shot_MS2_Common(t);
	this.SetSpeed_Vec(20.00000000, t.rot, this.direction);
	this.va.y *= 0.25000000;
	this.va.RotateByRadian(t.rot2);
	this.sx = this.sy = 0.75000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.ConvertTotalSpeed();
	this.flag1 = 0.00000000;
	this.flag2 = this.Vector3();
	this.flag2.x = this.va.x * 0.05000000;
	this.flag2.y = this.va.y * 0.05000000;

	if (this.owner.com_difficulty >= 4)
	{
		this.flag5 = 0.04500000;
	}
	else
	{
		this.flag5 = this.owner.com_difficulty * 0.01500000;
	}

	this.subState = function ()
	{
		if (this.count <= 45)
		{
			this.SetSpeed_XY(this.va.x * 0.94999999, this.va.y * 0.94999999);
		}

		if (this.count >= this.initTable.wait)
		{
			this.SetMotion(this.motion, 6);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag2.x, this.flag2.y);
				this.sx = this.sy += this.flag5;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			};
		}
	};
}

function Boss_Shot_MS2_ReimuLine( t )
{
	this.SetMotion(4959, 8);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
}

function Boss_Shot_MS2_Reimu( t )
{
	this.SetMotion(4959, 7);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(15.00000000, t.rot, this.direction);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.hitResult = 128;
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.SetMotion(4959, 5);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.15000001;
				this.sx = this.sy *= 0.85000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.hitCount = 0;
			this.flag2 = (60 - this.rand() % 121) * 0.01745329;
			local t_ = {};
			t_.rot <- this.flag2;
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS2_ReimuLine, t_);
			this.flag1++;

			if (this.flag1 > 3)
			{
				this.subState = function ()
				{
					if (this.count == 30)
					{
						this.PlaySE(3031);
						this.SetSpeed_Vec(20.00000000, this.flag2, this.direction);
						this.sx = this.sy = 3.50000000;
					}

					this.sx = this.sy += (1.50000000 - this.sx) * 0.10000000;
					this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				};
			}
			else
			{
				this.subState = function ()
				{
					if (this.count == 30)
					{
						this.PlaySE(3031);
						this.SetSpeed_Vec(20.00000000, this.flag2, this.direction);
						this.sx = this.sy = 2.75000000;
					}

					if (this.va.y < 0.00000000 && this.y < ::battle.scroll_top || this.va.y > 0.00000000 && this.y > ::battle.scroll_bottom)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					this.sx = this.sy += (1.50000000 - this.sx) * 0.10000000;
					this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

					if (this.count >= 40)
					{
						this.Vec_Brake(1.00000000, 1.00000000);
					}

					if (this.count == 60)
					{
						this.func[1].call(this);
					}
				};
			}
		}
	];
	this.cancelCount = 3;
	this.subState = function ()
	{
		this.sx = this.sy += (2.00000000 - this.sx) * 0.10000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.count >= 10)
		{
			this.Vec_Brake(1.00000000, 1.00000000);
		}

		if (this.count == 30)
		{
			this.func[1].call(this);
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(15);
		}

		this.count++;
		this.subState();
	};
}

function Boss_Shot_MS2B( t )
{
	this.SetMotion(4959, 4);
	this.owner.shot_actor.Add(this);
	this.rz = this.rand() % 360 * 0.01745329;
	this.func = [
		function ()
		{
			this.SetMotion(4959, 5);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.15000001;
				this.sx = this.sy *= 0.85000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4959, 11);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
					return;
				}
			};
		},
		function ()
		{
			this.SetMotion(4959, 12);
			this.SetSpeed_XY(this.va.x * 10.00000000, this.va.y * 10.00000000);
			this.cancelCount = 3;
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag2.x * 0.20000000, this.flag2.y * 0.20000000);
				this.sx = this.sy += (this.flag3 - this.sx) * 0.10000000;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			};
			this.stateLabel = function ()
			{
				if (this.IsScreen(200))
				{
					this.ReleaseActor();
					return;
				}

				this.HitCycleUpdate(10);

				if (this.hitCount > 0 || this.cancelCount <= 0 || this.count >= 420)
				{
					this.func[0].call(this);
					return;
				}

				this.count++;
				this.subState();
			};
		}
	];
	this.cancelCount = 3;
	this.SetSpeed_Vec(20.00000000, t.rot, this.direction);
	this.va.y *= 0.25000000;
	this.va.RotateByRadian(t.rot2);
	this.sx = this.sy = 0.75000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.ConvertTotalSpeed();
	this.flag1 = 0.00000000;
	this.flag2 = this.Vector3();
	this.flag2.x = this.va.x * 0.05000000;
	this.flag2.y = this.va.y * 0.05000000;

	if (this.owner.com_difficulty >= 4)
	{
		this.flag3 = 2.75000000;
		this.flag5 = 0.04500000;
	}
	else
	{
		this.flag3 = 2.00000000 + this.owner.com_difficulty * 0.25000000;
		this.flag5 = this.owner.com_difficulty * 0.01500000;
	}

	this.subState = function ()
	{
		if (this.count <= 45)
		{
			this.SetSpeed_XY(this.va.x * 0.94999999, this.va.y * 0.94999999);
		}

		if (this.count >= this.initTable.wait)
		{
			this.SetMotion(this.motion, 6);
			this.subState = function ()
			{
				this.AddSpeed_XY(this.flag2.x, this.flag2.y);
				this.sx = this.sy += this.flag5;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0 || this.count >= 420)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
		this.subState();
	};
}

function Boss_Shot_MS3( t )
{
	this.SetMotion(4969, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 99;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

	if (this.owner.com_difficulty >= 3)
	{
		this.atkRate_Pat = 2.00000000;
	}
	else
	{
		this.atkRate_Pat = 1.00000000 + this.owner.com_difficulty * 0.33000001;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.05000000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetSpeed_Vec(3.00000000, this.initTable.rot, this.direction);
			this.stateLabel = function ()
			{
				this.cancelCount = 99;
				local s_ = (this.initTable.scale - this.sx) * 0.10000000;
				this.sx = this.sy += s_;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.HitCycleUpdate(30);
			};
		},
		function ()
		{
			this.SetMotion(4969, 2);
			this.SetSpeed_Vec(6.00000000, 1.04719746, this.direction);
			::camera.Shake(10.00000000);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200 * this.sx))
				{
					this.ReleaseActor();
					return;
				}

				this.cancelCount = 99;
				this.rz += 0.06981317;

				if (this.va.y > 0 && this.y > ::battle.scroll_bottom || this.va.y < 0 && this.y < ::battle.scroll_top)
				{
					::camera.Shake(6.00000000);
					this.SetSpeed_XY(this.va.x, -this.va.y);
					this.PlaySE(1108);
				}

				this.HitCycleUpdate(30);
			};
			this.func[2] = function ()
			{
			};
		},
		function ()
		{
			this.SetMotion(4969, 2);
			this.SetSpeed_Vec(6.00000000, 0.26179937, this.direction);
			::camera.Shake(10.00000000);
			this.stateLabel = function ()
			{
				if (this.IsScreen(200 * this.sx))
				{
					this.ReleaseActor();
					return;
				}

				this.cancelCount = 99;
				this.rz += 0.06981317;

				if (this.va.x > 0 && this.x > ::battle.scroll_right || this.va.x < 0 && this.x < ::battle.scroll_left)
				{
					::camera.Shake(6.00000000);
					this.SetSpeed_XY(-this.va.x, this.va.y);
					this.PlaySE(1108);
				}

				this.HitCycleUpdate(30);
			};
			this.func[2] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		local s_ = (this.initTable.scale - this.sx) * 0.10000000;
		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.SetSpeed_Vec(s_ * 60, this.initTable.rot, this.direction);
		this.HitCycleUpdate(30);
	};
}

function Boss_Shot_MS3B( t )
{
	this.SetMotion(4969, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 99;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

	if (this.owner.com_difficulty >= 3)
	{
		this.atkRate_Pat = 2.00000000;
	}
	else
	{
		this.atkRate_Pat = 1.00000000 + this.owner.com_difficulty * 0.33000001;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.05000000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetSpeed_Vec(3.00000000, this.initTable.rot, this.direction);
			this.stateLabel = function ()
			{
				this.cancelCount = 99;
				local s_ = (this.initTable.scale - this.sx) * 0.10000000;
				this.sx = this.sy += s_;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.HitCycleUpdate(30);
			};
		},
		function ()
		{
			this.SetMotion(4969, 1);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			::camera.Shake(10.00000000);
			this.flag1 = 0.30000001;
			this.stateLabel = function ()
			{
				this.sx = this.sy += this.flag1;
				this.flag1 -= 0.03000000;

				if (this.flag1 < 0.01000000)
				{
					this.flag1 = 0.01000000;
				}

				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[2] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		local s_ = (this.initTable.scale - this.sx) * 0.10000000;
		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.SetSpeed_Vec(s_ * 60, this.initTable.rot, this.direction);
		this.HitCycleUpdate(30);
	};
}

function Boss_Shot_DS1( t )
{
	this.SetMotion(4959, 4);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.hitResult = 128;
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.SetMotion(4959, 5);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.15000001;
				this.sx = this.sy *= 0.85000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.hitCount = 0;
			this.rz = this.initTable.rot2;
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS2_ReimuLine, t_);
			this.subState = function ()
			{
				if (this.count == 30)
				{
					this.SetMotion(4959, 10);
					this.PlaySE(3031);
					this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
					this.sx = this.sy = 3.50000000;
				}

				this.sx = this.sy += (1.50000000 - this.sx) * 0.10000000;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			};
		}
	];
	this.cancelCount = 3;
	this.subState = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.92000002, this.va.y * 0.92000002);
		this.sx = this.sy += (1.25000000 - this.sx) * 0.10000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.count == this.initTable.wait)
		{
			this.func[1].call(this);
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(5);
		}

		this.count++;
		this.subState();
	};
}

function Boss_Shot_DS1B( t )
{
	this.SetMotion(4959, 13);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 0.50000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.hitResult = 128;
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.SetMotion(4959, 14);
			this.SetSpeed_XY(this.va.x * 0.10000000, this.va.y * 0.10000000);
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green -= 0.15000001;
				this.sx = this.sy *= 0.85000002;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.hitCount = 0;
			this.rz = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS2_ReimuLine, t_);
			this.subState = function ()
			{
				if (this.count == 30)
				{
					this.SetMotion(4959, 15);
					this.PlaySE(3031);
					this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
					this.sx = this.sy = 3.50000000;
				}

				this.sx = this.sy += (1.50000000 - this.sx) * 0.10000000;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			};
		}
	];
	this.cancelCount = 3;
	this.subState = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.92000002, this.va.y * 0.92000002);
		this.sx = this.sy += (1.25000000 - this.sx) * 0.10000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.count == this.initTable.wait)
		{
			this.func[1].call(this);
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(300))
		{
			this.ReleaseActor();
			return;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(5);
		}

		this.count++;
		this.subState();
	};
}

function Boss_Shot_DS2( t )
{
	this.SetMotion(4969, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 99;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

	if (this.owner.com_difficulty >= 3)
	{
		this.atkRate_Pat = 2.00000000;
	}
	else
	{
		this.atkRate_Pat = 1.00000000 + this.owner.com_difficulty * 0.33000001;
	}

	this.flag1 = 25;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag1 = 20;
		break;

	case 2:
		this.flag1 = 15;
		break;

	case 3:
	case 4:
		this.flag1 = 10;
		break;
	}

	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.05000000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetSpeed_Vec(3.00000000, this.initTable.rot, this.direction);
			this.stateLabel = function ()
			{
				this.cancelCount = 99;
				this.sx = this.sy += this.initTable.scale_speed;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
				this.HitCycleUpdate(30);
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 2);
			local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			r_ = this.Math_MinMax(r_, -75 * 0.01745329, -0.52359873);
			this.SetSpeed_Vec(4.00000000, r_, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(0))
				{
					this.Vec_Brake(0.50000000, 1.00000000);
				}

				this.cancelCount = 99;
				this.rz += 0.06981317;
				this.HitCycleUpdate(30);
			};
			this.func[2] = function ()
			{
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 2);
			local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			r_ = this.Math_MinMax(r_, 0.17453292, 1.04719746);
			this.SetSpeed_Vec(4.00000000, r_, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(0))
				{
					this.Vec_Brake(0.50000000, 1.00000000);
				}

				this.cancelCount = 99;
				this.rz += 0.06981317;
				this.HitCycleUpdate(30);
			};
			this.func[3] = function ()
			{
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
		}
	];
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		local s_ = (this.initTable.scale - this.sx) * 0.05000000;
		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.SetSpeed_Vec(s_ * 60, this.initTable.rot, this.direction);
		this.HitCycleUpdate(30);
		this.count++;

		if (this.flag1 > 0 && this.count % this.flag1 == 1)
		{
			local t_ = {};
			t_.rot <- this.rand() % 360 * 0.01745329;
			t_.v <- 5.00000000 + this.rand() % 31 * 0.10000000;
			t_.scale <- this.sx;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS2_Ball, t_);
		}
	};
}

function Boss_Shot_DS2_Flash( t )
{
	this.SetMotion(4969, 1);
	this.DrawActorPriority(201);
	this.alpha = 0.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.02000000;
		this.alpha += 0.10000000;

		if (this.alpha >= 1.00000000)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.02000000;
				this.alpha -= 0.03300000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Boss_Shot_DS2_Ball( t )
{
	this.SetMotion(4969, 5);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.cancelCount = 3;
	this.flag1 = 0.06981317;

	if (this.rand() % 100 <= 49)
	{
		this.flag1 = -this.flag1;
	}

	this.SetTrail(this.motion, 7);
	this.flag2 = 1;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag2 = 3;
		break;

	case 2:
		this.flag2 = 6;
		break;

	case 3:
	case 4:
		this.flag2 = 10;
		break;
	}

	this.func = [
		function ()
		{
			if (this.linkObject[0])
			{
				this.linkObject[0].ReleaseActor();
				this.linkObject = null;
			}

			this.SetMotion(4969, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.99500000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(300) || this.hitCount > 0 || this.grazeCount >= this.flag2 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.va.RotateByRadian(this.flag1);
		this.ConvertTotalSpeed();
		this.flag1 *= 0.99000001;
		this.rz += 0.05235988;
		this.HitCycleUpdate(1);
	};
}

function Boss_Shot_DS3( t )
{
	this.SetMotion(4969, 0);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.owner.shot_actor.Add(this);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 99;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.flag1 = 5;
	this.flag2 = -1.57079601;
	this.func = [
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 1);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.05000000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.SetMotion(4969, 2);
			this.SetSpeed_Vec(4.00000000, 0.78539813, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.IsScreen(0))
				{
					this.Vec_Brake(0.50000000, 1.00000000);
				}

				this.cancelCount = 99;
				this.rz += 0.06981317;
				this.HitCycleUpdate(30);
				this.count++;

				if (this.flag1 > 0 && this.count % this.flag1 == 1)
				{
					local t_ = {};
					t_.rot <- this.flag2;
					t_.v <- 5.00000000 + this.rand() % 31 * 0.10000000;
					t_.scale <- this.sx;
					this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS2_Ball, t_);
					this.flag2 += (15 + this.rand() % 6) * 0.01745329;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.cancelCount = 99;
		local s_ = (3.50000000 - this.sx) * 0.05000000;
		this.sx = this.sy += s_;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.SetSpeed_Vec(s_ * 60, this.initTable.rot, this.direction);
		this.HitCycleUpdate(30);
		this.count++;

		if (this.flag1 > 0 && this.count % this.flag1 == 1)
		{
			local t_ = {};
			t_.rot <- this.flag2;
			t_.v <- 3.50000000;
			t_.scale <- this.sx;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_DS2_Ball_OD, t_);
			this.flag2 += (15 + this.rand() % 3) * 0.01745329;
		}
	};
}

function Boss_Shot_DS2_Ball_OD( t )
{
	this.SetMotion(4969, 5);
	this.owner.shot_actor.Add(this);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.cancelCount = 3;
	this.flag1 = 0.03490658;

	if (this.rand() % 100 <= 49)
	{
		this.flag1 = -this.flag1;
	}

	this.SetTrail(this.motion, 7);
	this.flag2 = 1;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag2 = 2;
		break;

	case 2:
		this.flag2 = 3;
		break;

	case 3:
	case 4:
		this.flag2 = 4;
		break;
	}

	this.func = [
		function ()
		{
			if (this.linkObject[0])
			{
				this.linkObject[0].ReleaseActor();
				this.linkObject = null;
			}

			this.SetMotion(4969, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.99500000;
				this.alpha = this.red = this.green -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(300) || this.hitCount > 0 || this.grazeCount >= this.flag2 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.va.RotateByRadian(this.flag1);
		this.ConvertTotalSpeed();
		this.flag1 *= 0.99000001;
		this.rz += 0.05235988;
		this.HitCycleUpdate(1);
	};
}

