::replay <- {};
::manbow.CompileFile("data/script/replay.nut", ::replay);
::camera <- {};
::manbow.CompileFile("data/script/camera.nut", ::camera);
::actor <- {};
::manbow.CompileFile("data/script/actor.nut", ::actor);
::spell <- {};
::manbow.CompileFile("data/script/spell.nut", ::spell);
::stage <- {};
::manbow.CompileFile("data/script/stage.nut", ::stage);
::battle <- {};
::manbow.CompileFile("data/script/battle/battle.nut", ::battle);
::talk <- {};
::manbow.CompileFile("data/script/talk/talk.nut", ::talk);
::story <- {};
::manbow.CompileFile("data/script/scene/story.nut", ::story);
::vs <- {};
::manbow.CompileFile("data/script/scene/vs.nut", ::vs);
::practice <- {};
::manbow.CompileFile("data/script/scene/practice.nut", ::practice);
::tutorial <- {};
::manbow.CompileFile("data/script/scene/tutorial.nut", ::tutorial);
::watch <- {};
::manbow.CompileFile("data/script/scene/watch.nut", ::watch);
::ed <- {};
::manbow.CompileFile("data/system/ed/ed.nut", ::ed);
::menu <- {};
::manbow.CompileFile("data/script/menu.nut", ::menu);
::trophy <- {};
::manbow.CompileFile("data/script/trophy.nut", ::trophy);
local seed = ::manbow.timeGetTime();
this.srand(seed);
