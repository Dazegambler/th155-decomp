if ("_DEV" in this.getroottable() || !("_DEBUG" in this.getroottable()))
{
	::libact_instance <- ::libact.LoadPlugin("data/plugin/se_libact.dll");
}

::manbow.CompileFile("data/script/base.nut", this.getroottable());
::boot.Initialize();
