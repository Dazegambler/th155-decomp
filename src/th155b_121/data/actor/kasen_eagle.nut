function Eagle_BeginBattle( t )
{
	this.SetMotion(3019, 16);
	this.DrawActorPriority(180);
	this.SetCollisionRotation(0.00000000, 0.00000000, 0.00000000);
	this.rz = 0.00000000;
	this.flag5 = ::manbow.Actor2DProcGroup();
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 40 == 24)
		{
			this.PlaySE(3040);
		}

		this.direction = this.team.current.direction;
		this.SetSpeed_XY((this.team.current.x - this.x) * 0.50000000, (this.team.current.y - 85 - this.y) * 0.50000000);

		if (this.va.Length() >= 25.00000000)
		{
			this.va.SetLength(25.00000000);
			this.SetSpeed_XY(null, null);
		}
	};
}

function Eagle_Lose( t )
{
	this.SetMotion(3019, 11);
	this.DrawActorPriority(180);
	this.SetCollisionRotation(0.00000000, 0.00000000, 0.00000000);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.rz = 0.00000000;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 1.50000000);
	};
	this.keyAction = function ()
	{
		this.SetSpeed_XY(0.00000000, this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.VY_Brake(1.25000000);
		};
	};
}

function Eagle_Wait( t )
{
	this.SetMotion(3019, 16);
	this.DrawActorPriority(180);
	this.SetCollisionRotation(0.00000000, 0.00000000, 0.00000000);
	this.rz = 0.00000000;
	this.flag5 = ::manbow.Actor2DProcGroup();
	this.stateLabel = function ()
	{
		if (::battle.state == 2)
		{
			return;
		}

		this.direction = this.team.current.direction;
		this.SetSpeed_XY((this.team.current.x - 75 * this.team.current.direction - this.x) * 0.10000000, (this.team.current.y - 100 - this.y) * 0.10000000);

		if (this.va.Length() >= 8.00000000)
		{
			this.va.SetLength(8.00000000);
			this.SetSpeed_XY(null, null);
		}
	};
}

function Eagle_Catch( t )
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

		if (this.owner.motion != 3010 && this.owner.motion != 3011 && this.owner.motion != 3012)
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

function Eagle_PreAssult( t )
{
	this.HitReset();
	this.DrawActorPriority(180);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3019, 5);
	this.stateLabel = function ()
	{
		if (this.owner.motion != 3013)
		{
			this.Eagle_Wait(null);
			return;
		}

		this.direction = this.team.current.direction;
	};
}

function Eagle_Assult( t )
{
	this.HitReset();
	this.atk_id = 2097152;
	this.DrawActorPriority(180);
	this.count = 0;
	this.direction = t.direction;
	this.rz = this.atan2(this.owner.target.y - this.y, (this.team.current.target.x - this.x) * this.direction);
	this.rz = this.Math_MinMax(this.rz, -70 * 0.01745329, 70 * 0.01745329);
	this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.PlaySE(3041);

	if (this.cos(this.rz) >= 0.86600000)
	{
		this.SetMotion(3019, 2);
	}
	else if (this.rz < 0.00000000)
	{
		this.SetMotion(3019, 1);
	}
	else
	{
		this.SetMotion(3019, 3);
	}

	local t_ = {};
	t_.rot <- this.rz;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_AuraF, t_);
	this.flag5.Add(a_);
	a_.SetParent(this, 0, 0);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.flag5.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Aura, t_));
			this.SetFreeObject(this.x + 50 - this.rand() % 100, this.y + 50 - this.rand() % 100, this.direction, this.SPShot_B_Feather, {});
		}

		if (this.count == 35 || this.owner.IsDamage())
		{
			this.flag5.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.rz = 0.00000000;
			this.SetMotion(3019, 7);
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

function Eagle_MarkAssult( t )
{
	this.HitReset();
	this.DrawActorPriority(180);
	this.count = 0;
	this.atk_id = 2097152;
	this.direction = this.owner.mark[0].x > this.x ? 1.00000000 : -1.00000000;
	this.rz = this.atan2(this.owner.mark[0].y - this.y, (this.owner.mark[0].x - this.x) * this.direction);
	this.flag1 = this.Vector3();
	this.flag2 = this.Vector3();
	this.flag2.x = this.owner.mark[0].x;
	this.flag2.y = this.owner.mark[0].y;
	this.SetSpeed_Vec(20.00000000, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.PlaySE(3041);
	local t_ = {};
	t_.rot <- this.rz;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_AuraF, t_);
	this.flag5.Add(a_);
	a_.SetParent(this, 0, 0);

	if (this.cos(this.rz) >= 0.86600000)
	{
		this.SetMotion(3019, 2);
	}
	else if (this.rz < 0.00000000)
	{
		this.SetMotion(3019, 1);
	}
	else
	{
		this.SetMotion(3019, 3);
	}

	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 2 == 1)
		{
			local t_ = {};
			t_.rot <- this.rz;
			this.flag5.Add(this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Aura, t_));
			this.SetFreeObject(this.x + 50 - this.rand() % 100, this.y + 50 - this.rand() % 100, this.direction, this.SPShot_B_Feather, {});
		}

		if (this.owner.mark.len() > 0 && this.owner.mark[0])
		{
			local tPos_ = this.Vector3();
			tPos_.x = this.flag2.x - this.x;
			tPos_.y = this.flag2.y - this.y;

			if (tPos_.Length() <= 35)
			{
				this.flag1.x = this.owner.mark[0].x - this.x;
				this.flag1.y = this.owner.mark[0].y - this.y;

				if (this.flag1.Length() <= 45)
				{
					this.flag5.Foreach(function ()
					{
						this.func[0].call(this);
					});
					this.owner.mark[0].func[1].call(this.owner.mark[0]);
					this.rz = 0.00000000;
					this.SetMotion(3019, 9);
					this.count = 0;
					this.flag2 = 30 * 0.01745329;
					this.stateLabel = function ()
					{
						this.flag2 -= 0.01745329 * 0.50000000;
						this.rz += this.flag2;
						this.Vec_Brake(1.50000000);
						this.count++;

						if (this.count >= 20)
						{
							local t_ = {};
							t_.direction <- this.owner.target.x > this.x ? 1.00000000 : -1.00000000;
							this.Eagle_Assult(t_);
						}
					};
					return;
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
			}
		}
	};
}

function Eagle_MarkAssultB( t )
{
	if (this.keyTake != 16)
	{
		return false;
	}

	this.HitReset();
	this.DrawActorPriority(180);
	this.count = 0;
	this.atk_id = 2097152;
	this.flag1 = this.Vector3();
	this.flag3 = t.weakref();
	this.flag2 = this.Vector3();
	this.flag2.x = this.flag3.x;
	this.flag2.y = this.flag3.y;
	this.direction = this.flag3.x > this.x ? 1.00000000 : -1.00000000;
	this.rz = this.atan2(this.flag3.y - this.y, (this.flag3.x - this.x) * this.direction);
	this.SetSpeed_Vec(25.00000000, this.rz, this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.PlaySE(3041);
	local t_ = {};
	t_.rot <- this.rz;
	local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_AuraF, t_);
	this.flag5.Add(a_);
	a_.SetParent(this, 0, 0);

	if (this.cos(this.rz) >= 0.98500001)
	{
		this.SetMotion(3019, 14);
	}
	else if (this.rz < 0.00000000)
	{
		this.SetMotion(3019, 13);
	}
	else
	{
		this.SetMotion(3019, 15);
	}

	this.stateLabel = function ()
	{
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
					this.flag3.func[0].call(this.flag3);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.count++;

						if (this.count == 10)
						{
							this.rz = 0.00000000;
							this.SetMotion(3019, 9);
							this.count = 0;
							this.flag2 = 30 * 0.01745329;
							this.stateLabel = function ()
							{
								this.flag2 -= 0.01745329 * 0.50000000;
								this.rz += this.flag2;
								this.Vec_Brake(1.50000000);
								this.count++;

								if (this.count >= 45)
								{
									this.Eagle_Wait(null);
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

