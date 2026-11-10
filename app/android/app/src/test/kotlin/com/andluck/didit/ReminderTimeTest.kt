package com.andluck.didit

import org.junit.Assert.assertEquals
import org.junit.Test
import java.time.Instant
import java.time.ZoneId

class ReminderTimeTest {
    private val daily = (1..7).toSet()

    @Test fun laterToday() {
        assertEquals(Instant.parse("2026-11-10T04:00:00Z"), ReminderTime.next(
            Instant.parse("2026-11-10T03:00:00Z"), ZoneId.of("Asia/Qyzylorda"), 9, 0, daily))
    }

    @Test fun exactBoundaryMovesForward() {
        assertEquals(Instant.parse("2026-11-11T09:00:00Z"), ReminderTime.next(
            Instant.parse("2026-11-10T09:00:00Z"), ZoneId.of("UTC"), 9, 0, daily))
    }

    @Test fun selectedWeekdayRollsToNextWeek() {
        assertEquals(Instant.parse("2026-11-17T09:00:00Z"), ReminderTime.next(
            Instant.parse("2026-11-10T09:01:00Z"), ZoneId.of("UTC"), 9, 0, setOf(2)))
    }

    @Test fun springGapMovesForward() {
        assertEquals(Instant.parse("2026-03-08T07:30:00Z"), ReminderTime.next(
            Instant.parse("2026-03-08T05:00:00Z"), ZoneId.of("America/New_York"), 2, 30, daily))
    }

    @Test fun autumnOverlapUsesFirstOccurrence() {
        assertEquals(Instant.parse("2026-11-01T05:30:00Z"), ReminderTime.next(
            Instant.parse("2026-11-01T04:00:00Z"), ZoneId.of("America/New_York"), 1, 30, daily))
    }

    @Test fun deliveredDateIsNotRepeatedAfterClockGoesBack() {
        assertEquals(Instant.parse("2026-11-02T06:30:00Z"), ReminderTime.next(
            Instant.parse("2026-11-01T05:00:00Z"), ZoneId.of("America/New_York"), 1, 30, daily, "2026-11-01"))
    }

    @Test fun timezoneChangeKeepsWallClockTime() {
        val now = Instant.parse("2026-11-10T00:00:00Z")
        assertEquals(Instant.parse("2026-11-10T14:00:00Z"), ReminderTime.next(now, ZoneId.of("America/New_York"), 9, 0, daily))
        assertEquals(Instant.parse("2026-11-10T09:00:00Z"), ReminderTime.next(now, ZoneId.of("UTC"), 9, 0, daily))
    }

    @Test(expected = IllegalArgumentException::class) fun noDaysIsInvalid() {
        ReminderTime.next(Instant.now(), ZoneId.of("UTC"), 9, 0, emptySet())
    }
}
