function HitReset()
{
	this.hitTarget = {};
	this.hitResult = 0;
	this.hitInterval = 0;
}

function HitTargetReset()
{
	this.hitTarget = {};
	this.hitInterval = 0;
}

function HitCycleUpdate( interval = 0 )
{
	if (this.hitResult == 32)
	{
		this.hitTarget = {};
		this.hitResult = 0;
		this.hitInterval = 0;
		return true;
	}

	if (interval > 0)
	{
		this.hitInterval++;

		if (this.hitInterval >= interval)
		{
			this.hitTarget = {};
			this.hitInterval = 0;
			return true;
		}
	}

	return false;
}

function LabelClear()
{
	this.stateLabel = null;
	this.subState = null;
	this.keyAction = null;
	this.func = null;
	this.armorEvent = null;
	this.combo_func = null;

	if (this.lavelClearEvent)
	{
		this.lavelClearEvent.call(this);
		this.lavelClearEvent = null;
	}

	if (this.invin > 0)
	{
		this.invin = 0;
	}

	if (this.graze > 0)
	{
		this.graze = 0;
	}

	if (this.invinObject > 0)
	{
		this.invinObject = 0;
	}

	if (this.armor > 0)
	{
		this.armor = 0;
	}

	this.atkRate_Pat = 1.00000000;
	this.atk_id = 0;
	this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
}

function LabelReset()
{
	this.stateLabel = null;
	this.subState = null;
	this.keyAction = null;
	this.func = null;
	this.armorEvent = null;
}

function AjustField( x_, y_ )
{
	local wx_ = this.x;
	local wy_ = this.y;

	if (x_ && wx_ > ::battle.corner_right)
	{
		wx_ = ::battle.corner_right;
	}

	if (x_ && wx_ < ::battle.corner_left)
	{
		wx_ = ::battle.corner_left;
	}

	if (y_ && wy_ > ::battle.corner_gound)
	{
		wy_ = ::battle.corner_gound;
	}

	if (y_ && wy_ < ::battle.corner_top)
	{
		wy_ = ::battle.corner_top;
	}

	this.Warp(wx_, wy_);
}

function SetSpeed_XY( vx_, vy_ )
{
	if (vx_ != null)
	{
		this.va.x = vx_;
	}

	if (vy_ != null)
	{
		this.va.y = vy_;
	}

	this.ConvertTotalSpeed();
}

function SetSpeed_Vec( vec_, rot_, direction_ = 1.00000000 )
{
	this.va.x = vec_ * this.cos(rot_) * direction_;
	this.va.y = vec_ * this.sin(rot_);
	this.ConvertTotalSpeed();
}

function AddSpeed_XY( vx_, vy_, maxX_ = null, maxY_ = null )
{
	if (vx_ != null)
	{
		this.va.x += vx_;

		if (maxX_ != null)
		{
			if (vx_ > 0.00000000 && this.va.x > maxX_ || vx_ < 0.00000000 && this.va.x < maxX_)
			{
				this.va.x = maxX_;
			}
		}
	}

	if (vy_ != null)
	{
		this.va.y += vy_;

		if (maxY_ != null)
		{
			if (vy_ > 0.00000000 && this.va.y > maxY_ || vy_ < 0.00000000 && this.va.y < maxY_)
			{
				this.va.y = maxY_;
			}
		}
	}

	this.ConvertTotalSpeed();
}

function AddSpeed_Vec( vec_, rot_, max_, direction_ = 1.00000000 )
{
	if (rot_ == null)
	{
		if (this.va.x != 0.00000000 || this.va.y != 0.00000000)
		{
			rot_ = -this.atan2(-this.va.y, this.va.x * direction_);
		}
		else
		{
			rot_ = 0.00000000;
		}
	}

	local t_ = false;
	this.va.x += vec_ * this.cos(rot_) * direction_;
	this.va.y += vec_ * this.sin(rot_);

	if (max_ != null)
	{
		if (this.va.LengthXY() + vec_ >= max_)
		{
			this.va.SetLength(max_);
			t_ = true;
		}
	}

	this.ConvertTotalSpeed();
	return t_;
}

function VX_Brake( x_, min_ = null )
{
	local b_ = false;

	if (min_)
	{
		if (this.va.x > 0)
		{
			this.va.x -= x_;

			if (this.va.x <= min_)
			{
				this.va.x = min_;
				b_ = true;
			}
		}
		else
		{
			this.va.x -= -x_;

			if (this.va.x >= min_)
			{
				this.va.x = min_;
				b_ = true;
			}
		}
	}
	else if (this.fabs(this.va.x) >= x_)
	{
		this.va.x -= this.va.x > 0.00000000 ? x_ : -x_;
	}
	else
	{
		this.va.x = 0.00000000;
		b_ = true;
	}

	this.ConvertTotalSpeed();
	return b_;
}

function VY_Brake( y_, min_ = null )
{
	local b_ = false;

	if (min_)
	{
		if (this.va.y > 0)
		{
			this.va.y -= y_;

			if (this.va.y <= min_)
			{
				this.va.y = min_;
				b_ = true;
			}
		}
		else
		{
			this.va.y -= -y_;

			if (this.va.y >= min_)
			{
				this.va.y = min_;
				b_ = true;
			}
		}
	}
	else if (this.va.y * this.va.y >= y_ * y_)
	{
		this.va.y -= this.va.y > 0.00000000 ? y_ : -y_;
	}
	else
	{
		this.va.y = 0.00000000;
		b_ = true;
	}

	this.ConvertTotalSpeed();
	return b_;
}

function Vec_Brake( v_, min_ = 0.00000000 )
{
	local b_ = false;
	local vsq_ = this.va.LengthXY();

	if (vsq_ <= v_ + min_)
	{
		vsq_ = min_;
		b_ = true;
	}
	else
	{
		vsq_ = vsq_ - v_;
	}

	local R_ = -this.atan2(-this.va.y, this.va.x);
	this.va.x = vsq_ * this.cos(R_);
	this.va.y = vsq_ * this.sin(R_);
	this.ConvertTotalSpeed();
	return b_;
}

function Vec_Rotate( r_ )
{
	local vx_ = this.va.x * this.cos(r_) - this.va.y * this.sin(r_);
	local vy_ = this.va.x * this.sin(r_) + this.va.y * this.cos(r_);
	this.va.x = vx_;
	this.va.y = vy_;
	this.ConvertTotalSpeed();
}

function GetTargetAngle( target_, dir_ )
{
	if (target_)
	{
		local t = target_;

		if (t.isActive)
		{
			local d = this.atan2(t.y - this.y, (t.x - this.x) * dir_);
			return d;
		}
		else
		{
			return false;
		}
	}
	else
	{
		return false;
	}
}

function TargetHoming_Vec( target_, vec_, rotSpeed_, direction_ = 1.00000000 )
{
	if (!target_)
	{
		return false;
	}

	local t_ = target_;
	local tVec_ = this.Vector3();
	tVec_.x = (t_.x - this.x) * direction_;
	tVec_.y = t_.y - this.y;
	tVec_.Normalize();

	if (vec_.x * tVec_.x + vec_.y * tVec_.y >= this.cos(rotSpeed_))
	{
		return tVec_;
	}
	else if (vec_.x * tVec_.y - vec_.y * tVec_.x > 0)
	{
		vec_.RotateByRadian(rotSpeed_);
		return vec_;
	}
	else
	{
		vec_.RotateByRadian(-rotSpeed_);
		return vec_;
	}

	return false;
}

function TargetHoming( target_, rotSpeed_, direction_ = 1.00000000 )
{
	if (!target_)
	{
		return false;
	}

	local t_ = target_;
	local tVec_ = this.Vector3();
	tVec_.x = t_.x - this.x;
	tVec_.y = t_.y - this.y;
	tVec_.Normalize();
	local vVec_ = this.Vector3();
	vVec_.Set(this.va);
	vVec_.Normalize();

	if (vVec_.x * tVec_.x + vVec_.y * tVec_.y >= this.cos(rotSpeed_))
	{
		local v_ = this.va.LengthXY();
		tVec_.Mul(v_);
		this.va.Set(tVec_);
		this.ConvertTotalSpeed();
		return true;
	}
	else
	{
		if (vVec_.x * tVec_.y - vVec_.y * tVec_.x > 0)
		{
			this.va.RotateByRadian(rotSpeed_);
		}
		else
		{
			this.va.RotateByRadian(-rotSpeed_);
		}

		this.ConvertTotalSpeed();
	}
}

function PosHoming( pos_, rotSpeed_, direction_ = 1.00000000 )
{
	local tVec_ = this.Vector3();
	tVec_.x = pos_.x - this.x;
	tVec_.y = pos_.y - this.y;
	tVec_.Normalize();
	local vVec_ = this.Vector3();
	vVec_.Set(this.va);
	vVec_.Normalize();

	if (vVec_.x * tVec_.x + vVec_.y * tVec_.y >= this.cos(rotSpeed_))
	{
		local v_ = this.va.LengthXY();
		tVec_.Mul(v_);
		this.va.Set(tVec_);
		this.ConvertTotalSpeed();
		return true;
	}
	else
	{
		if (vVec_.x * tVec_.y - vVec_.y * tVec_.x > 0)
		{
			this.va.RotateByRadian(rotSpeed_);
		}
		else
		{
			this.va.RotateByRadian(-rotSpeed_);
		}

		this.ConvertTotalSpeed();
	}
}

