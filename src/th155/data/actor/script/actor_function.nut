function KeyActionCheck()
{
	if (this.keyAction != null)
	{
		if (typeof this.keyAction == "array")
		{
			if (this.keyAction.len() > this.keyTake)
			{
				if (this.keyAction[this.keyTake])
				{
					this.keyAction[this.keyTake].call(this);
				}
			}
		}
		else
		{
			this.keyAction.call(this);
		}
	}
}

function Math_MinMax( a_, min_, max_ )
{
	if (min_ != null)
	{
		if (a_ < min_)
		{
			return min_;
		}
	}

	if (max_ != null)
	{
		if (a_ > max_)
		{
			return max_;
		}
	}

	return a_;
}

function Math_Bezier( s_, g_, c_, rate_ )
{
	if (rate_ >= 1.00000000)
	{
		return g_;
	}

	if (rate_ <= 0.00000000)
	{
		return s_;
	}

	local r1_ = 1 - rate_;
	return r1_ * r1_ * s_ + 2 * r1_ * rate_ * c_ + rate_ * rate_ * g_;
}

function Math_ShotPath( V, G, Pos_, Target_ )
{
	local X = (Target_.x - Pos_.x) * this.direction;
	local Y = -Target_.y + Pos_.y;
	local A = -G * X * X / (2 * V * V);
	local A2 = X / A;
	local B = -Y / A + 1;
	local Check_ = -B + A2 * A2 * 0.25000000;
	local t = [];

	if (Check_ < 0)
	{
		return null;
	}
	else if (Check_ == 0)
	{
		t.append(-A2 * 0.50000000);
	}
	else
	{
		local Check_root = this.sqrt(Check_);
		t.append(-A2 * 0.50000000 + Check_root);
		t.append(-A2 * 0.50000000 - Check_root);
	}

	return t;
}

