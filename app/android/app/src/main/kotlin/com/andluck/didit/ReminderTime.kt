package com.andluck.didit

import java.time.Instant
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZoneId

/** Rebuild each occurrence from a local date, never by adding 24-hour durations. */
object ReminderTime {
    fun next(
        now: Instant,
        zone: ZoneId,
        hour: Int,
        minute: Int,
        weekdays: Set<Int>,
        lastDeliveredDate: String? = null,
    ): Instant {
        require(hour in 0..23 && minute in 0..59)
        require(weekdays.isNotEmpty() && weekdays.all { it in 1..7 })
        val today = now.atZone(zone).toLocalDate()
        for (offset in 0L..7L) {
            val date: LocalDate = today.plusDays(offset)
            if (date.dayOfWeek.value !in weekdays || date.toString() == lastDeliveredDate) continue
            // atZone moves a nonexistent spring time through the gap and chooses
            // the earlier offset in an autumn overlap (one reminder per date).
            val candidate = date.atTime(LocalTime.of(hour, minute)).atZone(zone).toInstant()
            if (candidate > now) return candidate
        }
        error("No next reminder occurrence")
    }
}
