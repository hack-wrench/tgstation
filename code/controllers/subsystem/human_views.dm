/// The subsystem used to tick [/mob/living/carbon/human/proc/view_humans_around()]
SUBSYSTEM_DEF(human_views)
	name = "Human Views"
	priority = FIRE_PRIORITY_HUMAN_VIEWS
	wait = 0.5 SECONDS
	flags = SS_NO_INIT|SS_BACKGROUND
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME

	var/list/mob/living/carbon/human/moved_humans = list()

// calling view_humans_around
/datum/controller/subsystem/human_views/fire(resumed)
	while(length(moved_humans))
		var/mob/living/carbon/human/human = moved_humans[1]
		moved_humans.Cut(1, 2)

		if(istype(human))
			human.view_humans_around()

		if(MC_TICK_CHECK)
			break

// adding moved human without duplicates
/datum/controller/subsystem/human_views/proc/add_moved_human(mob/living/carbon/human/moved_human)
	if(moved_human in moved_humans)
		return

	moved_humans += moved_human
