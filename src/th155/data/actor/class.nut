class this.ActorBase 
{
	life = 0;
	lifeMax = 0;
	regainLife = 0;
	getDamageVal = 0;
	hitStopTime = 0;
	damageStopTime = 0;
	bottomPos = 0;
	wall = 0;
	ground = 0;
	attackTarget = null;
	damageTarget = null;
	atkOwner = null;
	hitTable = null;
	callbackGroup = 0;
	hitResult = 0;
	hitGroup = null;
	hitAction = null;
	hitBackFlag = 0;
	bariaBackFlag = 0;
	forceKnock = null;
	armorEvent = null;
	reflectEvent = null;
	throwEvent = null;
	lavelClearEvent = null;
	firstHitRate = 1,00000000.0;
	linkObject = null;
	afterImage = null;
	popularAura = null;
	chargeAura = null;
	occultAura = null;
	enableSlow = false;
}

class this.ActorCommon extends this.ActorBase
{
	sp = 0,00000000.0;
	spMax = 0;
	selectSpell = 0;
	stan = 0;
	stanMax = 100;
	stanCount = 0;
	stanBossCount = 0;
	endure = 0;
	endureMax = 200;
	endureCount = 0;
	guard = 1000;
	guardMax = 1000;
	guardMaxBase = 1000;
	guardRecover = 0;
	recover = 0;
	enableStandUp = true;
	enableKO = true;
	centerStop = 0;
	centerStopCheck = 0;
	baseGravity = 0,00000000.0;
	invinBoss = 0;
	invin = 0;
	invinGrab = 0;
	invinObject = 0;
	baria = false;
	guardBaria = false;
	guardBariaCount = 0;
	graze = 0;
	armor = 0;
	hitCount = 0;
	hitDistance = 0;
	grazeCount = 0;
	cancelCount = 0;
	autoGuard = false;
	autoGuardCount = 0;
	autoBaria = 0;
	autoEvade = 0;
	disableGuard = 0;
	guardAction = null;
	guardMissAction = null;
	guardCrashAction = null;
	justGuardAction = null;
	enableJustGuard = true;
	pushGuardAction = null;
	comboResetCount = 0;
	firstRate = 1,00000000.0;
	mainHitRate = 1,00000000.0;
	minRate = 1,00000000.0;
	comboNum = 0;
	comboDamage = 0;
	counterDamage = 1,00000000.0;
	atkRate = 1,00000000.0;
	atkRate_Pat = 1,00000000.0;
	defRate = 1,00000000.0;
	guardRate = 1,00000000.0;
	shield_rate = 1;
	spRate = 1,00000000.0;
	baseAtkRate = 1,00000000.0;
	baseDefRate = 1,00000000.0;
	item0_defRateA = 1,00000000.0;
	item1_boost = 0;
	item1_guardRate = 1,00000000.0;
	item7_defRateA = 1,00000000.0;
	item7_defRateB = 1,00000000.0;
	item7_guardRateB = false;
	resetFunc = null;
	resetPracticeFunc = null;
	resetTimeUpFunc = null;
	resetKoFunc = null;
	resetDownFunc = null;
}

class this.PlayerData extends this.ActorCommon
{
	autoCamera = true;
	cameraPos = null;
	colorFunction = null;
	colorAvoid = 1,00000000.0;
	masterAlpha = 1,00000000.0;
	masterRed = 1,00000000.0;
	masterGreen = 1,00000000.0;
	masterBlue = 1,00000000.0;
	occultAlpha = 1,00000000.0;
	spellBack = null;
	spellBackTime = 0;
	spellBaria = null;
	guardEffect = null;
	grazeEffect = null;
	func_beginDemo = null;
	func_beginDemoSkip = null;
	func_timeDemo = null;
	func_winDemo = null;
	demoObject = null;
	type = 0;
	input = null;
	command = null;
	dashCount = 0;
	slideCount = 0;
	airSlide = false;
	mana = 1000;
	manaStopCount = 0;
	manaRegain = 8;
	avoidCount = 0;
	freeMap = false;
	collisionFree = false;
	atkRange = 100,00000000.0;
	baseBuff = null;
	atkBuff = null;
	debuff_animal = null;
	debuff_hate = null;
	debuff_poison = null;
	debuff_fear = null;
	debuff_hyper = null;
	event_getAttack = null;
	event_getDamage = null;
	event_motionEnd = null;
	event_defeat = null;
	pEvent_getDamage = null;
	callSpellObject = null;
	spellCardName = null;
	spellList = null;
	climaxName = null;
	spellEndFunc = null;
	itemParam = null;
	itemFunc = null;
	equip = null;
	slotItem = null;
	faith_S = 0;
	faith_D = 0;
	faith_B = 0;
	faithType = 0;
	occult = 0;
	okltBall = 0;
	lostBall = 0;
	okltCharge = 0;
	occultBoost = false;
	rushList = null;
	rushFlag = null;
	rushSkill = false;
	comboWall = 0;
	comboFloor = 0;
	comboUpper = 0;
	comboUnder = 0;
	cpu_senser = null;
	cpu_bossSpell = null;
	cpu_bossSpellName = null;
	cpu_bossSpellFunc = null;
	cpu_bossSpellCount = 0;
	cpu_bossSpellSelect = 0;
	cpu_bossSpellLifeLine = 100;
	cpu_storyDemo = null;
	cpu_type = 0;
	cpu_level = 0;
	cpu_count = 0;
	targetDist = 0;
	targetHeight = 0;
	cpu_guard = 0;
	cpu_baria = 0;
	cpu_rand = 0;
	cpu_rand_def = 0;
	cpu_front = 1,00000000.0;
	com_dash = 0,00000000.0;
	cpu_command = 0;
	cpu_DisableAttack = 0;
	cpu_flag1 = 0;
	cpu_flag2 = 0;
	cpu_flag3 = 0;
	cpu_flag4 = 0;
	cpu_flag5 = 0;
	cpu_keyFlag = null;
	koExp = false;
	cpu_search = null;
	cpu_guardStance = 0;
	cpu_aggroStance = 0;
	cpu_sleep = 0;
	cpu_enemyPos = 0;
	score = 0;
	finishArt = 0;
	disableDash = 0;
	avoidEventF = null;
	avoidEventV = null;
	avoidEventH = null;
	atc_popularA = null;
	atc_popularB = null;
	atc_bariaWait = null;
	atc_occultAura = null;
	bossShotActor = null;
	practiceUpdate = null;
}

class this.ObjectData extends this.ActorCommon
{
	centerStop = 0;
	pEvent_getDamage = null;
}

class this.EffectData 
{
	linkObject = null;
	afterImage = null;
}

class this.HitState 
{
	damage = 0;
	direction = 0,00000000.0;
	knockFlag = 0;
	atkRank = 0;
	atkType = 0;
	hitVecX = 0,00000000.0;
	hitVecY = 0,00000000.0;
	grazeKnock = 0,00000000.0;
	stopVecX = 0,00000000.0;
	stopVecY = 0,00000000.0;
	recover = 0;
	forceKnock = false;
}

class this.Debuff 
{
	time = 0;
	object = null;
}

class this.BossAttack 
{
	lifeMax = 10000;
	ID = 0;
}

class this.ObjectBase 
{
	name = null;
	owner = null;
	callbackGroup = null;
	scale = 1,00000000.0;
	rz = 0,00000000.0;
	priority = 0;
	flag1 = 0;
	flag2 = 0;
	flag3 = 0;
	baseAtk = 0;
	atkOffset = 0,10000000.0;
}

