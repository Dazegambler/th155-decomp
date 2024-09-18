function Reset_PlayerCommon( round_ = false )
{
	this.spellBaria = null;
	this.spellBack = null;
	this.guardEffect = null;
	this.grazeEffect = [];
	this.spellBackTime = 0;
	this.spellEndFunc = null;
	this.autoCamera = true;
	this.cameraPos = this.Vector3();
	this.DrawActorPriority(190);
	this.isVisible = true;
	this.masterAlpha = 1.00000000;
	this.masterRed = 1.00000000;
	this.masterGreen = 1.00000000;
	this.masterBlue = 1.00000000;
	this.alpha = 1.00000000;
	this.red = 1.00000000;
	this.green = 1.00000000;
	this.blue = 1.00000000;
	this.rz = 0.00000000;
	this.sx = this.sy = 1.00000000;
	this.isActive = true;
	this.func = null;
	this.baria = false;
	this.guardBaria = false;
	this.guardBariaCount = 0;
	this.ResetSpeed();
	this.event_getAttack = null;
	this.event_getDamage = null;
	this.event_motionEnd = null;
	this.event_defeat = null;
	this.pEvent_getDamage = null;
	this.lavelClearEvent = null;
	this.debuff_hate = this.Debuff();
	this.debuff_fear = this.Debuff();
	this.debuff_hyper = this.Debuff();
	this.debuff_animal = this.Debuff();
	this.debuff_poison = this.Debuff();
	this.BuffReset();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = 0;
	this.flag3 = 0;
	this.flag4 = 0;
	this.flag5 = 0;
	this.enableKO = true;
	this.centerStop = 0;
	this.centerStopCheck = 0;
	this.dashCount = 0;
	this.slideCount = 0;
	this.airSlide = false;
	this.change_reserve = false;

	if (this.hyouiAura)
	{
		this.hyouiAura.Release();
	}

	this.hyouiAura = null;
	this.invinBoss = 0;
	this.invin = 0;
	this.invinGrab = 0;
	this.invinObject = 0;
	this.graze = 0;
	this.grazeCount = 0;
	this.armor = 0;
	this.force_counter = 0;
	this.hitStopTime = 0;
	this.damageStopTime = 0;
	this.autoGuardCount = 0;
	this.forceBariaCount = 0;
	this.disableDash = 0;
	this.disableGuard = 0;
	this.stanCount = 0;
	this.stanBossCount = 0;
	this.endure = 0;
	this.endureCount = 0;
	this.freeMap = false;
	this.collisionFree = false;
	this.enableStandUp = true;
	this.HitReset();
	this.attackTarget = null;
	this.vf = this.Vector3();
	this.va = this.Vector3();
	this.vfBaria = this.Vector3();
	this.atkRate = 1.00000000;
	this.defRate = 1.00000000;
	this.baseAtkRate = 1.00000000;
	this.baseDefRate = 1.00000000;
	this.shield_rate = 1;
	this.shotGuardRate = 1.00000000;
	this.shotGuardCount = 0;
	this.atkBuff = [];
	this.option = [];
	this.linkObject = [];
	this.afterImage = null;
	this.occultAura = null;
	this.shield_body = null;
	this.shield = null;
	this.shot_actor = ::manbow.Actor2DProcGroup();
	this.koExp = false;
	this.ko_slave = false;
	this.disableDash = 0;

	if (this.resetFunc)
	{
		this.resetFunc.call(this);
	}

	this.SetUpdateFunction(this.Update_Normal);
	this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
	this.Stand_Init.call(this, null);
	this.rx = 0.00000000;
	this.ry = 0.00000000;
	this.rz = 0.00000000;
	this.sx = this.sy = 1.00000000;
	this.FitBoxfromSprite();
}

function AI_PlayerCommon()
{
	this.vf = this.Vector3();
	this.va = this.Vector3();
	this.vfBaria = this.Vector3();
	this.SetContactTestCallbackFunction(this.StoreActorData);
	this.hitOwner = this.weakref();
	this.hitTarget = {};
	this.owner = this.weakref();
	this.actorType = 1;
	this.hitAction = this.PlayerhitAction_Normal;
	this.guardAction = this.PlayerGuardAction_Normal;
	this.justGuardAction = this.PlayerGuardAction_Just;
	this.enableJustGuard = true;
	this.guardMissAction = this.PlayerMissGuardAction_Normal;
	this.guardCrashAction = this.PlayerGuardCrashAction_Normal;
	this.colorFunction = this.CommonColorUpdate;
	this.func_beginDemo = this.CommonBegin;
	this.func_beginDemoSkip = this.CommonBeginBattleSkip;
	this.func_timeDemo = this.CommonWin;
	this.func_winDemo = this.CommonWin;
	this.spellList = [];
	this.SetEndTakeCallbackFunction(this.KeyActionCheck);
}

function Test_Motion( force_ = false )
{
}

