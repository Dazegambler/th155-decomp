function DrawActorPriority( priority_ = null )
{
	if (priority_ == null)
	{
		this.ConnectRenderSlot(::graphics.slot.actor, this.drawPriority);
	}
	else
	{
		this.ConnectRenderSlot(::graphics.slot.actor, priority_);
		this.drawPriority = priority_;
	}
}

function DrawScreenActorPriority( priority_ = null )
{
	if (priority_ == null)
	{
		this.ConnectRenderSlot(::graphics.slot.info, this.drawPriority);
	}
	else
	{
		this.ConnectRenderSlot(::graphics.slot.info, priority_);
		this.drawPriority = priority_;
	}
}

function DrawBackActorPriority( priority_ = null )
{
	if (priority_ == null)
	{
		this.ConnectRenderSlot(::graphics.slot.info_back, this.drawPriority);
	}
	else
	{
		this.ConnectRenderSlot(::graphics.slot.info_back, priority_);
		this.drawPriority = priority_;
	}
}

function FadeOut( r_, g_, b_, time_ )
{
	this.ClearFadeEffect();
	local t_ = {};
	t_.init <- this.EF_FadeScreen;
	t_.pare <- this.weakref();
	this.team.fade_screen = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.fade_screen, 1,00000000.0, r_, g_, b_);
	this.EF_BeginFadeOut.call(this.team.fade_screen, 0, time_);
}

function FadeIn( r_, g_, b_, time_ )
{
	this.ClearFadeEffect();
	local t_ = {};
	t_.init <- this.EF_FadeScreen;
	t_.pare <- this.weakref();
	this.team.fade_screen = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.fade_screen, 1,00000000.0, r_, g_, b_);
	this.EF_BeginFadeIn.call(this.team.fade_screen, 0, time_);
}

function ClearFadeEffect()
{
	if (this.team.fade_screen)
	{
		this.team.fade_screen.Release();
		this.team.fade_screen = null;
	}
}

function BackFadeOut( r_, g_, b_, time_ )
{
	this.ClearBackFadeEffect();
	local t_ = {};
	t_.init <- this.EF_FadeBackScreen;
	t_.pare <- this.weakref();
	this.team.fade_back = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.fade_back, 1,00000000.0, r_, g_, b_);
	this.EF_BeginFadeOut.call(this.team.fade_back, 0, time_);
}

function BackFadeIn( r_, g_, b_, time_ )
{
	this.ClearBackFadeEffect();
	local t_ = {};
	t_.init <- this.EF_FadeBackScreen;
	t_.pare <- this.weakref();
	this.team.fade_back = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.fade_back, 1,00000000.0, r_, g_, b_);
	this.EF_BeginBackFadeIn.call(this.team.fade_back, 0, time_);
}

function ClearBackFadeEffect()
{
	if (this.team.fade_back)
	{
		this.team.fade_back.Release();
		this.team.fade_back = null;
	}
}

function BackColorFilter( a_, r_, g_, b_, time_ )
{
	this.ClearColorFilterEffect();
	local t_ = {};
	t_.init <- this.EF_FadeBackScreen;
	t_.pare <- this.weakref();
	this.team.color_back = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.color_back, a_, r_, g_, b_);
	this.EF_BeginFadeOut.call(this.team.color_back, 0, time_);
}

function BackColorFilterOut( a_, r_, g_, b_, time_ )
{
	this.ClearColorFilterEffect();
	local t_ = {};
	t_.init <- this.EF_FadeBackScreen;
	t_.pare <- this.weakref();
	this.team.color_back = ::actor.effect_mgr.CreateActor2D(this.effect_class, 0, 0, 1,00000000.0, this.effect_class.EF_CommonInit, t_).weakref();
	this.EF_Set_FadeColor.call(this.team.color_back, a_, r_, g_, b_);
	this.EF_BeginBackFadeIn.call(this.team.color_back, 0, time_);
}

function ClearColorFilterEffect()
{
	if (this.team.color_back)
	{
		this.team.color_back.Release();
		this.team.color_back = null;
	}
}

function EraceBackGround( t_ = true )
{
	if (t_)
	{
		if (this.team.clearBackGroundCount == 0)
		{
			::graphics.ShowBackground(false);
		}

		this.team.clearBackGroundCount++;
	}
	else
	{
		if (this.team.clearBackGroundCount == 1)
		{
			::graphics.ShowBackground(true);
		}

		this.team.clearBackGroundCount--;

		if (this.team.clearBackGroundCount < 0)
		{
			this.team.clearBackGroundCount = 0;
		}
	}
}

function ResetBackGround()
{
	this.team.clearBackGroundCount = 0;
	::graphics.ShowBackground(true);
}

function SetSpellBack( t_ = true )
{
	if (t_)
	{
		if (this.team.spellBackCount == 0)
		{
			this.BackColorFilter(0,75000000.0, 0,00000000.0, 0,00000000.0, 0,00000000.0, 20);
		}

		this.team.spellBackCount++;
	}
	else
	{
		if (this.team.spellBackCount == 1)
		{
			this.BackColorFilterOut(0,75000000.0, 0,00000000.0, 0,00000000.0, 0,00000000.0, 20);
		}

		this.team.spellBackCount--;

		if (this.team.spellBackCount < 0)
		{
			this.team.spellBackCount = 0;
		}
	}
}

function SetSpellBackReset()
{
	this.team.spellBackCount = 0;
}

