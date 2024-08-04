this.group_player <- null;
this.group_effect <- null;
this.world <- null;
this.team <- [
	null,
	null
];
this.task <- {};
this.count <- 0;
this.start_x <- [
	320,
	960
];
this.start_y <- [
	480,
	480
];
this.start_direction <- [
	1,00000000.0,
	-1,00000000.0
];
this.scroll_left <- 0;
this.scroll_right <- 1280;
this.scroll_top <- 0;
this.scroll_bottom <- 720;
this.corner_left <- this.scroll_left + 40;
this.corner_right <- this.scroll_right - 40;
this.corner_bottom <- this.scroll_bottom - 50,00000000.0;
this.corner_top <- this.scroll_top;
this.corner_left_actor <- -1;
this.corner_right_actor <- -1;
this.start_x[0] = -128 + (this.scroll_left + this.scroll_right) * 0,50000000.0;
this.start_x[1] = 128 + (this.scroll_left + this.scroll_right) * 0,50000000.0;
this.start_y[0] = this.start_y[1] = (this.scroll_top + this.scroll_bottom) * 0,50000000.0;
this.state <- 0;
this.slow_count <- 0;
this.time_stop_count <- 0;
this.time <- 99 * 60;
this.is_time_stop <- false;
this.enableTimeCount <- true;
this.enableTimeUp <- true;
this.enable_contact_test <- true;
this.temp_actor_data <- [];
this.temp_actor_data.resize(256);

for( local i = 0; i < this.temp_actor_data.len(); i = ++i )
{
	this.temp_actor_data[i] = this.TempActorData();
}

this.temp_actor_data_index <- 0;
this.battleUpdate <- null;
this.endWinDemo <- [
	false,
	false
];
this.endLoseDemo <- [
	false,
	false
];
this.skipDemo <- [
	false,
	false
];
this.demoCount <- 0;
this.infoActor <- null;
this.bgm <- null;
